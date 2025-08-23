import unittest
from calculator import scitani

class TestCalculator(unittest.TestCase):
    def test_scitani_kladna(self):
        self.assertEqual(scitani(5, 3), 8)

    def test_scitani_zaporna(self):
        self.assertEqual(scitani(-2, -7), -9)

    def test_scitani_nula(self):
        self.assertEqual(scitani(0, 5), 5)

if __name__ == "__main__":
    unittest.main(verbosity=2)
