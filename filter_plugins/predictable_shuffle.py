from ansible import errors
import hashlib
import itertools

def predictable_shuffle(array, key):
    ''' returns a predictable_shuffled list '''
    nameservers_permutation = list(itertools.permutations(array))
    number_of_permutation = len(nameservers_permutation)
    index = int(hashlib.sha256(key).hexdigest(), 16) % number_of_permutation
    return nameservers_permutation[index]

class FilterModule(object):
    ''' A filter to predictable_shuffle a list '''
    def filters(self):
        return {
            'predictable_shuffle' : predictable_shuffle,
        }
