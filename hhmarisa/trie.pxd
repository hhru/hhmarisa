cimport agent


cdef extern from "<marisa/trie.h>" namespace "marisa" nogil:

    cdef cppclass Trie:
        Trie()

        void load(char *filename) nogil except +

        bint predictive_search(agent.Agent &agent) except +

        void clear() except +

