cdef extern from "<marisa/key.h>" namespace "marisa" nogil:

    cdef cppclass Key:
        char *ptr()
        int length()

