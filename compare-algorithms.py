# reference https://github.com/NiaOrg/NiaPy/tree/master/examples
import numpy as np
from niapy import Runner
from niapy.algorithms.basic import (
    FireflyAlgorithm,
    ParticleSwarmAlgorithm
)
from niapy.problems import (
    Problem,
    Ackley,
    Griewank,
    Sphere,
    HappyCat
)

"""Example demonstrating the use of niapy Runner."""


class MyProblem(Problem):
    def __init__(self, dimension, lower=-10, upper=10, *args, **kwargs):
        super().__init__(dimension, lower, upper, *args, **kwargs)

    def _evaluate(self, x):
        return np.sum(x ** 2)


runner = Runner(dimension=40, max_evals=100, runs=2, algorithms=[
    FireflyAlgorithm(),
    "FlowerPollinationAlgorithm",
    ParticleSwarmAlgorithm(),
    "HybridBatAlgorithm",
    "SimulatedAnnealing",
    "CuckooSearch"], problems=[
    Ackley(dimension=40),
    Griewank(dimension=40),
    Sphere(dimension=40),
    HappyCat(dimension=40),
    "rastrigin",
    MyProblem(dimension=40)
])

runner.run(export='json', verbose=True)

