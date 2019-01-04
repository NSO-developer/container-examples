# -*- mode: python; python-indent: 4 -*-
import datetime

import ncs
from ncs.dp import Action

ready = False

class Ready(Action):
    @Action.action
    def cb_action(self, uinfo, name, kp, input, output):
        global ready
        if not ready:
            raise Exception("I'm not ready!")
        output.result = str(datetime.datetime.now())


class SetReady(Action):
    @Action.action
    def cb_action(self, uinfo, name, kp, input, output):
        global ready
        ready = True


alive = True


class Alive(Action):
    @Action.action
    def cb_action(self, uinfo, name, kp, input, output):
        global alive
        if not alive:
            raise Exception("I'm dead!")
        output.result = str(datetime.datetime.now())


class SetDead(Action):
    @Action.action
    def cb_action(self, uinfo, name, kp, input, output):
        global alive
        alive = False


class Main(ncs.application.Application):
    def setup(self):
        self.log.info('Main RUNNING')

        self.register_action('lr-test-ready', Ready)
        self.register_action('lr-test-set-ready', SetReady)
        self.register_action('lr-test-alive', Alive)
        self.register_action('lr-test-set-dead', SetDead)

    def teardown(self):
        self.log.info('Main FINISHED')
