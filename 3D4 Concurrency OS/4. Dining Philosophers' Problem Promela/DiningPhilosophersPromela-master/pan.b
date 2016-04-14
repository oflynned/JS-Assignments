	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM never_0 */
;
		;
		;
		;
		
	case 5: // STATE 11
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC reset_philosopher */

	case 6: // STATE 2
		;
		now.forks[ Index(((P2 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 6
		;
		now.count_eating = trpt->bup.ovals[1];
		now.forks[ Index(((((P2 *)this)->id+1)%5), 5) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 8: // STATE 9
		;
		now.forks[ Index(((P2 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;
	case 9: // STATE 16
		sv_restor();
		goto R999;

	case 10: // STATE 17
		;
		now.forks[ Index(((P2 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;

		 /* PROC philosopher */

	case 11: // STATE 2
		;
		now.forks[ Index(((P1 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 12: // STATE 6
		;
		now.count_eating = trpt->bup.ovals[1];
		now.forks[ Index(((((P1 *)this)->id+1)%5), 5) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
	case 13: // STATE 10
		sv_restor();
		goto R999;

	case 14: // STATE 11
		;
		now.forks[ Index(((P1 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;

		 /* PROC :init: */
;
		;
		
	case 16: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 17: // STATE 3
		;
		((P0 *)this)->_1_1_i = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 5
		;
	/* 0 */	((P0 *)this)->_1_1_i = trpt->bup.oval;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 19: // STATE 11
		;
		p_restor(II);
		;
		;
		goto R999;
	}

