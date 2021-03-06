#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tempfile, unittest
from module import module

class Conf(object): pass

class TestResolveAuthSecret(unittest.TestCase):
    def test_auth_secret_is_sufficient(self):
        conf = Conf()
        conf.auth_secret = 'foobar'

        res = module.resolve_auth_secret(conf)
        self.assertEqual(res, 'foobar')

    def test_auth_secret_file_is_sufficient(self):
        with tempfile.NamedTemporaryFile() as asf:
            asf.write('baz')
            asf.flush()

            conf = Conf()
            conf.auth_secret_file = asf.name
            res = module.resolve_auth_secret(conf)
            self.assertEqual(res, 'baz')

    def test_auth_secret_wins_over_file(self):
        with tempfile.NamedTemporaryFile() as asf:
            asf.write('baz')
            asf.flush()

            conf = Conf()
            conf.auth_secret = 'foobar'
            conf.auth_secret_file = asf.name
            res = module.resolve_auth_secret(conf)
            self.assertEqual(res, 'foobar')

    def test_auth_secret_file_autogenerated(self):
        conf = Conf()
        with tempfile.NamedTemporaryFile() as asf:
            conf.auth_secret_file = asf.name
        res = module.resolve_auth_secret(conf)
        self.assert_(len(res) == 32)

    def test_auth_secret_file_is_persistent(self):
        conf = Conf()
        with tempfile.NamedTemporaryFile() as asf:
            conf.auth_secret_file = asf.name
        res1 = module.resolve_auth_secret(conf)
        res2 = module.resolve_auth_secret(conf)
        self.assertEqual(res1, res2)


if __name__ == '__main__':
    unittest.main()
