import timeit

np = "import numpy as np;"
tests = {
    "mutmul": "np.random.rand(2000, 2000) @ np.random.rand(2000, 2000)",
    "eig": "np.linalg.eig(np.random.rand(1000,1000))",
    "svd": "np.linalg.svd(np.random.rand(1000,1000))",
    "inv": "np.linalg.inv(np.random.rand(1000,1000))",
    "det": "np.linalg.det(np.random.rand(1000,1000))",
}
for k, v in tests.items():
    print("%s %f" % (k, timeit.timeit(np+v, number=10) * 1000))