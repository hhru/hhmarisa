cimport key

cdef extern from "<marisa/agent.h>" namespace "marisa" nogil:
    cdef cppclass Agent:
        Agent() except +

        key.Key &key()

        void set_query(char *str)
        void set_query(char *ptr, int length)

