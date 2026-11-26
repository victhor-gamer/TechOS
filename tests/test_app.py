import importlib.util
import pathlib
import unittest

APP_PATH = (
    pathlib.Path(__file__).resolve().parents[1]
    / "apps"
    / "techos-welcome"
    / "src"
    / "techos_welcome.py"
)

SPEC = importlib.util.spec_from_file_location("techos_welcome", APP_PATH)
APP = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(APP)


class TechOSWelcomeTests(unittest.TestCase):
    def test_project_url_is_github_repository(self):
        self.assertEqual(APP.PROJECT_URL, "https://github.com/victhor-gamer/TechOS")

    def test_system_summary_contains_expected_labels(self):
        summary = APP.system_summary()
        self.assertIn("Architecture:", summary)
        self.assertIn("Python:", summary)
        self.assertIn("System:", summary)


if __name__ == "__main__":
    unittest.main()
