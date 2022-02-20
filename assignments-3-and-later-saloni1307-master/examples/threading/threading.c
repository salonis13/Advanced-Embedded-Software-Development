#include "threading.h"
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

pthread_t myThread;
// Optional: use these functions to add debug or error prints to your application
#define DEBUG_LOG(msg,...)
//#define DEBUG_LOG(msg,...) printf("threading: " msg "\n" , ##__VA_ARGS__)
#define ERROR_LOG(msg,...) printf("threading ERROR: " msg "\n" , ##__VA_ARGS__)

void* threadfunc(void* thread_param)
{
	struct thread_data* thread_func_args = (struct thread_data *) thread_param;
	int rc;
    // TODO: wait, obtain mutex, wait, release mutex as described by thread_data structure

	//wait to obtain mutex
	rc = usleep((thread_func_args->wait_to_obtain_ms)*1000);
	if(rc != 0) {
		ERROR_LOG("usleep_obtain failed");
		return thread_param;
	}

	//lock mutex if avaiable
    	rc = pthread_mutex_lock(thread_func_args->data_mutex);
	if(rc != 0) {
		ERROR_LOG("pthread_mutex_lock failed");
		return thread_param;
	}

	//wait before releasing mutex
	rc = usleep((thread_func_args->wait_to_release_ms)*1000);
	if(rc != 0) {
		ERROR_LOG("usleep_release failed");
		return thread_param;
	}

	//release mutex
	rc = pthread_mutex_unlock(thread_func_args->data_mutex);
	if(rc != 0) {
		ERROR_LOG("pthread_mutex_unlock failed");
		return thread_param;
	}
    // hint: use a cast like the one below to obtain thread arguments from your parameter
    //struct thread_data* thread_func_args = (struct thread_data *) thread_param;
    thread_func_args->thread_complete_success=true;
    return thread_param;
}


bool start_thread_obtaining_mutex(pthread_t *thread, pthread_mutex_t *mutex,int wait_to_obtain_ms, int wait_to_release_ms)
{

	int rc;
    /**
     * TODO: allocate memory for thread_data, setup mutex and wait arguments, pass thread_data to created thread
     * using threadfunc() as entry point.
     *
     * return true if successful.
     * 
     * See implementation details in threading.h file comment block
     */
	struct thread_data *thread_p = malloc(sizeof(struct thread_data));

	//initialize thread_data structure
	thread_p->data_mutex=mutex;
	thread_p->wait_to_obtain_ms=wait_to_obtain_ms;
	thread_p->wait_to_release_ms=wait_to_release_ms;
	thread_p->thread_complete_success= false;

	DEBUG_LOG("Initialization complete");

	//create thread
	rc = pthread_create(&myThread, NULL, &threadfunc, thread_p);
	if(rc != 0) {
		ERROR_LOG("pthread_create failed");
		return false;
	}

	DEBUG_LOG("Thread executed successfully");

	//return threadID
	*thread = myThread;
	return true;
}

