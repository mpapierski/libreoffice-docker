import unittest
import os
import subprocess

DOCKER_IMAGE = os.environ.get('DOCKER_IMAGE', 'mpapierski/libreoffice')


def soffice(args):
    return subprocess.check_output(['docker', 'run', '--rm', '-it', '-v', os.getcwd() + ':/docs', DOCKER_IMAGE] + args)


class TestCase(unittest.TestCase):

    def test_lorem1(self):
        stdout = soffice(['--cat', '/docs/assets/lorem1.doc'])
        with open('assets/lorem.txt', 'rb') as f:
            self.assertEqual(f.read(), stdout)

    def test_lorem2(self):
        stdout = soffice(['--cat', '/docs/assets/lorem2.docx'])
        with open('assets/lorem.txt', 'rb') as f:
            self.assertEqual(f.read(), stdout)

if __name__ == '__main__':
    unittest.main()
