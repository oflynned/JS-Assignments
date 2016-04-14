#define someone_must_eat  (count_eating > 0)

never {    
_init:
	if
	:: (! ((someone_must_eat))) -> goto _accept
	:: (1) -> goto _init
	fi;
_accept:
	if
	:: (! ((someone_must_eat))) -> goto _accept
	fi;
}
