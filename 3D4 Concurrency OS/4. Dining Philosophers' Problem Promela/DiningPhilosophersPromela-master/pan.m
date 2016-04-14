#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM never_0 */
	case 3: // STATE 1 - deadlock_resolution.live:6 - [(!((count_eating>0)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][1] = 1;
		if (!( !((((int)now.count_eating)>0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 7 - deadlock_resolution.live:11 - [(!((count_eating>0)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported7 = 0;
			if (verbose && !reported7)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported7 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported7 = 0;
			if (verbose && !reported7)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported7 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][7] = 1;
		if (!( !((((int)now.count_eating)>0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 11 - deadlock_resolution.live:13 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported11 = 0;
			if (verbose && !reported11)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported11 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported11 = 0;
			if (verbose && !reported11)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported11 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][11] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC reset_philosopher */
	case 6: // STATE 1 - lab4.pml:44 - [((forks[id]==0))] (12:0:1 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		if (!((((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ])==0)))
			continue;
		/* merge: forks[id] = 1(0, 2, 12) */
		reached[2][2] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ]);
		now.forks[ Index(((P2 *)this)->id, 5) ] = 1;
#ifdef VAR_RANGES
		logval("forks[reset_philosopher:id]", ((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 7: // STATE 4 - lab4.pml:51 - [((forks[((id+1)%5)]==0))] (16:0:2 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!((((int)now.forks[ Index(((((int)((P2 *)this)->id)+1)%5), 5) ])==0)))
			continue;
		/* merge: forks[((id+1)%5)] = 1(16, 5, 16) */
		reached[2][5] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.forks[ Index(((((int)((P2 *)this)->id)+1)%5), 5) ]);
		now.forks[ Index(((((P2 *)this)->id+1)%5), 5) ] = 1;
#ifdef VAR_RANGES
		logval("forks[((reset_philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P2 *)this)->id)+1)%5), 5) ]));
#endif
		;
		/* merge: count_eating = (count_eating+1)(16, 6, 16) */
		reached[2][6] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.count_eating);
		now.count_eating = (((int)now.count_eating)+1);
#ifdef VAR_RANGES
		logval("count_eating", ((int)now.count_eating));
#endif
		;
		/* merge: .(goto)(0, 13, 16) */
		reached[2][13] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 8: // STATE 8 - lab4.pml:56 - [((forks[((id+1)%5)]!=0))] (3:0:1 - 1)
		IfNotBlocked
		reached[2][8] = 1;
		if (!((((int)now.forks[ Index(((((int)((P2 *)this)->id)+1)%5), 5) ])!=0)))
			continue;
		/* merge: forks[id] = 0(0, 9, 3) */
		reached[2][9] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ]);
		now.forks[ Index(((P2 *)this)->id, 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[reset_philosopher:id]", ((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ]));
#endif
		;
		/* merge: goto thinking(0, 11, 3) */
		reached[2][11] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 9: // STATE 16 - lab4.pml:63 - [D_STEP63]
		IfNotBlocked

		reached[2][16] = 1;
		reached[2][t->st] = 1;
		reached[2][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_037_0: /* 2 */
		now.count_eating = (((int)now.count_eating)-1);
#ifdef VAR_RANGES
		logval("count_eating", ((int)now.count_eating));
#endif
		;
S_038_0: /* 2 */
		now.forks[ Index(((((P2 *)this)->id+1)%5), 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[((reset_philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P2 *)this)->id)+1)%5), 5) ]));
#endif
		;
		goto S_040_0;
S_040_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 10: // STATE 17 - lab4.pml:67 - [forks[id] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][17] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ]);
		now.forks[ Index(((P2 *)this)->id, 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[reset_philosopher:id]", ((int)now.forks[ Index(((int)((P2 *)this)->id), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */

		 /* PROC philosopher */
	case 11: // STATE 1 - lab4.pml:23 - [((forks[id]==0))] (7:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ])==0)))
			continue;
		/* merge: forks[id] = 1(0, 2, 7) */
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]);
		now.forks[ Index(((P1 *)this)->id, 5) ] = 1;
#ifdef VAR_RANGES
		logval("forks[philosopher:id]", ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 12: // STATE 4 - lab4.pml:28 - [((forks[((id+1)%5)]==0))] (10:0:2 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!((((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==0)))
			continue;
		/* merge: forks[((id+1)%5)] = 1(10, 5, 10) */
		reached[1][5] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]);
		now.forks[ Index(((((P1 *)this)->id+1)%5), 5) ] = 1;
#ifdef VAR_RANGES
		logval("forks[((philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		/* merge: count_eating = (count_eating+1)(10, 6, 10) */
		reached[1][6] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.count_eating);
		now.count_eating = (((int)now.count_eating)+1);
#ifdef VAR_RANGES
		logval("count_eating", ((int)now.count_eating));
#endif
		;
		_m = 3; goto P999; /* 2 */
	case 13: // STATE 10 - lab4.pml:33 - [D_STEP33]
		IfNotBlocked

		reached[1][10] = 1;
		reached[1][t->st] = 1;
		reached[1][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_018_0: /* 2 */
		now.count_eating = (((int)now.count_eating)-1);
#ifdef VAR_RANGES
		logval("count_eating", ((int)now.count_eating));
#endif
		;
S_019_0: /* 2 */
		now.forks[ Index(((((P1 *)this)->id+1)%5), 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[((philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		goto S_021_0;
S_021_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 14: // STATE 11 - lab4.pml:37 - [forks[id] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]);
		now.forks[ Index(((P1 *)this)->id, 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[philosopher:id]", ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 15: // STATE 1 - lab4.pml:10 - [((i<(5-1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)((P0 *)this)->_1_1_i)<(5-1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 2 - lab4.pml:11 - [(run philosopher(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!(addproc(II, 1, 1, ((int)((P0 *)this)->_1_1_i))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 3 - lab4.pml:12 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)this)->_1_1_i);
		((P0 *)this)->_1_1_i = (((int)((P0 *)this)->_1_1_i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P0 *)this)->_1_1_i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 5 - lab4.pml:14 - [(run reset_philosopher(i))] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		if (!(addproc(II, 1, 2, ((int)((P0 *)this)->_1_1_i))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: _1_1_i */  (trpt+1)->bup.oval = ((P0 *)this)->_1_1_i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->_1_1_i = 0;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 11 - lab4.pml:18 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

