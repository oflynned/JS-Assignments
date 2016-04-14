#ifndef N
#define N 5
#endif

bit forks[N];
byte count_eating;

init {
  atomic {
    byte i = 0;
    do
    ::(i < N-1) -> 
    	run Philosopher(i); 
    	i++;
    ::else -> 
    	run Phil_restart(i); 
    	break;
    od;
  }
}

proctype Philosopher(byte id) {
thinking:
  atomic { 
  	forks[id] == 0; -> 
  		forks[id] = 1; 
  }
choosing:
  atomic { 
  	forks[(id + 1)%N] == 0 -> 
  		forks[(id + 1)%N] = 1; 
  		count_eating++; 
  };
eating:
  d_step { 
  	count_eating--; 
  	forks[(id + 1)%N] = 0; 
  }
  forks[id] = 0;
  goto thinking;
}

proctype Phil_restart(byte id) {
thinking:
  atomic { 
  	forks[id] == 0; -> 
  		forks[id] = 1; 
  }

choosing:
  if
  ::atomic { 
  		forks[(id + 1)%N] == 0 -> 
  			forks[(id + 1)%N] = 1; 
  			count_eating++; 
  	};
  ::atomic { 
  		forks[(id + 1)%N] != 0 -> 
  			forks[id] = 0; 
  	} 
  	goto thinking;
  fi;

eating:
  d_step { 
  	count_eating--; 
  	forks[(id + 1)%N] = 0; 
  }
  forks[id] = 0;
  goto thinking;
}
