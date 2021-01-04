#include <bcl.hpp>

class IntArray {
    public:
        IntArray(){
            this->size = 4;
            this->count = 0;
            this->data = new int[4];
        }
        IntArray(IntArray& other){
            delete this->data;
            this->size = other.size;
            this->count = other.count;
            for(int i = 0; i < other.count; i++)
                this->data[i] = other.data[i];
        }
        ~IntArray(){
            delete this->data;
            this->size = 0;
            this->count = 0;
        }
        IntArray& operator=(IntArray& other){
            delete this->data;
            this->size = other.size;
            this->count = other.count;
            for(int i = 0; i < other.count; i++)
                this->data[i] = other.data[i];
        }
        IntArray&& operator=(IntArray&& other){
            delete this->data;
            this->size = other.size;
            this->count = other.count;
            this->data = other.data;

            other.data = nullptr;
            other.size = 0;
            other.count = 0;
        }
    private:
        int size;
        int count;
        int* data;
};