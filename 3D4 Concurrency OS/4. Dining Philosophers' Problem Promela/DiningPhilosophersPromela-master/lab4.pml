#define N 5

bit forks[N];
byte count_eating;

init {
  atomic {
    byte i = 0;
    do
    ::(i < N-1) -> 
    	run philosopher(i); 
    	i++;
    ::else -> 
    	run reset_philosopher(i); 
    	break;
    od;
  }
}

proctype philosopher(byte id) {
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

proctype reset_philosopher(byte id) {
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
