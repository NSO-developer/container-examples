# -*- mode: python; python-indent: 4 -*-
import datetime

import ncs
from ncs.dp import Action
import ncs.maapi as maapi
import ncs.maagic as maagic

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
        now = str(datetime.datetime.now())

        # Make sure we can open a write trans and write something to CDB
        with maapi.single_write_trans(uinfo.username, "alive") as th:
            k8s = maagic.get_node(th, "/lr-test:k8s")
            k8s.last_live_check = now
            th.apply()

        output.result = now


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
