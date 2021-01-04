#include <bcl.hpp>

class HeapDouble {
    public:
        HeapDouble(){
            this->value = new double;
        }
        HeapDouble(HeapDouble& other){
            delete this->value;
            *(this->value) = *(other.value); 
        }
        ~HeapDouble(){
            delete this->value;
        }
        HeapDouble& operator=(HeapDouble& other){
            delete this->value;
            this->value = new double;
            *(this->value) = *(other.value); 
        }
        HeapDouble&& operator=(HeapDouble&& other){
            delete this->value;
            this->value = other.value;
            other.value = nullptr;
        }
    private:
        double* value;
};