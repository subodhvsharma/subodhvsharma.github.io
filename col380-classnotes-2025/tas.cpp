class TASLock {
private:
    std::atomic_flag lock_flag = ATOMIC_FLAG_INIT; // initialized to false
    
public:
    void lock() {
        // Spin until we successfully acquire the lock
        while (lock_flag.test_and_set(std::memory_order_acquire)) {
            // Lock was already held, keep spinning
        }
    }
    
    void unlock() {
        lock_flag.clear(std::memory_order_release);
    }
};

// Usage
TASLock my_lock;
int shared_counter = 0;

void increment_counter() {
    my_lock.lock();
    shared_counter++;  // Critical section
    my_lock.unlock();
}


/*
How it works:

Initially, lock_flag is false

Thread A calls lock(): TAS reads false, sets to true, returns false →
exits loop

Thread B calls lock(): TAS reads true, sets to true, returns true →
keeps spinning

When A calls unlock(), flag becomes false

Thread B's next TAS reads false, sets to true, returns false →
acquires lock

*/
