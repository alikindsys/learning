#include <bcl.hpp>

class HeapDouble {
    public:
        HeapDouble(){
            this->value = new double;
        }
        HeapDouble(HeapDouble& other){
            this->value = new double;
            *(this->value) = *(other.value); 
        }
        HeapDouble(HeapDouble&& other){
            this->value = other.value;
            other.value = nullptr;
        }
        ~HeapDouble(){
            delete this->value;
        }
        HeapDouble& operator=(HeapDouble& other){
            if(&other == this) return;
            delete this->value;

            this->value = new double;
            *(this->value) = *(other.value);

            return *this;
        }
        HeapDouble& operator=(HeapDouble&& other){
            if(&other == this) return;
            delete this->value;

            this->value = other.value;
            other.value = nullptr;

            return *this;
        }
    private:
        double* value;
};