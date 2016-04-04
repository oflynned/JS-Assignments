int n, i_p, i_q, pc;

proctype PCount() {  
  do
    ::(i_p <= 10) ->
    int temp = n
    n = temp + 1
    printf("count via pid %d at pcount %d/10: %d\n", _pid, i_p, n)
    i_p++
    ::else -> goto end
  od
  end:
  pc++;
  printf("exited with iteration %d", i_p);
}

proctype QCount() {  
  do
    ::(i_q <= 10) ->
    int temp = n
    n = temp + 1
    printf("count via pid %d at pcount %d/10: %d\n", _pid, i_q, n)
    i_q++
    ::else -> goto end
  od
  end:
  pc++;
  printf("exited with iteration %d", i_q);
}

init {
  pc = 0;
  n = 0;
  
  run PCount();
  run QCount();
  
  pc == 2;
  printf("Asserting!");
  assert (n != 2);
}
