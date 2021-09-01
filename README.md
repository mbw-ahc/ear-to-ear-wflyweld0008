# Project reproduce WFLYWELD0008: @Resource injection of type javax.ejb.TimerService is not supported for non-ejb components.

# Setup
- Place a copy of JBoss EAP 7.3.8 in a directory called jboss-eap-7.3 at the root of this project. 

# Running
The following scripts are provided to automate the build/test cycle
To test on EAP7 
- .\build-and-deploy-73.bat -- runs maven clean and install and copies the two ear folders to the jboss instance
- .\startup-73.bat -- switches to the jboss bin directory and runs standalone.bat

# Structure

The kitchensink-ear is basically the same as the one from the quickstarts, two changes of note
* PersistenceContext annotations were updated to use JNDI loaded @Producers (required to get both ears to deploy)
* In kitchensink-ear-ejb, org.jboss.as.quickstarts.kitchensink_ear.service.SomeSingleton as added.  This 
a simple EJB that injects a TimerService

The dependent-ear is a second ear deployment that has a deployment dependency on the above kitchensink-ear.

The following message is logged
    [org.jboss.as.weld] (Weld Thread Pool -- 2) WFLYWELD0008: @Resource injection of type javax.ejb.TimerService is not supported for non-ejb components. Injection point: javax.ejb.TimerService org.jboss.as.quickstarts.kitchensink_ear.service.SomeSingleton.timerService

This is coming from the dependent-ear deployment based on my tracing into wildfly-weld.  It looks when dependent-ear is being deployed, CDI is
processing the classes in the kitchensink.ear due to the module dependency in jboss-deployment-structure.xml.
It sees SomeSingleton as a CDI bean, and warns that it should not be injecting a EJB TimerService.  But the class
is a really EJB.

Note that in kitchensink.ear the SomeSingleton EJB deploys fine, and has a TimerService injected based on this log message

    INFO  [org.jboss.as.quickstarts.kitchensink_ear.service.SomeSingleton] (ServerService Thread Pool -- 83) SomeSingleton started with timerService of org.jboss.as.ejb3.timerservice.NonFunctionalTimerService@59e4a79e

The problem is the WFLYWELD0008, we are looking for away to adjust the configuration to make that go away.  Probably also don't need CDI to try to process the ejbs in kitchensink-ear-ejb 

I do not beleive the issue is unique to 7.3.8, we have seen it in previous EAP 7.3.x releases as well.
