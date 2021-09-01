package org.jboss.as.quickstarts.kitchensink_ear.service;

import java.util.logging.Logger;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.ejb.TimerService;
import javax.inject.Inject;

/**
 * TODO describe this class
 *
 * @author Mark Wardell (Mark.Wardell@agfa.com)
 */
@Singleton
@Startup
public class SomeSingleton {

    @Inject
    private Logger log;

    @Resource
    TimerService timerService;

    @PostConstruct
    void postConstruct() {
        log.info("SomeSingleton started with timerService of " + timerService);
    }
}
