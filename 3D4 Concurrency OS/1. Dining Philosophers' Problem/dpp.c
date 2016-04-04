#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>

#define MAX_ITERATIONS 100
#define NUM_PHILOSOPHERS 5
#define NUM_FORKS 5
#define WAIT_COEFF 1000
#define TIME_COEFF 10000

static pthread_t philosopher[NUM_PHILOSOPHERS];
static pthread_mutex_t fork[NUM_FORKS] = {
    PTHREAD_MUTEX_INITIALIZER,
    PTHREAD_MUTEX_INITIALIZER,
    PTHREAD_MUTEX_INITIALIZER,
    PTHREAD_MUTEX_INITIALIZER,
    PTHREAD_MUTEX_INITIALIZER
};
static pthread_mutex_t eat_lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t wait_lock = PTHREAD_MUTEX_INITIALIZER;

int iterations = 0, tot_waiting_iterations = 0, max_waiting_time = 0, lowest_waiting_time = WAIT_COEFF;
long tot_waiting_time = 0;

//timing helpers
long generate_random_wait(int p_id);
void wait(long duration);
void* generate_state_choice(void* arg);

//statial behaviour cycle
int get_left_fork(int p_id);
int get_right_fork(int p_id);
int acquire_forks(int p_id);
void release_forks(int p_id);
void eat(int p_id);
void think(int p_id);

int main(void)
{
	int f, p, rc;
	for(p = 0; p < NUM_PHILOSOPHERS; p++)
	{
	  rc = pthread_create(&philosopher[p], NULL, generate_state_choice, (void*) p);
	  if(rc)
	  {
	    printf("\ncreate error\n");
	    return -1;
	  }
	}
	
	for(p = 0; p < NUM_PHILOSOPHERS; p++)
	{
	  rc = pthread_join(philosopher[p], NULL);
	}
	
	printf("\n\n************exiting**************\n\n");
	printf("\nwaiting iterations: %d", tot_waiting_iterations);
	printf("\nmax eating iterations: %d", MAX_ITERATIONS);
	printf("\nwaiting time: %ldus", tot_waiting_time);
	printf("\nmax time: %ldus", max_waiting_time);
	printf("\nlowest time: %ldus", lowest_waiting_time);
	printf("\naverage waiting time: %dus\n", tot_waiting_time / tot_waiting_iterations);
}

//timing helpers
long generate_random_wait(int p_id)
{
  long time = lrand48() / TIME_COEFF; 
  printf("\nAgent %d is waiting for %ldus\n", p_id, time);
  pthread_mutex_lock(&wait_lock);
  if(time > max_waiting_time)
    max_waiting_time = time;
  if(time < lowest_waiting_time)
  	lowest_waiting_time = time;
  tot_waiting_time += time;
  pthread_mutex_unlock(&wait_lock);
  return time;
}

void wait(long duration)
{
  usleep(duration);
}

void* generate_state_choice(void* arg)
{
	//thread safe drand48() -- do not use seeded values via rand()
  int num = drand48() * WAIT_COEFF;
  int p_id = (int) arg;
  printf("\n*****************Random number chosen is %d\n", num);
  if(num < 50)
  {
    think(p_id);
  }
  else
  {
    eat(p_id);
  }
}

//statial behaviour cycle
int get_left_fork(int p_id)
{ 
  return p_id;
}

int get_right_fork(int p_id)
{
  return (p_id == 4) ? 0 : p_id + 1;
}

int acquire_forks(int p_id)
{
	printf("\nAgent %d is acquiring forks\n", p_id);
	
  if(pthread_mutex_trylock(&fork[get_left_fork(p_id)]) &&
      pthread_mutex_trylock(&fork[get_right_fork(p_id)]))
  {
    //acquired -- invoke eating
    printf("\nAyyy lmao, agent %d is obtaining forks\n", p_id);
    //printf("\nid %d, left fork %d, right fork %d\n", p_id, get_left_fork(p_id), get_right_fork(p_id));
    return 1;
  }
  else
  {
    //already acquired by another agent -- return to thinking
    printf("\nAgent %d cannot obtain forks -- thinking\n", p_id);
    return 0;
  }
}

void release_forks(int p_id)
{
    pthread_mutex_unlock(&fork[get_left_fork(p_id)]);
    pthread_mutex_unlock(&fork[get_right_fork(p_id)]);
}

void eat(int p_id)
{
	int result = acquire_forks(p_id);
  if(result == 1)
  {
    printf("\nAgent %d is eating\n", p_id);
    printf("\nForks %d and %d are locked!\n", get_left_fork(p_id), get_right_fork(p_id));
    wait(generate_random_wait(p_id));
    printf("OM NOM NOM NOM NOM NOM NOM");
    release_forks(p_id);
    printf("\nForks %d and %d are unlocked!\n", get_left_fork(p_id), get_right_fork(p_id));
    printf("Agent %d is mildly satisfied and is returning to the arts life\n", p_id);
    
    pthread_mutex_lock(&eat_lock);
    iterations++;
    printf("\niteration #%d\n", iterations);
    pthread_mutex_unlock(&eat_lock);
    think(p_id);
  }
  else
  {
    think(p_id);
  }
}

void think(int p_id)
{
  if(iterations >= MAX_ITERATIONS)
  {
    pthread_exit(NULL);
  }
  else
  {
    printf("Agent %d is thinking ... *poor course choices*\n", p_id);
    pthread_mutex_lock(&eat_lock);
    tot_waiting_iterations++;
    pthread_mutex_unlock(&eat_lock);
    wait(generate_random_wait(p_id));
    eat(p_id);
  }
}
