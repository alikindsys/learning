#include <bcl.hpp>

class LinearMap {
    public:
        LinearMap(){
            this->size = 4;
            this->count = 0;
            this->keys = new std::string[4];
            this->values = new int[4];
        }
        LinearMap(LinearMap& other){
            delete this->values;
            delete this-> keys;
            this->size = other.size;
            this->count = other.count;
            this->values = new int[this->size];
            this->keys = new std::string[this->size];
            for(int i = 0; i < other.count; i++){
                this->keys[i] = other.keys[i];
                this->values[i] = other.values[i];
            }
        }
        ~LinearMap(){
            delete this->values;
            delete this->keys;
            this->size = 0;
            this->count = 0;
        }
        LinearMap& operator=(LinearMap& other){
            delete this->values;
            delete this-> keys;
            
            this->size = other.size;
            this->count = other.count;
            this->values = new int[this->size];
            this->keys = new std::string[this->size];
            
            for(int i = 0; i < other.count; i++){
                this->keys[i] = other.keys[i];
                this->values[i] = other.values[i];
            }
        }
        LinearMap&& operator=(LinearMap&& other){
            delete this->values;
            delete this-> keys;
            
            this->size = other.size;
            this->count = other.count;
            this->values = other.values;
            this->keys = other.keys;
            
            other.keys = nullptr;
            other.values = nullptr;
            other.count = 0;
            other.size = 0;
        }
    private:
        int size;
        int count;
        std::string* keys;
        int* values;
};