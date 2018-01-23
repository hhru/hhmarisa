# distutils: language = c++

cimport agent
cimport trie


cdef class Agent:
    cdef agent.Agent _agent


cdef class Trie:
    cdef trie.Trie* _trie

    def __init__(self):
        self._trie = new trie.Trie()

    def __dealloc__(self):
        self._trie.clear()
        del self._trie

    def load(self, unicode path):
        """Load trie from file"""

        path_string = path.encode('utf8')
        cdef char* c_path = path_string
        with nogil:
            self._trie.load(c_path)

    def get_by_prefix(self, Agent agent, unicode key):
        """Get value from trie by prefix, excluding prefix. Returns unicode"""

        key_string = key.encode('utf8')
        cdef char* b_key = key_string
        cdef bint result

        with nogil:
            agent._agent.set_query(b_key)
            result = self._trie.predictive_search(agent._agent)

        if result:
            return agent._agent.key().ptr()[len(b_key):agent._agent.key().length()].decode('utf8')

    def get_by_prefix_b(self, Agent agent, bytes key):
        """Get value from trie by prefix, excluding prefix. Returns bytes"""

        cdef char* b_key = key
        cdef bint result

        with nogil:
            agent._agent.set_query(b_key)
            result = self._trie.predictive_search(agent._agent)

        if result:
            return agent._agent.key().ptr()[len(b_key):agent._agent.key().length()]

