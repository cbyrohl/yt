import numpy as np
cimport numpy as np
cimport cython

cdef extern from "math.h":
    double exp(double x) nogil

cdef double gfac = 1.0/np.sqrt(np.pi)

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
def compute_lines(np.ndarray[np.float64_t, ndim=1] E0,
                  np.ndarray[np.float64_t, ndim=1] sigma,
                  np.ndarray[np.float64_t, ndim=1] amp,
                  np.ndarray[np.float64_t, ndim=1] E):

    cdef int i, j, n
    cdef double x
    cdef np.ndarray[np.float64_t, ndim=1] lines

    n = E0.shape[0]
    m = E.shape[0]
    lines = np.zeros(m)

    for i in range(n):
        for j in range(m):
            x = (E[j]-E0[i])/sigma[i]
            lines[j] += amp[i]*gfac*exp(-x*x)/sigma[i]

    return lines
