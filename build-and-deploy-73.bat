call mvn clean install

ROBOCOPY /MIR kitchensink-ear\ear\target\kitchensink-ear jboss-eap-7.3\standalone\deployments\kitchensink-ear.ear  
ROBOCOPY /MIR dependant-ear\ear\target\dependant-ear jboss-eap-7.3\standalone\deployments\dependant-ear.ear  

DEL jboss-eap-7.3\standalone\deployments\kitchensink-ear.ear.*
DEL jboss-eap-7.3\standalone\deployments\dependant-ear.ear.*
echo > jboss-eap-7.3\standalone\deployments\kitchensink-ear.ear.dodeploy
echo > jboss-eap-7.3\standalone\deployments\dependant-ear.ear.dodeploy