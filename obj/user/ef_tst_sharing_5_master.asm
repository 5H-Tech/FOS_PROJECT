
obj/user/ef_tst_sharing_5_master:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 37 04 00 00       	call   80046d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 23                	jmp    80006f <_main+0x37>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	c1 e2 04             	shl    $0x4,%edx
  80005d:	01 d0                	add    %edx,%eax
  80005f:	8a 40 04             	mov    0x4(%eax),%al
  800062:	84 c0                	test   %al,%al
  800064:	74 06                	je     80006c <_main+0x34>
			{
				fullWS = 0;
  800066:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006a:	eb 12                	jmp    80007e <_main+0x46>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006c:	ff 45 f0             	incl   -0x10(%ebp)
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 50 74             	mov    0x74(%eax),%edx
  800077:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007a:	39 c2                	cmp    %eax,%edx
  80007c:	77 ce                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007e:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800082:	74 14                	je     800098 <_main+0x60>
  800084:	83 ec 04             	sub    $0x4,%esp
  800087:	68 a0 22 80 00       	push   $0x8022a0
  80008c:	6a 12                	push   $0x12
  80008e:	68 bc 22 80 00       	push   $0x8022bc
  800093:	e8 1a 05 00 00       	call   8005b2 <_panic>
	}

	cprintf("************************************************\n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 dc 22 80 00       	push   $0x8022dc
  8000a0:	e8 af 07 00 00       	call   800854 <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	68 10 23 80 00       	push   $0x802310
  8000b0:	e8 9f 07 00 00       	call   800854 <cprintf>
  8000b5:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000b8:	83 ec 0c             	sub    $0xc,%esp
  8000bb:	68 6c 23 80 00       	push   $0x80236c
  8000c0:	e8 8f 07 00 00       	call   800854 <cprintf>
  8000c5:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  8000c8:	e8 e2 18 00 00       	call   8019af <sys_getenvid>
  8000cd:	89 45 ec             	mov    %eax,-0x14(%ebp)

	int32 envIdSlave1, envIdSlave2, envIdSlaveB1, envIdSlaveB2;

	cprintf("STEP A: checking free of shared object using 2 environments... \n");
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 a0 23 80 00       	push   $0x8023a0
  8000d8:	e8 77 07 00 00       	call   800854 <cprintf>
  8000dd:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		envIdSlave1 = sys_create_env("ef_tshr5slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000eb:	89 c2                	mov    %eax,%edx
  8000ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f2:	8b 40 74             	mov    0x74(%eax),%eax
  8000f5:	6a 32                	push   $0x32
  8000f7:	52                   	push   %edx
  8000f8:	50                   	push   %eax
  8000f9:	68 e1 23 80 00       	push   $0x8023e1
  8000fe:	e8 e5 1b 00 00       	call   801ce8 <sys_create_env>
  800103:	83 c4 10             	add    $0x10,%esp
  800106:	89 45 e8             	mov    %eax,-0x18(%ebp)
		envIdSlave2 = sys_create_env("ef_tshr5slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  800109:	a1 20 30 80 00       	mov    0x803020,%eax
  80010e:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800114:	89 c2                	mov    %eax,%edx
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 40 74             	mov    0x74(%eax),%eax
  80011e:	6a 32                	push   $0x32
  800120:	52                   	push   %edx
  800121:	50                   	push   %eax
  800122:	68 e1 23 80 00       	push   $0x8023e1
  800127:	e8 bc 1b 00 00       	call   801ce8 <sys_create_env>
  80012c:	83 c4 10             	add    $0x10,%esp
  80012f:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		int freeFrames = sys_calculate_free_frames() ;
  800132:	e8 5c 19 00 00       	call   801a93 <sys_calculate_free_frames>
  800137:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  80013a:	83 ec 04             	sub    $0x4,%esp
  80013d:	6a 01                	push   $0x1
  80013f:	68 00 10 00 00       	push   $0x1000
  800144:	68 ef 23 80 00       	push   $0x8023ef
  800149:	e8 08 17 00 00       	call   801856 <smalloc>
  80014e:	83 c4 10             	add    $0x10,%esp
  800151:	89 45 dc             	mov    %eax,-0x24(%ebp)
		cprintf("Master env created x (1 page) \n");
  800154:	83 ec 0c             	sub    $0xc,%esp
  800157:	68 f4 23 80 00       	push   $0x8023f4
  80015c:	e8 f3 06 00 00       	call   800854 <cprintf>
  800161:	83 c4 10             	add    $0x10,%esp
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800164:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  80016b:	74 14                	je     800181 <_main+0x149>
  80016d:	83 ec 04             	sub    $0x4,%esp
  800170:	68 14 24 80 00       	push   $0x802414
  800175:	6a 26                	push   $0x26
  800177:	68 bc 22 80 00       	push   $0x8022bc
  80017c:	e8 31 04 00 00       	call   8005b2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800181:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800184:	e8 0a 19 00 00       	call   801a93 <sys_calculate_free_frames>
  800189:	29 c3                	sub    %eax,%ebx
  80018b:	89 d8                	mov    %ebx,%eax
  80018d:	83 f8 04             	cmp    $0x4,%eax
  800190:	74 14                	je     8001a6 <_main+0x16e>
  800192:	83 ec 04             	sub    $0x4,%esp
  800195:	68 80 24 80 00       	push   $0x802480
  80019a:	6a 27                	push   $0x27
  80019c:	68 bc 22 80 00       	push   $0x8022bc
  8001a1:	e8 0c 04 00 00       	call   8005b2 <_panic>

		//to check that the slave environments completed successfully
		rsttst();
  8001a6:	e8 25 1c 00 00       	call   801dd0 <rsttst>

		sys_run_env(envIdSlave1);
  8001ab:	83 ec 0c             	sub    $0xc,%esp
  8001ae:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b1:	e8 50 1b 00 00       	call   801d06 <sys_run_env>
  8001b6:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdSlave2);
  8001b9:	83 ec 0c             	sub    $0xc,%esp
  8001bc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001bf:	e8 42 1b 00 00       	call   801d06 <sys_run_env>
  8001c4:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  8001c7:	83 ec 0c             	sub    $0xc,%esp
  8001ca:	68 fe 24 80 00       	push   $0x8024fe
  8001cf:	e8 80 06 00 00       	call   800854 <cprintf>
  8001d4:	83 c4 10             	add    $0x10,%esp
		env_sleep(3000);
  8001d7:	83 ec 0c             	sub    $0xc,%esp
  8001da:	68 b8 0b 00 00       	push   $0xbb8
  8001df:	e8 a0 1d 00 00       	call   801f84 <env_sleep>
  8001e4:	83 c4 10             	add    $0x10,%esp

		//to ensure that the slave environments completed successfully
		if (gettst()!=2) panic("test failed");
  8001e7:	e8 5e 1c 00 00       	call   801e4a <gettst>
  8001ec:	83 f8 02             	cmp    $0x2,%eax
  8001ef:	74 14                	je     800205 <_main+0x1cd>
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	68 15 25 80 00       	push   $0x802515
  8001f9:	6a 33                	push   $0x33
  8001fb:	68 bc 22 80 00       	push   $0x8022bc
  800200:	e8 ad 03 00 00       	call   8005b2 <_panic>

		sfree(x);
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	ff 75 dc             	pushl  -0x24(%ebp)
  80020b:	e8 86 16 00 00       	call   801896 <sfree>
  800210:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed x (1 page) \n");
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 24 25 80 00       	push   $0x802524
  80021b:	e8 34 06 00 00       	call   800854 <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
		int diff = (sys_calculate_free_frames() - freeFrames);
  800223:	e8 6b 18 00 00       	call   801a93 <sys_calculate_free_frames>
  800228:	89 c2                	mov    %eax,%edx
  80022a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80022d:	29 c2                	sub    %eax,%edx
  80022f:	89 d0                	mov    %edx,%eax
  800231:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if ( diff !=  0) panic("Wrong free: revise your freeSharedObject logic\n");
  800234:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 44 25 80 00       	push   $0x802544
  800242:	6a 38                	push   $0x38
  800244:	68 bc 22 80 00       	push   $0x8022bc
  800249:	e8 64 03 00 00       	call   8005b2 <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  80024e:	83 ec 0c             	sub    $0xc,%esp
  800251:	68 74 25 80 00       	push   $0x802574
  800256:	e8 f9 05 00 00       	call   800854 <cprintf>
  80025b:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP B: checking free of 2 shared objects ... \n");
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	68 98 25 80 00       	push   $0x802598
  800266:	e8 e9 05 00 00       	call   800854 <cprintf>
  80026b:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		envIdSlaveB1 = sys_create_env("ef_tshr5slaveB1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  80026e:	a1 20 30 80 00       	mov    0x803020,%eax
  800273:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800279:	89 c2                	mov    %eax,%edx
  80027b:	a1 20 30 80 00       	mov    0x803020,%eax
  800280:	8b 40 74             	mov    0x74(%eax),%eax
  800283:	6a 32                	push   $0x32
  800285:	52                   	push   %edx
  800286:	50                   	push   %eax
  800287:	68 c8 25 80 00       	push   $0x8025c8
  80028c:	e8 57 1a 00 00       	call   801ce8 <sys_create_env>
  800291:	83 c4 10             	add    $0x10,%esp
  800294:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		envIdSlaveB2 = sys_create_env("ef_tshr5slaveB2", (myEnv->page_WS_max_size), (myEnv->SecondListSize),50);
  800297:	a1 20 30 80 00       	mov    0x803020,%eax
  80029c:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8002a2:	89 c2                	mov    %eax,%edx
  8002a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a9:	8b 40 74             	mov    0x74(%eax),%eax
  8002ac:	6a 32                	push   $0x32
  8002ae:	52                   	push   %edx
  8002af:	50                   	push   %eax
  8002b0:	68 d8 25 80 00       	push   $0x8025d8
  8002b5:	e8 2e 1a 00 00       	call   801ce8 <sys_create_env>
  8002ba:	83 c4 10             	add    $0x10,%esp
  8002bd:	89 45 d0             	mov    %eax,-0x30(%ebp)

		z = smalloc("z", PAGE_SIZE, 1);
  8002c0:	83 ec 04             	sub    $0x4,%esp
  8002c3:	6a 01                	push   $0x1
  8002c5:	68 00 10 00 00       	push   $0x1000
  8002ca:	68 e8 25 80 00       	push   $0x8025e8
  8002cf:	e8 82 15 00 00       	call   801856 <smalloc>
  8002d4:	83 c4 10             	add    $0x10,%esp
  8002d7:	89 45 cc             	mov    %eax,-0x34(%ebp)
		cprintf("Master env created z (1 page) \n");
  8002da:	83 ec 0c             	sub    $0xc,%esp
  8002dd:	68 ec 25 80 00       	push   $0x8025ec
  8002e2:	e8 6d 05 00 00       	call   800854 <cprintf>
  8002e7:	83 c4 10             	add    $0x10,%esp

		x = smalloc("x", PAGE_SIZE, 1);
  8002ea:	83 ec 04             	sub    $0x4,%esp
  8002ed:	6a 01                	push   $0x1
  8002ef:	68 00 10 00 00       	push   $0x1000
  8002f4:	68 ef 23 80 00       	push   $0x8023ef
  8002f9:	e8 58 15 00 00       	call   801856 <smalloc>
  8002fe:	83 c4 10             	add    $0x10,%esp
  800301:	89 45 c8             	mov    %eax,-0x38(%ebp)
		cprintf("Master env created x (1 page) \n");
  800304:	83 ec 0c             	sub    $0xc,%esp
  800307:	68 f4 23 80 00       	push   $0x8023f4
  80030c:	e8 43 05 00 00       	call   800854 <cprintf>
  800311:	83 c4 10             	add    $0x10,%esp

		rsttst();
  800314:	e8 b7 1a 00 00       	call   801dd0 <rsttst>

		sys_run_env(envIdSlaveB1);
  800319:	83 ec 0c             	sub    $0xc,%esp
  80031c:	ff 75 d4             	pushl  -0x2c(%ebp)
  80031f:	e8 e2 19 00 00       	call   801d06 <sys_run_env>
  800324:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdSlaveB2);
  800327:	83 ec 0c             	sub    $0xc,%esp
  80032a:	ff 75 d0             	pushl  -0x30(%ebp)
  80032d:	e8 d4 19 00 00       	call   801d06 <sys_run_env>
  800332:	83 c4 10             	add    $0x10,%esp

		env_sleep(4000); //give slaves time to catch the shared object before removal
  800335:	83 ec 0c             	sub    $0xc,%esp
  800338:	68 a0 0f 00 00       	push   $0xfa0
  80033d:	e8 42 1c 00 00       	call   801f84 <env_sleep>
  800342:	83 c4 10             	add    $0x10,%esp

		int freeFrames = sys_calculate_free_frames() ;
  800345:	e8 49 17 00 00       	call   801a93 <sys_calculate_free_frames>
  80034a:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		sfree(z);
  80034d:	83 ec 0c             	sub    $0xc,%esp
  800350:	ff 75 cc             	pushl  -0x34(%ebp)
  800353:	e8 3e 15 00 00       	call   801896 <sfree>
  800358:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed z\n");
  80035b:	83 ec 0c             	sub    $0xc,%esp
  80035e:	68 0c 26 80 00       	push   $0x80260c
  800363:	e8 ec 04 00 00       	call   800854 <cprintf>
  800368:	83 c4 10             	add    $0x10,%esp

		sfree(x);
  80036b:	83 ec 0c             	sub    $0xc,%esp
  80036e:	ff 75 c8             	pushl  -0x38(%ebp)
  800371:	e8 20 15 00 00       	call   801896 <sfree>
  800376:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed x\n");
  800379:	83 ec 0c             	sub    $0xc,%esp
  80037c:	68 22 26 80 00       	push   $0x802622
  800381:	e8 ce 04 00 00       	call   800854 <cprintf>
  800386:	83 c4 10             	add    $0x10,%esp

		int diff = (sys_calculate_free_frames() - freeFrames);
  800389:	e8 05 17 00 00       	call   801a93 <sys_calculate_free_frames>
  80038e:	89 c2                	mov    %eax,%edx
  800390:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800393:	29 c2                	sub    %eax,%edx
  800395:	89 d0                	mov    %edx,%eax
  800397:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if (diff !=  1) panic("Wrong free: frames removed not equal 1 !, correct frames to be removed are 1:\nfrom the env: 1 table\nframes_storage of z & x: should NOT cleared yet (still in use!)\n");
  80039a:	83 7d c0 01          	cmpl   $0x1,-0x40(%ebp)
  80039e:	74 14                	je     8003b4 <_main+0x37c>
  8003a0:	83 ec 04             	sub    $0x4,%esp
  8003a3:	68 38 26 80 00       	push   $0x802638
  8003a8:	6a 59                	push   $0x59
  8003aa:	68 bc 22 80 00       	push   $0x8022bc
  8003af:	e8 fe 01 00 00       	call   8005b2 <_panic>

		//To indicate that it's completed successfully
		inctst();
  8003b4:	e8 77 1a 00 00       	call   801e30 <inctst>

		int* finish_children = smalloc("finish_children", sizeof(int), 1);
  8003b9:	83 ec 04             	sub    $0x4,%esp
  8003bc:	6a 01                	push   $0x1
  8003be:	6a 04                	push   $0x4
  8003c0:	68 dd 26 80 00       	push   $0x8026dd
  8003c5:	e8 8c 14 00 00       	call   801856 <smalloc>
  8003ca:	83 c4 10             	add    $0x10,%esp
  8003cd:	89 45 bc             	mov    %eax,-0x44(%ebp)
		*finish_children = 0;
  8003d0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

		if (sys_getparentenvid() > 0) {
  8003d9:	e8 03 16 00 00       	call   8019e1 <sys_getparentenvid>
  8003de:	85 c0                	test   %eax,%eax
  8003e0:	0f 8e 81 00 00 00    	jle    800467 <_main+0x42f>
			while(*finish_children != 1);
  8003e6:	90                   	nop
  8003e7:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	83 f8 01             	cmp    $0x1,%eax
  8003ef:	75 f6                	jne    8003e7 <_main+0x3af>
			cprintf("done\n");
  8003f1:	83 ec 0c             	sub    $0xc,%esp
  8003f4:	68 ed 26 80 00       	push   $0x8026ed
  8003f9:	e8 56 04 00 00       	call   800854 <cprintf>
  8003fe:	83 c4 10             	add    $0x10,%esp
			sys_free_env(envIdSlave1);
  800401:	83 ec 0c             	sub    $0xc,%esp
  800404:	ff 75 e8             	pushl  -0x18(%ebp)
  800407:	e8 16 19 00 00       	call   801d22 <sys_free_env>
  80040c:	83 c4 10             	add    $0x10,%esp
			sys_free_env(envIdSlave2);
  80040f:	83 ec 0c             	sub    $0xc,%esp
  800412:	ff 75 e4             	pushl  -0x1c(%ebp)
  800415:	e8 08 19 00 00       	call   801d22 <sys_free_env>
  80041a:	83 c4 10             	add    $0x10,%esp
			sys_free_env(envIdSlaveB1);
  80041d:	83 ec 0c             	sub    $0xc,%esp
  800420:	ff 75 d4             	pushl  -0x2c(%ebp)
  800423:	e8 fa 18 00 00       	call   801d22 <sys_free_env>
  800428:	83 c4 10             	add    $0x10,%esp
			sys_free_env(envIdSlaveB2);
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	ff 75 d0             	pushl  -0x30(%ebp)
  800431:	e8 ec 18 00 00       	call   801d22 <sys_free_env>
  800436:	83 c4 10             	add    $0x10,%esp

			int *finishedCount = NULL;
  800439:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
			finishedCount = sget(sys_getparentenvid(), "finishedCount") ;
  800440:	e8 9c 15 00 00       	call   8019e1 <sys_getparentenvid>
  800445:	83 ec 08             	sub    $0x8,%esp
  800448:	68 f3 26 80 00       	push   $0x8026f3
  80044d:	50                   	push   %eax
  80044e:	e8 26 14 00 00       	call   801879 <sget>
  800453:	83 c4 10             	add    $0x10,%esp
  800456:	89 45 b8             	mov    %eax,-0x48(%ebp)
			(*finishedCount)++ ;
  800459:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	8d 50 01             	lea    0x1(%eax),%edx
  800461:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800464:	89 10                	mov    %edx,(%eax)
		}
	}


	return;
  800466:	90                   	nop
  800467:	90                   	nop
}
  800468:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80046b:	c9                   	leave  
  80046c:	c3                   	ret    

0080046d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80046d:	55                   	push   %ebp
  80046e:	89 e5                	mov    %esp,%ebp
  800470:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800473:	e8 50 15 00 00       	call   8019c8 <sys_getenvindex>
  800478:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80047b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80047e:	89 d0                	mov    %edx,%eax
  800480:	c1 e0 03             	shl    $0x3,%eax
  800483:	01 d0                	add    %edx,%eax
  800485:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80048c:	01 c8                	add    %ecx,%eax
  80048e:	01 c0                	add    %eax,%eax
  800490:	01 d0                	add    %edx,%eax
  800492:	01 c0                	add    %eax,%eax
  800494:	01 d0                	add    %edx,%eax
  800496:	89 c2                	mov    %eax,%edx
  800498:	c1 e2 05             	shl    $0x5,%edx
  80049b:	29 c2                	sub    %eax,%edx
  80049d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8004a4:	89 c2                	mov    %eax,%edx
  8004a6:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8004ac:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8004b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b6:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8004bc:	84 c0                	test   %al,%al
  8004be:	74 0f                	je     8004cf <libmain+0x62>
		binaryname = myEnv->prog_name;
  8004c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c5:	05 40 3c 01 00       	add    $0x13c40,%eax
  8004ca:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004d3:	7e 0a                	jle    8004df <libmain+0x72>
		binaryname = argv[0];
  8004d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d8:	8b 00                	mov    (%eax),%eax
  8004da:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004df:	83 ec 08             	sub    $0x8,%esp
  8004e2:	ff 75 0c             	pushl  0xc(%ebp)
  8004e5:	ff 75 08             	pushl  0x8(%ebp)
  8004e8:	e8 4b fb ff ff       	call   800038 <_main>
  8004ed:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004f0:	e8 6e 16 00 00       	call   801b63 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004f5:	83 ec 0c             	sub    $0xc,%esp
  8004f8:	68 1c 27 80 00       	push   $0x80271c
  8004fd:	e8 52 03 00 00       	call   800854 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800505:	a1 20 30 80 00       	mov    0x803020,%eax
  80050a:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800510:	a1 20 30 80 00       	mov    0x803020,%eax
  800515:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80051b:	83 ec 04             	sub    $0x4,%esp
  80051e:	52                   	push   %edx
  80051f:	50                   	push   %eax
  800520:	68 44 27 80 00       	push   $0x802744
  800525:	e8 2a 03 00 00       	call   800854 <cprintf>
  80052a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80052d:	a1 20 30 80 00       	mov    0x803020,%eax
  800532:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800538:	a1 20 30 80 00       	mov    0x803020,%eax
  80053d:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800543:	83 ec 04             	sub    $0x4,%esp
  800546:	52                   	push   %edx
  800547:	50                   	push   %eax
  800548:	68 6c 27 80 00       	push   $0x80276c
  80054d:	e8 02 03 00 00       	call   800854 <cprintf>
  800552:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800555:	a1 20 30 80 00       	mov    0x803020,%eax
  80055a:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800560:	83 ec 08             	sub    $0x8,%esp
  800563:	50                   	push   %eax
  800564:	68 ad 27 80 00       	push   $0x8027ad
  800569:	e8 e6 02 00 00       	call   800854 <cprintf>
  80056e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800571:	83 ec 0c             	sub    $0xc,%esp
  800574:	68 1c 27 80 00       	push   $0x80271c
  800579:	e8 d6 02 00 00       	call   800854 <cprintf>
  80057e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800581:	e8 f7 15 00 00       	call   801b7d <sys_enable_interrupt>

	// exit gracefully
	exit();
  800586:	e8 19 00 00 00       	call   8005a4 <exit>
}
  80058b:	90                   	nop
  80058c:	c9                   	leave  
  80058d:	c3                   	ret    

0080058e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80058e:	55                   	push   %ebp
  80058f:	89 e5                	mov    %esp,%ebp
  800591:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800594:	83 ec 0c             	sub    $0xc,%esp
  800597:	6a 00                	push   $0x0
  800599:	e8 f6 13 00 00       	call   801994 <sys_env_destroy>
  80059e:	83 c4 10             	add    $0x10,%esp
}
  8005a1:	90                   	nop
  8005a2:	c9                   	leave  
  8005a3:	c3                   	ret    

008005a4 <exit>:

void
exit(void)
{
  8005a4:	55                   	push   %ebp
  8005a5:	89 e5                	mov    %esp,%ebp
  8005a7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8005aa:	e8 4b 14 00 00       	call   8019fa <sys_env_exit>
}
  8005af:	90                   	nop
  8005b0:	c9                   	leave  
  8005b1:	c3                   	ret    

008005b2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8005b2:	55                   	push   %ebp
  8005b3:	89 e5                	mov    %esp,%ebp
  8005b5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8005b8:	8d 45 10             	lea    0x10(%ebp),%eax
  8005bb:	83 c0 04             	add    $0x4,%eax
  8005be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8005c1:	a1 18 31 80 00       	mov    0x803118,%eax
  8005c6:	85 c0                	test   %eax,%eax
  8005c8:	74 16                	je     8005e0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8005ca:	a1 18 31 80 00       	mov    0x803118,%eax
  8005cf:	83 ec 08             	sub    $0x8,%esp
  8005d2:	50                   	push   %eax
  8005d3:	68 c4 27 80 00       	push   $0x8027c4
  8005d8:	e8 77 02 00 00       	call   800854 <cprintf>
  8005dd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8005e0:	a1 00 30 80 00       	mov    0x803000,%eax
  8005e5:	ff 75 0c             	pushl  0xc(%ebp)
  8005e8:	ff 75 08             	pushl  0x8(%ebp)
  8005eb:	50                   	push   %eax
  8005ec:	68 c9 27 80 00       	push   $0x8027c9
  8005f1:	e8 5e 02 00 00       	call   800854 <cprintf>
  8005f6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8005f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005fc:	83 ec 08             	sub    $0x8,%esp
  8005ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800602:	50                   	push   %eax
  800603:	e8 e1 01 00 00       	call   8007e9 <vcprintf>
  800608:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80060b:	83 ec 08             	sub    $0x8,%esp
  80060e:	6a 00                	push   $0x0
  800610:	68 e5 27 80 00       	push   $0x8027e5
  800615:	e8 cf 01 00 00       	call   8007e9 <vcprintf>
  80061a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80061d:	e8 82 ff ff ff       	call   8005a4 <exit>

	// should not return here
	while (1) ;
  800622:	eb fe                	jmp    800622 <_panic+0x70>

00800624 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800624:	55                   	push   %ebp
  800625:	89 e5                	mov    %esp,%ebp
  800627:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80062a:	a1 20 30 80 00       	mov    0x803020,%eax
  80062f:	8b 50 74             	mov    0x74(%eax),%edx
  800632:	8b 45 0c             	mov    0xc(%ebp),%eax
  800635:	39 c2                	cmp    %eax,%edx
  800637:	74 14                	je     80064d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800639:	83 ec 04             	sub    $0x4,%esp
  80063c:	68 e8 27 80 00       	push   $0x8027e8
  800641:	6a 26                	push   $0x26
  800643:	68 34 28 80 00       	push   $0x802834
  800648:	e8 65 ff ff ff       	call   8005b2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80064d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800654:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80065b:	e9 b6 00 00 00       	jmp    800716 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800660:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800663:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	01 d0                	add    %edx,%eax
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	85 c0                	test   %eax,%eax
  800673:	75 08                	jne    80067d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800675:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800678:	e9 96 00 00 00       	jmp    800713 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80067d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800684:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80068b:	eb 5d                	jmp    8006ea <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80068d:	a1 20 30 80 00       	mov    0x803020,%eax
  800692:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800698:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80069b:	c1 e2 04             	shl    $0x4,%edx
  80069e:	01 d0                	add    %edx,%eax
  8006a0:	8a 40 04             	mov    0x4(%eax),%al
  8006a3:	84 c0                	test   %al,%al
  8006a5:	75 40                	jne    8006e7 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006b2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006b5:	c1 e2 04             	shl    $0x4,%edx
  8006b8:	01 d0                	add    %edx,%eax
  8006ba:	8b 00                	mov    (%eax),%eax
  8006bc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8006bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006c7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8006c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006cc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	01 c8                	add    %ecx,%eax
  8006d8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006da:	39 c2                	cmp    %eax,%edx
  8006dc:	75 09                	jne    8006e7 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8006de:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8006e5:	eb 12                	jmp    8006f9 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006e7:	ff 45 e8             	incl   -0x18(%ebp)
  8006ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ef:	8b 50 74             	mov    0x74(%eax),%edx
  8006f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f5:	39 c2                	cmp    %eax,%edx
  8006f7:	77 94                	ja     80068d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8006f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8006fd:	75 14                	jne    800713 <CheckWSWithoutLastIndex+0xef>
			panic(
  8006ff:	83 ec 04             	sub    $0x4,%esp
  800702:	68 40 28 80 00       	push   $0x802840
  800707:	6a 3a                	push   $0x3a
  800709:	68 34 28 80 00       	push   $0x802834
  80070e:	e8 9f fe ff ff       	call   8005b2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800713:	ff 45 f0             	incl   -0x10(%ebp)
  800716:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800719:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80071c:	0f 8c 3e ff ff ff    	jl     800660 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800722:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800729:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800730:	eb 20                	jmp    800752 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800732:	a1 20 30 80 00       	mov    0x803020,%eax
  800737:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80073d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800740:	c1 e2 04             	shl    $0x4,%edx
  800743:	01 d0                	add    %edx,%eax
  800745:	8a 40 04             	mov    0x4(%eax),%al
  800748:	3c 01                	cmp    $0x1,%al
  80074a:	75 03                	jne    80074f <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80074c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80074f:	ff 45 e0             	incl   -0x20(%ebp)
  800752:	a1 20 30 80 00       	mov    0x803020,%eax
  800757:	8b 50 74             	mov    0x74(%eax),%edx
  80075a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80075d:	39 c2                	cmp    %eax,%edx
  80075f:	77 d1                	ja     800732 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800761:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800764:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800767:	74 14                	je     80077d <CheckWSWithoutLastIndex+0x159>
		panic(
  800769:	83 ec 04             	sub    $0x4,%esp
  80076c:	68 94 28 80 00       	push   $0x802894
  800771:	6a 44                	push   $0x44
  800773:	68 34 28 80 00       	push   $0x802834
  800778:	e8 35 fe ff ff       	call   8005b2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80077d:	90                   	nop
  80077e:	c9                   	leave  
  80077f:	c3                   	ret    

00800780 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800780:	55                   	push   %ebp
  800781:	89 e5                	mov    %esp,%ebp
  800783:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800786:	8b 45 0c             	mov    0xc(%ebp),%eax
  800789:	8b 00                	mov    (%eax),%eax
  80078b:	8d 48 01             	lea    0x1(%eax),%ecx
  80078e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800791:	89 0a                	mov    %ecx,(%edx)
  800793:	8b 55 08             	mov    0x8(%ebp),%edx
  800796:	88 d1                	mov    %dl,%cl
  800798:	8b 55 0c             	mov    0xc(%ebp),%edx
  80079b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80079f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8007a9:	75 2c                	jne    8007d7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8007ab:	a0 24 30 80 00       	mov    0x803024,%al
  8007b0:	0f b6 c0             	movzbl %al,%eax
  8007b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007b6:	8b 12                	mov    (%edx),%edx
  8007b8:	89 d1                	mov    %edx,%ecx
  8007ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007bd:	83 c2 08             	add    $0x8,%edx
  8007c0:	83 ec 04             	sub    $0x4,%esp
  8007c3:	50                   	push   %eax
  8007c4:	51                   	push   %ecx
  8007c5:	52                   	push   %edx
  8007c6:	e8 87 11 00 00       	call   801952 <sys_cputs>
  8007cb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8007ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8007d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007da:	8b 40 04             	mov    0x4(%eax),%eax
  8007dd:	8d 50 01             	lea    0x1(%eax),%edx
  8007e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8007e6:	90                   	nop
  8007e7:	c9                   	leave  
  8007e8:	c3                   	ret    

008007e9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8007e9:	55                   	push   %ebp
  8007ea:	89 e5                	mov    %esp,%ebp
  8007ec:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8007f2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8007f9:	00 00 00 
	b.cnt = 0;
  8007fc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800803:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800806:	ff 75 0c             	pushl  0xc(%ebp)
  800809:	ff 75 08             	pushl  0x8(%ebp)
  80080c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800812:	50                   	push   %eax
  800813:	68 80 07 80 00       	push   $0x800780
  800818:	e8 11 02 00 00       	call   800a2e <vprintfmt>
  80081d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800820:	a0 24 30 80 00       	mov    0x803024,%al
  800825:	0f b6 c0             	movzbl %al,%eax
  800828:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80082e:	83 ec 04             	sub    $0x4,%esp
  800831:	50                   	push   %eax
  800832:	52                   	push   %edx
  800833:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800839:	83 c0 08             	add    $0x8,%eax
  80083c:	50                   	push   %eax
  80083d:	e8 10 11 00 00       	call   801952 <sys_cputs>
  800842:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800845:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80084c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800852:	c9                   	leave  
  800853:	c3                   	ret    

00800854 <cprintf>:

int cprintf(const char *fmt, ...) {
  800854:	55                   	push   %ebp
  800855:	89 e5                	mov    %esp,%ebp
  800857:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80085a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800861:	8d 45 0c             	lea    0xc(%ebp),%eax
  800864:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800867:	8b 45 08             	mov    0x8(%ebp),%eax
  80086a:	83 ec 08             	sub    $0x8,%esp
  80086d:	ff 75 f4             	pushl  -0xc(%ebp)
  800870:	50                   	push   %eax
  800871:	e8 73 ff ff ff       	call   8007e9 <vcprintf>
  800876:	83 c4 10             	add    $0x10,%esp
  800879:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80087c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80087f:	c9                   	leave  
  800880:	c3                   	ret    

00800881 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800881:	55                   	push   %ebp
  800882:	89 e5                	mov    %esp,%ebp
  800884:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800887:	e8 d7 12 00 00       	call   801b63 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80088c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80088f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	83 ec 08             	sub    $0x8,%esp
  800898:	ff 75 f4             	pushl  -0xc(%ebp)
  80089b:	50                   	push   %eax
  80089c:	e8 48 ff ff ff       	call   8007e9 <vcprintf>
  8008a1:	83 c4 10             	add    $0x10,%esp
  8008a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8008a7:	e8 d1 12 00 00       	call   801b7d <sys_enable_interrupt>
	return cnt;
  8008ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008af:	c9                   	leave  
  8008b0:	c3                   	ret    

008008b1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8008b1:	55                   	push   %ebp
  8008b2:	89 e5                	mov    %esp,%ebp
  8008b4:	53                   	push   %ebx
  8008b5:	83 ec 14             	sub    $0x14,%esp
  8008b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008be:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008c4:	8b 45 18             	mov    0x18(%ebp),%eax
  8008c7:	ba 00 00 00 00       	mov    $0x0,%edx
  8008cc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008cf:	77 55                	ja     800926 <printnum+0x75>
  8008d1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008d4:	72 05                	jb     8008db <printnum+0x2a>
  8008d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008d9:	77 4b                	ja     800926 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008db:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008de:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008e1:	8b 45 18             	mov    0x18(%ebp),%eax
  8008e4:	ba 00 00 00 00       	mov    $0x0,%edx
  8008e9:	52                   	push   %edx
  8008ea:	50                   	push   %eax
  8008eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ee:	ff 75 f0             	pushl  -0x10(%ebp)
  8008f1:	e8 42 17 00 00       	call   802038 <__udivdi3>
  8008f6:	83 c4 10             	add    $0x10,%esp
  8008f9:	83 ec 04             	sub    $0x4,%esp
  8008fc:	ff 75 20             	pushl  0x20(%ebp)
  8008ff:	53                   	push   %ebx
  800900:	ff 75 18             	pushl  0x18(%ebp)
  800903:	52                   	push   %edx
  800904:	50                   	push   %eax
  800905:	ff 75 0c             	pushl  0xc(%ebp)
  800908:	ff 75 08             	pushl  0x8(%ebp)
  80090b:	e8 a1 ff ff ff       	call   8008b1 <printnum>
  800910:	83 c4 20             	add    $0x20,%esp
  800913:	eb 1a                	jmp    80092f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800915:	83 ec 08             	sub    $0x8,%esp
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	ff 75 20             	pushl  0x20(%ebp)
  80091e:	8b 45 08             	mov    0x8(%ebp),%eax
  800921:	ff d0                	call   *%eax
  800923:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800926:	ff 4d 1c             	decl   0x1c(%ebp)
  800929:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80092d:	7f e6                	jg     800915 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80092f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800932:	bb 00 00 00 00       	mov    $0x0,%ebx
  800937:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80093d:	53                   	push   %ebx
  80093e:	51                   	push   %ecx
  80093f:	52                   	push   %edx
  800940:	50                   	push   %eax
  800941:	e8 02 18 00 00       	call   802148 <__umoddi3>
  800946:	83 c4 10             	add    $0x10,%esp
  800949:	05 f4 2a 80 00       	add    $0x802af4,%eax
  80094e:	8a 00                	mov    (%eax),%al
  800950:	0f be c0             	movsbl %al,%eax
  800953:	83 ec 08             	sub    $0x8,%esp
  800956:	ff 75 0c             	pushl  0xc(%ebp)
  800959:	50                   	push   %eax
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	ff d0                	call   *%eax
  80095f:	83 c4 10             	add    $0x10,%esp
}
  800962:	90                   	nop
  800963:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800966:	c9                   	leave  
  800967:	c3                   	ret    

00800968 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800968:	55                   	push   %ebp
  800969:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80096b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80096f:	7e 1c                	jle    80098d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800971:	8b 45 08             	mov    0x8(%ebp),%eax
  800974:	8b 00                	mov    (%eax),%eax
  800976:	8d 50 08             	lea    0x8(%eax),%edx
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	89 10                	mov    %edx,(%eax)
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	8b 00                	mov    (%eax),%eax
  800983:	83 e8 08             	sub    $0x8,%eax
  800986:	8b 50 04             	mov    0x4(%eax),%edx
  800989:	8b 00                	mov    (%eax),%eax
  80098b:	eb 40                	jmp    8009cd <getuint+0x65>
	else if (lflag)
  80098d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800991:	74 1e                	je     8009b1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	8b 00                	mov    (%eax),%eax
  800998:	8d 50 04             	lea    0x4(%eax),%edx
  80099b:	8b 45 08             	mov    0x8(%ebp),%eax
  80099e:	89 10                	mov    %edx,(%eax)
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	8b 00                	mov    (%eax),%eax
  8009a5:	83 e8 04             	sub    $0x4,%eax
  8009a8:	8b 00                	mov    (%eax),%eax
  8009aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8009af:	eb 1c                	jmp    8009cd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	8b 00                	mov    (%eax),%eax
  8009b6:	8d 50 04             	lea    0x4(%eax),%edx
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	89 10                	mov    %edx,(%eax)
  8009be:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c1:	8b 00                	mov    (%eax),%eax
  8009c3:	83 e8 04             	sub    $0x4,%eax
  8009c6:	8b 00                	mov    (%eax),%eax
  8009c8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009cd:	5d                   	pop    %ebp
  8009ce:	c3                   	ret    

008009cf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009cf:	55                   	push   %ebp
  8009d0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009d2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009d6:	7e 1c                	jle    8009f4 <getint+0x25>
		return va_arg(*ap, long long);
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	8b 00                	mov    (%eax),%eax
  8009dd:	8d 50 08             	lea    0x8(%eax),%edx
  8009e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e3:	89 10                	mov    %edx,(%eax)
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	83 e8 08             	sub    $0x8,%eax
  8009ed:	8b 50 04             	mov    0x4(%eax),%edx
  8009f0:	8b 00                	mov    (%eax),%eax
  8009f2:	eb 38                	jmp    800a2c <getint+0x5d>
	else if (lflag)
  8009f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009f8:	74 1a                	je     800a14 <getint+0x45>
		return va_arg(*ap, long);
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	8b 00                	mov    (%eax),%eax
  8009ff:	8d 50 04             	lea    0x4(%eax),%edx
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	89 10                	mov    %edx,(%eax)
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	8b 00                	mov    (%eax),%eax
  800a0c:	83 e8 04             	sub    $0x4,%eax
  800a0f:	8b 00                	mov    (%eax),%eax
  800a11:	99                   	cltd   
  800a12:	eb 18                	jmp    800a2c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800a14:	8b 45 08             	mov    0x8(%ebp),%eax
  800a17:	8b 00                	mov    (%eax),%eax
  800a19:	8d 50 04             	lea    0x4(%eax),%edx
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	89 10                	mov    %edx,(%eax)
  800a21:	8b 45 08             	mov    0x8(%ebp),%eax
  800a24:	8b 00                	mov    (%eax),%eax
  800a26:	83 e8 04             	sub    $0x4,%eax
  800a29:	8b 00                	mov    (%eax),%eax
  800a2b:	99                   	cltd   
}
  800a2c:	5d                   	pop    %ebp
  800a2d:	c3                   	ret    

00800a2e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a2e:	55                   	push   %ebp
  800a2f:	89 e5                	mov    %esp,%ebp
  800a31:	56                   	push   %esi
  800a32:	53                   	push   %ebx
  800a33:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a36:	eb 17                	jmp    800a4f <vprintfmt+0x21>
			if (ch == '\0')
  800a38:	85 db                	test   %ebx,%ebx
  800a3a:	0f 84 af 03 00 00    	je     800def <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a40:	83 ec 08             	sub    $0x8,%esp
  800a43:	ff 75 0c             	pushl  0xc(%ebp)
  800a46:	53                   	push   %ebx
  800a47:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4a:	ff d0                	call   *%eax
  800a4c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a52:	8d 50 01             	lea    0x1(%eax),%edx
  800a55:	89 55 10             	mov    %edx,0x10(%ebp)
  800a58:	8a 00                	mov    (%eax),%al
  800a5a:	0f b6 d8             	movzbl %al,%ebx
  800a5d:	83 fb 25             	cmp    $0x25,%ebx
  800a60:	75 d6                	jne    800a38 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a62:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a66:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a6d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a74:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a7b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a82:	8b 45 10             	mov    0x10(%ebp),%eax
  800a85:	8d 50 01             	lea    0x1(%eax),%edx
  800a88:	89 55 10             	mov    %edx,0x10(%ebp)
  800a8b:	8a 00                	mov    (%eax),%al
  800a8d:	0f b6 d8             	movzbl %al,%ebx
  800a90:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a93:	83 f8 55             	cmp    $0x55,%eax
  800a96:	0f 87 2b 03 00 00    	ja     800dc7 <vprintfmt+0x399>
  800a9c:	8b 04 85 18 2b 80 00 	mov    0x802b18(,%eax,4),%eax
  800aa3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800aa5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800aa9:	eb d7                	jmp    800a82 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800aab:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800aaf:	eb d1                	jmp    800a82 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ab1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ab8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800abb:	89 d0                	mov    %edx,%eax
  800abd:	c1 e0 02             	shl    $0x2,%eax
  800ac0:	01 d0                	add    %edx,%eax
  800ac2:	01 c0                	add    %eax,%eax
  800ac4:	01 d8                	add    %ebx,%eax
  800ac6:	83 e8 30             	sub    $0x30,%eax
  800ac9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800acc:	8b 45 10             	mov    0x10(%ebp),%eax
  800acf:	8a 00                	mov    (%eax),%al
  800ad1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ad4:	83 fb 2f             	cmp    $0x2f,%ebx
  800ad7:	7e 3e                	jle    800b17 <vprintfmt+0xe9>
  800ad9:	83 fb 39             	cmp    $0x39,%ebx
  800adc:	7f 39                	jg     800b17 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ade:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ae1:	eb d5                	jmp    800ab8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ae3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae6:	83 c0 04             	add    $0x4,%eax
  800ae9:	89 45 14             	mov    %eax,0x14(%ebp)
  800aec:	8b 45 14             	mov    0x14(%ebp),%eax
  800aef:	83 e8 04             	sub    $0x4,%eax
  800af2:	8b 00                	mov    (%eax),%eax
  800af4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800af7:	eb 1f                	jmp    800b18 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800af9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800afd:	79 83                	jns    800a82 <vprintfmt+0x54>
				width = 0;
  800aff:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b06:	e9 77 ff ff ff       	jmp    800a82 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b0b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b12:	e9 6b ff ff ff       	jmp    800a82 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800b17:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800b18:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b1c:	0f 89 60 ff ff ff    	jns    800a82 <vprintfmt+0x54>
				width = precision, precision = -1;
  800b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b28:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b2f:	e9 4e ff ff ff       	jmp    800a82 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b34:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b37:	e9 46 ff ff ff       	jmp    800a82 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b3f:	83 c0 04             	add    $0x4,%eax
  800b42:	89 45 14             	mov    %eax,0x14(%ebp)
  800b45:	8b 45 14             	mov    0x14(%ebp),%eax
  800b48:	83 e8 04             	sub    $0x4,%eax
  800b4b:	8b 00                	mov    (%eax),%eax
  800b4d:	83 ec 08             	sub    $0x8,%esp
  800b50:	ff 75 0c             	pushl  0xc(%ebp)
  800b53:	50                   	push   %eax
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	ff d0                	call   *%eax
  800b59:	83 c4 10             	add    $0x10,%esp
			break;
  800b5c:	e9 89 02 00 00       	jmp    800dea <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b61:	8b 45 14             	mov    0x14(%ebp),%eax
  800b64:	83 c0 04             	add    $0x4,%eax
  800b67:	89 45 14             	mov    %eax,0x14(%ebp)
  800b6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b6d:	83 e8 04             	sub    $0x4,%eax
  800b70:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b72:	85 db                	test   %ebx,%ebx
  800b74:	79 02                	jns    800b78 <vprintfmt+0x14a>
				err = -err;
  800b76:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b78:	83 fb 64             	cmp    $0x64,%ebx
  800b7b:	7f 0b                	jg     800b88 <vprintfmt+0x15a>
  800b7d:	8b 34 9d 60 29 80 00 	mov    0x802960(,%ebx,4),%esi
  800b84:	85 f6                	test   %esi,%esi
  800b86:	75 19                	jne    800ba1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b88:	53                   	push   %ebx
  800b89:	68 05 2b 80 00       	push   $0x802b05
  800b8e:	ff 75 0c             	pushl  0xc(%ebp)
  800b91:	ff 75 08             	pushl  0x8(%ebp)
  800b94:	e8 5e 02 00 00       	call   800df7 <printfmt>
  800b99:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b9c:	e9 49 02 00 00       	jmp    800dea <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ba1:	56                   	push   %esi
  800ba2:	68 0e 2b 80 00       	push   $0x802b0e
  800ba7:	ff 75 0c             	pushl  0xc(%ebp)
  800baa:	ff 75 08             	pushl  0x8(%ebp)
  800bad:	e8 45 02 00 00       	call   800df7 <printfmt>
  800bb2:	83 c4 10             	add    $0x10,%esp
			break;
  800bb5:	e9 30 02 00 00       	jmp    800dea <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800bba:	8b 45 14             	mov    0x14(%ebp),%eax
  800bbd:	83 c0 04             	add    $0x4,%eax
  800bc0:	89 45 14             	mov    %eax,0x14(%ebp)
  800bc3:	8b 45 14             	mov    0x14(%ebp),%eax
  800bc6:	83 e8 04             	sub    $0x4,%eax
  800bc9:	8b 30                	mov    (%eax),%esi
  800bcb:	85 f6                	test   %esi,%esi
  800bcd:	75 05                	jne    800bd4 <vprintfmt+0x1a6>
				p = "(null)";
  800bcf:	be 11 2b 80 00       	mov    $0x802b11,%esi
			if (width > 0 && padc != '-')
  800bd4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bd8:	7e 6d                	jle    800c47 <vprintfmt+0x219>
  800bda:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bde:	74 67                	je     800c47 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800be0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800be3:	83 ec 08             	sub    $0x8,%esp
  800be6:	50                   	push   %eax
  800be7:	56                   	push   %esi
  800be8:	e8 0c 03 00 00       	call   800ef9 <strnlen>
  800bed:	83 c4 10             	add    $0x10,%esp
  800bf0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bf3:	eb 16                	jmp    800c0b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bf5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bf9:	83 ec 08             	sub    $0x8,%esp
  800bfc:	ff 75 0c             	pushl  0xc(%ebp)
  800bff:	50                   	push   %eax
  800c00:	8b 45 08             	mov    0x8(%ebp),%eax
  800c03:	ff d0                	call   *%eax
  800c05:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c08:	ff 4d e4             	decl   -0x1c(%ebp)
  800c0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0f:	7f e4                	jg     800bf5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c11:	eb 34                	jmp    800c47 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800c13:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800c17:	74 1c                	je     800c35 <vprintfmt+0x207>
  800c19:	83 fb 1f             	cmp    $0x1f,%ebx
  800c1c:	7e 05                	jle    800c23 <vprintfmt+0x1f5>
  800c1e:	83 fb 7e             	cmp    $0x7e,%ebx
  800c21:	7e 12                	jle    800c35 <vprintfmt+0x207>
					putch('?', putdat);
  800c23:	83 ec 08             	sub    $0x8,%esp
  800c26:	ff 75 0c             	pushl  0xc(%ebp)
  800c29:	6a 3f                	push   $0x3f
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	ff d0                	call   *%eax
  800c30:	83 c4 10             	add    $0x10,%esp
  800c33:	eb 0f                	jmp    800c44 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c35:	83 ec 08             	sub    $0x8,%esp
  800c38:	ff 75 0c             	pushl  0xc(%ebp)
  800c3b:	53                   	push   %ebx
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	ff d0                	call   *%eax
  800c41:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c44:	ff 4d e4             	decl   -0x1c(%ebp)
  800c47:	89 f0                	mov    %esi,%eax
  800c49:	8d 70 01             	lea    0x1(%eax),%esi
  800c4c:	8a 00                	mov    (%eax),%al
  800c4e:	0f be d8             	movsbl %al,%ebx
  800c51:	85 db                	test   %ebx,%ebx
  800c53:	74 24                	je     800c79 <vprintfmt+0x24b>
  800c55:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c59:	78 b8                	js     800c13 <vprintfmt+0x1e5>
  800c5b:	ff 4d e0             	decl   -0x20(%ebp)
  800c5e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c62:	79 af                	jns    800c13 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c64:	eb 13                	jmp    800c79 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c66:	83 ec 08             	sub    $0x8,%esp
  800c69:	ff 75 0c             	pushl  0xc(%ebp)
  800c6c:	6a 20                	push   $0x20
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	ff d0                	call   *%eax
  800c73:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c76:	ff 4d e4             	decl   -0x1c(%ebp)
  800c79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7d:	7f e7                	jg     800c66 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c7f:	e9 66 01 00 00       	jmp    800dea <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c84:	83 ec 08             	sub    $0x8,%esp
  800c87:	ff 75 e8             	pushl  -0x18(%ebp)
  800c8a:	8d 45 14             	lea    0x14(%ebp),%eax
  800c8d:	50                   	push   %eax
  800c8e:	e8 3c fd ff ff       	call   8009cf <getint>
  800c93:	83 c4 10             	add    $0x10,%esp
  800c96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c99:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca2:	85 d2                	test   %edx,%edx
  800ca4:	79 23                	jns    800cc9 <vprintfmt+0x29b>
				putch('-', putdat);
  800ca6:	83 ec 08             	sub    $0x8,%esp
  800ca9:	ff 75 0c             	pushl  0xc(%ebp)
  800cac:	6a 2d                	push   $0x2d
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	ff d0                	call   *%eax
  800cb3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800cb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cbc:	f7 d8                	neg    %eax
  800cbe:	83 d2 00             	adc    $0x0,%edx
  800cc1:	f7 da                	neg    %edx
  800cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800cc9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cd0:	e9 bc 00 00 00       	jmp    800d91 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cd5:	83 ec 08             	sub    $0x8,%esp
  800cd8:	ff 75 e8             	pushl  -0x18(%ebp)
  800cdb:	8d 45 14             	lea    0x14(%ebp),%eax
  800cde:	50                   	push   %eax
  800cdf:	e8 84 fc ff ff       	call   800968 <getuint>
  800ce4:	83 c4 10             	add    $0x10,%esp
  800ce7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ced:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cf4:	e9 98 00 00 00       	jmp    800d91 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cf9:	83 ec 08             	sub    $0x8,%esp
  800cfc:	ff 75 0c             	pushl  0xc(%ebp)
  800cff:	6a 58                	push   $0x58
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	ff d0                	call   *%eax
  800d06:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d09:	83 ec 08             	sub    $0x8,%esp
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	6a 58                	push   $0x58
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	ff d0                	call   *%eax
  800d16:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d19:	83 ec 08             	sub    $0x8,%esp
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	6a 58                	push   $0x58
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	ff d0                	call   *%eax
  800d26:	83 c4 10             	add    $0x10,%esp
			break;
  800d29:	e9 bc 00 00 00       	jmp    800dea <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d2e:	83 ec 08             	sub    $0x8,%esp
  800d31:	ff 75 0c             	pushl  0xc(%ebp)
  800d34:	6a 30                	push   $0x30
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	ff d0                	call   *%eax
  800d3b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d3e:	83 ec 08             	sub    $0x8,%esp
  800d41:	ff 75 0c             	pushl  0xc(%ebp)
  800d44:	6a 78                	push   $0x78
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	ff d0                	call   *%eax
  800d4b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d51:	83 c0 04             	add    $0x4,%eax
  800d54:	89 45 14             	mov    %eax,0x14(%ebp)
  800d57:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5a:	83 e8 04             	sub    $0x4,%eax
  800d5d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d62:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d69:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d70:	eb 1f                	jmp    800d91 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d72:	83 ec 08             	sub    $0x8,%esp
  800d75:	ff 75 e8             	pushl  -0x18(%ebp)
  800d78:	8d 45 14             	lea    0x14(%ebp),%eax
  800d7b:	50                   	push   %eax
  800d7c:	e8 e7 fb ff ff       	call   800968 <getuint>
  800d81:	83 c4 10             	add    $0x10,%esp
  800d84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d87:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d8a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d91:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d95:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d98:	83 ec 04             	sub    $0x4,%esp
  800d9b:	52                   	push   %edx
  800d9c:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d9f:	50                   	push   %eax
  800da0:	ff 75 f4             	pushl  -0xc(%ebp)
  800da3:	ff 75 f0             	pushl  -0x10(%ebp)
  800da6:	ff 75 0c             	pushl  0xc(%ebp)
  800da9:	ff 75 08             	pushl  0x8(%ebp)
  800dac:	e8 00 fb ff ff       	call   8008b1 <printnum>
  800db1:	83 c4 20             	add    $0x20,%esp
			break;
  800db4:	eb 34                	jmp    800dea <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800db6:	83 ec 08             	sub    $0x8,%esp
  800db9:	ff 75 0c             	pushl  0xc(%ebp)
  800dbc:	53                   	push   %ebx
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	ff d0                	call   *%eax
  800dc2:	83 c4 10             	add    $0x10,%esp
			break;
  800dc5:	eb 23                	jmp    800dea <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800dc7:	83 ec 08             	sub    $0x8,%esp
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	6a 25                	push   $0x25
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	ff d0                	call   *%eax
  800dd4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800dd7:	ff 4d 10             	decl   0x10(%ebp)
  800dda:	eb 03                	jmp    800ddf <vprintfmt+0x3b1>
  800ddc:	ff 4d 10             	decl   0x10(%ebp)
  800ddf:	8b 45 10             	mov    0x10(%ebp),%eax
  800de2:	48                   	dec    %eax
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	3c 25                	cmp    $0x25,%al
  800de7:	75 f3                	jne    800ddc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800de9:	90                   	nop
		}
	}
  800dea:	e9 47 fc ff ff       	jmp    800a36 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800def:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800df0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800df3:	5b                   	pop    %ebx
  800df4:	5e                   	pop    %esi
  800df5:	5d                   	pop    %ebp
  800df6:	c3                   	ret    

00800df7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800df7:	55                   	push   %ebp
  800df8:	89 e5                	mov    %esp,%ebp
  800dfa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dfd:	8d 45 10             	lea    0x10(%ebp),%eax
  800e00:	83 c0 04             	add    $0x4,%eax
  800e03:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e06:	8b 45 10             	mov    0x10(%ebp),%eax
  800e09:	ff 75 f4             	pushl  -0xc(%ebp)
  800e0c:	50                   	push   %eax
  800e0d:	ff 75 0c             	pushl  0xc(%ebp)
  800e10:	ff 75 08             	pushl  0x8(%ebp)
  800e13:	e8 16 fc ff ff       	call   800a2e <vprintfmt>
  800e18:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e1b:	90                   	nop
  800e1c:	c9                   	leave  
  800e1d:	c3                   	ret    

00800e1e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e1e:	55                   	push   %ebp
  800e1f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	8b 40 08             	mov    0x8(%eax),%eax
  800e27:	8d 50 01             	lea    0x1(%eax),%edx
  800e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e33:	8b 10                	mov    (%eax),%edx
  800e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e38:	8b 40 04             	mov    0x4(%eax),%eax
  800e3b:	39 c2                	cmp    %eax,%edx
  800e3d:	73 12                	jae    800e51 <sprintputch+0x33>
		*b->buf++ = ch;
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	8d 48 01             	lea    0x1(%eax),%ecx
  800e47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e4a:	89 0a                	mov    %ecx,(%edx)
  800e4c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e4f:	88 10                	mov    %dl,(%eax)
}
  800e51:	90                   	nop
  800e52:	5d                   	pop    %ebp
  800e53:	c3                   	ret    

00800e54 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e54:	55                   	push   %ebp
  800e55:	89 e5                	mov    %esp,%ebp
  800e57:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e63:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	01 d0                	add    %edx,%eax
  800e6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e75:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e79:	74 06                	je     800e81 <vsnprintf+0x2d>
  800e7b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e7f:	7f 07                	jg     800e88 <vsnprintf+0x34>
		return -E_INVAL;
  800e81:	b8 03 00 00 00       	mov    $0x3,%eax
  800e86:	eb 20                	jmp    800ea8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e88:	ff 75 14             	pushl  0x14(%ebp)
  800e8b:	ff 75 10             	pushl  0x10(%ebp)
  800e8e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e91:	50                   	push   %eax
  800e92:	68 1e 0e 80 00       	push   $0x800e1e
  800e97:	e8 92 fb ff ff       	call   800a2e <vprintfmt>
  800e9c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ea2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ea5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ea8:	c9                   	leave  
  800ea9:	c3                   	ret    

00800eaa <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800eaa:	55                   	push   %ebp
  800eab:	89 e5                	mov    %esp,%ebp
  800ead:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800eb0:	8d 45 10             	lea    0x10(%ebp),%eax
  800eb3:	83 c0 04             	add    $0x4,%eax
  800eb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800eb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebc:	ff 75 f4             	pushl  -0xc(%ebp)
  800ebf:	50                   	push   %eax
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	ff 75 08             	pushl  0x8(%ebp)
  800ec6:	e8 89 ff ff ff       	call   800e54 <vsnprintf>
  800ecb:	83 c4 10             	add    $0x10,%esp
  800ece:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ed1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ed4:	c9                   	leave  
  800ed5:	c3                   	ret    

00800ed6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ed6:	55                   	push   %ebp
  800ed7:	89 e5                	mov    %esp,%ebp
  800ed9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800edc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee3:	eb 06                	jmp    800eeb <strlen+0x15>
		n++;
  800ee5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	84 c0                	test   %al,%al
  800ef2:	75 f1                	jne    800ee5 <strlen+0xf>
		n++;
	return n;
  800ef4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ef7:	c9                   	leave  
  800ef8:	c3                   	ret    

00800ef9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ef9:	55                   	push   %ebp
  800efa:	89 e5                	mov    %esp,%ebp
  800efc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f06:	eb 09                	jmp    800f11 <strnlen+0x18>
		n++;
  800f08:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f0b:	ff 45 08             	incl   0x8(%ebp)
  800f0e:	ff 4d 0c             	decl   0xc(%ebp)
  800f11:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f15:	74 09                	je     800f20 <strnlen+0x27>
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	84 c0                	test   %al,%al
  800f1e:	75 e8                	jne    800f08 <strnlen+0xf>
		n++;
	return n;
  800f20:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f23:	c9                   	leave  
  800f24:	c3                   	ret    

00800f25 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f25:	55                   	push   %ebp
  800f26:	89 e5                	mov    %esp,%ebp
  800f28:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f31:	90                   	nop
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8d 50 01             	lea    0x1(%eax),%edx
  800f38:	89 55 08             	mov    %edx,0x8(%ebp)
  800f3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f41:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f44:	8a 12                	mov    (%edx),%dl
  800f46:	88 10                	mov    %dl,(%eax)
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	84 c0                	test   %al,%al
  800f4c:	75 e4                	jne    800f32 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f51:	c9                   	leave  
  800f52:	c3                   	ret    

00800f53 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f53:	55                   	push   %ebp
  800f54:	89 e5                	mov    %esp,%ebp
  800f56:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f66:	eb 1f                	jmp    800f87 <strncpy+0x34>
		*dst++ = *src;
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8d 50 01             	lea    0x1(%eax),%edx
  800f6e:	89 55 08             	mov    %edx,0x8(%ebp)
  800f71:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f74:	8a 12                	mov    (%edx),%dl
  800f76:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7b:	8a 00                	mov    (%eax),%al
  800f7d:	84 c0                	test   %al,%al
  800f7f:	74 03                	je     800f84 <strncpy+0x31>
			src++;
  800f81:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f84:	ff 45 fc             	incl   -0x4(%ebp)
  800f87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f8a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f8d:	72 d9                	jb     800f68 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f92:	c9                   	leave  
  800f93:	c3                   	ret    

00800f94 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f94:	55                   	push   %ebp
  800f95:	89 e5                	mov    %esp,%ebp
  800f97:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800fa0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa4:	74 30                	je     800fd6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800fa6:	eb 16                	jmp    800fbe <strlcpy+0x2a>
			*dst++ = *src++;
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8d 50 01             	lea    0x1(%eax),%edx
  800fae:	89 55 08             	mov    %edx,0x8(%ebp)
  800fb1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fb7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fba:	8a 12                	mov    (%edx),%dl
  800fbc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fbe:	ff 4d 10             	decl   0x10(%ebp)
  800fc1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc5:	74 09                	je     800fd0 <strlcpy+0x3c>
  800fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	84 c0                	test   %al,%al
  800fce:	75 d8                	jne    800fa8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fd6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdc:	29 c2                	sub    %eax,%edx
  800fde:	89 d0                	mov    %edx,%eax
}
  800fe0:	c9                   	leave  
  800fe1:	c3                   	ret    

00800fe2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fe5:	eb 06                	jmp    800fed <strcmp+0xb>
		p++, q++;
  800fe7:	ff 45 08             	incl   0x8(%ebp)
  800fea:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	84 c0                	test   %al,%al
  800ff4:	74 0e                	je     801004 <strcmp+0x22>
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	8a 10                	mov    (%eax),%dl
  800ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	38 c2                	cmp    %al,%dl
  801002:	74 e3                	je     800fe7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	0f b6 d0             	movzbl %al,%edx
  80100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100f:	8a 00                	mov    (%eax),%al
  801011:	0f b6 c0             	movzbl %al,%eax
  801014:	29 c2                	sub    %eax,%edx
  801016:	89 d0                	mov    %edx,%eax
}
  801018:	5d                   	pop    %ebp
  801019:	c3                   	ret    

0080101a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80101a:	55                   	push   %ebp
  80101b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80101d:	eb 09                	jmp    801028 <strncmp+0xe>
		n--, p++, q++;
  80101f:	ff 4d 10             	decl   0x10(%ebp)
  801022:	ff 45 08             	incl   0x8(%ebp)
  801025:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801028:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80102c:	74 17                	je     801045 <strncmp+0x2b>
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	8a 00                	mov    (%eax),%al
  801033:	84 c0                	test   %al,%al
  801035:	74 0e                	je     801045 <strncmp+0x2b>
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	8a 10                	mov    (%eax),%dl
  80103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103f:	8a 00                	mov    (%eax),%al
  801041:	38 c2                	cmp    %al,%dl
  801043:	74 da                	je     80101f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801045:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801049:	75 07                	jne    801052 <strncmp+0x38>
		return 0;
  80104b:	b8 00 00 00 00       	mov    $0x0,%eax
  801050:	eb 14                	jmp    801066 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	8a 00                	mov    (%eax),%al
  801057:	0f b6 d0             	movzbl %al,%edx
  80105a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105d:	8a 00                	mov    (%eax),%al
  80105f:	0f b6 c0             	movzbl %al,%eax
  801062:	29 c2                	sub    %eax,%edx
  801064:	89 d0                	mov    %edx,%eax
}
  801066:	5d                   	pop    %ebp
  801067:	c3                   	ret    

00801068 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801068:	55                   	push   %ebp
  801069:	89 e5                	mov    %esp,%ebp
  80106b:	83 ec 04             	sub    $0x4,%esp
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801074:	eb 12                	jmp    801088 <strchr+0x20>
		if (*s == c)
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80107e:	75 05                	jne    801085 <strchr+0x1d>
			return (char *) s;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	eb 11                	jmp    801096 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801085:	ff 45 08             	incl   0x8(%ebp)
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	84 c0                	test   %al,%al
  80108f:	75 e5                	jne    801076 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801091:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801096:	c9                   	leave  
  801097:	c3                   	ret    

00801098 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801098:	55                   	push   %ebp
  801099:	89 e5                	mov    %esp,%ebp
  80109b:	83 ec 04             	sub    $0x4,%esp
  80109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010a4:	eb 0d                	jmp    8010b3 <strfind+0x1b>
		if (*s == c)
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	8a 00                	mov    (%eax),%al
  8010ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010ae:	74 0e                	je     8010be <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8010b0:	ff 45 08             	incl   0x8(%ebp)
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	8a 00                	mov    (%eax),%al
  8010b8:	84 c0                	test   %al,%al
  8010ba:	75 ea                	jne    8010a6 <strfind+0xe>
  8010bc:	eb 01                	jmp    8010bf <strfind+0x27>
		if (*s == c)
			break;
  8010be:	90                   	nop
	return (char *) s;
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
  8010c7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8010d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8010d6:	eb 0e                	jmp    8010e6 <memset+0x22>
		*p++ = c;
  8010d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010db:	8d 50 01             	lea    0x1(%eax),%edx
  8010de:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8010e6:	ff 4d f8             	decl   -0x8(%ebp)
  8010e9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8010ed:	79 e9                	jns    8010d8 <memset+0x14>
		*p++ = c;

	return v;
  8010ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f2:	c9                   	leave  
  8010f3:	c3                   	ret    

008010f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010f4:	55                   	push   %ebp
  8010f5:	89 e5                	mov    %esp,%ebp
  8010f7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801106:	eb 16                	jmp    80111e <memcpy+0x2a>
		*d++ = *s++;
  801108:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110b:	8d 50 01             	lea    0x1(%eax),%edx
  80110e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801111:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801114:	8d 4a 01             	lea    0x1(%edx),%ecx
  801117:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80111a:	8a 12                	mov    (%edx),%dl
  80111c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80111e:	8b 45 10             	mov    0x10(%ebp),%eax
  801121:	8d 50 ff             	lea    -0x1(%eax),%edx
  801124:	89 55 10             	mov    %edx,0x10(%ebp)
  801127:	85 c0                	test   %eax,%eax
  801129:	75 dd                	jne    801108 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80112e:	c9                   	leave  
  80112f:	c3                   	ret    

00801130 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801130:	55                   	push   %ebp
  801131:	89 e5                	mov    %esp,%ebp
  801133:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801136:	8b 45 0c             	mov    0xc(%ebp),%eax
  801139:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801142:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801145:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801148:	73 50                	jae    80119a <memmove+0x6a>
  80114a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80114d:	8b 45 10             	mov    0x10(%ebp),%eax
  801150:	01 d0                	add    %edx,%eax
  801152:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801155:	76 43                	jbe    80119a <memmove+0x6a>
		s += n;
  801157:	8b 45 10             	mov    0x10(%ebp),%eax
  80115a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80115d:	8b 45 10             	mov    0x10(%ebp),%eax
  801160:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801163:	eb 10                	jmp    801175 <memmove+0x45>
			*--d = *--s;
  801165:	ff 4d f8             	decl   -0x8(%ebp)
  801168:	ff 4d fc             	decl   -0x4(%ebp)
  80116b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116e:	8a 10                	mov    (%eax),%dl
  801170:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801173:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801175:	8b 45 10             	mov    0x10(%ebp),%eax
  801178:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117b:	89 55 10             	mov    %edx,0x10(%ebp)
  80117e:	85 c0                	test   %eax,%eax
  801180:	75 e3                	jne    801165 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801182:	eb 23                	jmp    8011a7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801184:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801187:	8d 50 01             	lea    0x1(%eax),%edx
  80118a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80118d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801190:	8d 4a 01             	lea    0x1(%edx),%ecx
  801193:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801196:	8a 12                	mov    (%edx),%dl
  801198:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80119a:	8b 45 10             	mov    0x10(%ebp),%eax
  80119d:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a0:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a3:	85 c0                	test   %eax,%eax
  8011a5:	75 dd                	jne    801184 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011aa:	c9                   	leave  
  8011ab:	c3                   	ret    

008011ac <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8011ac:	55                   	push   %ebp
  8011ad:	89 e5                	mov    %esp,%ebp
  8011af:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8011b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8011be:	eb 2a                	jmp    8011ea <memcmp+0x3e>
		if (*s1 != *s2)
  8011c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c3:	8a 10                	mov    (%eax),%dl
  8011c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	38 c2                	cmp    %al,%dl
  8011cc:	74 16                	je     8011e4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d1:	8a 00                	mov    (%eax),%al
  8011d3:	0f b6 d0             	movzbl %al,%edx
  8011d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	0f b6 c0             	movzbl %al,%eax
  8011de:	29 c2                	sub    %eax,%edx
  8011e0:	89 d0                	mov    %edx,%eax
  8011e2:	eb 18                	jmp    8011fc <memcmp+0x50>
		s1++, s2++;
  8011e4:	ff 45 fc             	incl   -0x4(%ebp)
  8011e7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ed:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8011f3:	85 c0                	test   %eax,%eax
  8011f5:	75 c9                	jne    8011c0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011fc:	c9                   	leave  
  8011fd:	c3                   	ret    

008011fe <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011fe:	55                   	push   %ebp
  8011ff:	89 e5                	mov    %esp,%ebp
  801201:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801204:	8b 55 08             	mov    0x8(%ebp),%edx
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	01 d0                	add    %edx,%eax
  80120c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80120f:	eb 15                	jmp    801226 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	0f b6 d0             	movzbl %al,%edx
  801219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121c:	0f b6 c0             	movzbl %al,%eax
  80121f:	39 c2                	cmp    %eax,%edx
  801221:	74 0d                	je     801230 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801223:	ff 45 08             	incl   0x8(%ebp)
  801226:	8b 45 08             	mov    0x8(%ebp),%eax
  801229:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80122c:	72 e3                	jb     801211 <memfind+0x13>
  80122e:	eb 01                	jmp    801231 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801230:	90                   	nop
	return (void *) s;
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801234:	c9                   	leave  
  801235:	c3                   	ret    

00801236 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801236:	55                   	push   %ebp
  801237:	89 e5                	mov    %esp,%ebp
  801239:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80123c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801243:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80124a:	eb 03                	jmp    80124f <strtol+0x19>
		s++;
  80124c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	8a 00                	mov    (%eax),%al
  801254:	3c 20                	cmp    $0x20,%al
  801256:	74 f4                	je     80124c <strtol+0x16>
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	8a 00                	mov    (%eax),%al
  80125d:	3c 09                	cmp    $0x9,%al
  80125f:	74 eb                	je     80124c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	8a 00                	mov    (%eax),%al
  801266:	3c 2b                	cmp    $0x2b,%al
  801268:	75 05                	jne    80126f <strtol+0x39>
		s++;
  80126a:	ff 45 08             	incl   0x8(%ebp)
  80126d:	eb 13                	jmp    801282 <strtol+0x4c>
	else if (*s == '-')
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8a 00                	mov    (%eax),%al
  801274:	3c 2d                	cmp    $0x2d,%al
  801276:	75 0a                	jne    801282 <strtol+0x4c>
		s++, neg = 1;
  801278:	ff 45 08             	incl   0x8(%ebp)
  80127b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801282:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801286:	74 06                	je     80128e <strtol+0x58>
  801288:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80128c:	75 20                	jne    8012ae <strtol+0x78>
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8a 00                	mov    (%eax),%al
  801293:	3c 30                	cmp    $0x30,%al
  801295:	75 17                	jne    8012ae <strtol+0x78>
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	40                   	inc    %eax
  80129b:	8a 00                	mov    (%eax),%al
  80129d:	3c 78                	cmp    $0x78,%al
  80129f:	75 0d                	jne    8012ae <strtol+0x78>
		s += 2, base = 16;
  8012a1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012a5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8012ac:	eb 28                	jmp    8012d6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8012ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012b2:	75 15                	jne    8012c9 <strtol+0x93>
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	3c 30                	cmp    $0x30,%al
  8012bb:	75 0c                	jne    8012c9 <strtol+0x93>
		s++, base = 8;
  8012bd:	ff 45 08             	incl   0x8(%ebp)
  8012c0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012c7:	eb 0d                	jmp    8012d6 <strtol+0xa0>
	else if (base == 0)
  8012c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012cd:	75 07                	jne    8012d6 <strtol+0xa0>
		base = 10;
  8012cf:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	8a 00                	mov    (%eax),%al
  8012db:	3c 2f                	cmp    $0x2f,%al
  8012dd:	7e 19                	jle    8012f8 <strtol+0xc2>
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	8a 00                	mov    (%eax),%al
  8012e4:	3c 39                	cmp    $0x39,%al
  8012e6:	7f 10                	jg     8012f8 <strtol+0xc2>
			dig = *s - '0';
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	8a 00                	mov    (%eax),%al
  8012ed:	0f be c0             	movsbl %al,%eax
  8012f0:	83 e8 30             	sub    $0x30,%eax
  8012f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012f6:	eb 42                	jmp    80133a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	8a 00                	mov    (%eax),%al
  8012fd:	3c 60                	cmp    $0x60,%al
  8012ff:	7e 19                	jle    80131a <strtol+0xe4>
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	3c 7a                	cmp    $0x7a,%al
  801308:	7f 10                	jg     80131a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80130a:	8b 45 08             	mov    0x8(%ebp),%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	0f be c0             	movsbl %al,%eax
  801312:	83 e8 57             	sub    $0x57,%eax
  801315:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801318:	eb 20                	jmp    80133a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	8a 00                	mov    (%eax),%al
  80131f:	3c 40                	cmp    $0x40,%al
  801321:	7e 39                	jle    80135c <strtol+0x126>
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	8a 00                	mov    (%eax),%al
  801328:	3c 5a                	cmp    $0x5a,%al
  80132a:	7f 30                	jg     80135c <strtol+0x126>
			dig = *s - 'A' + 10;
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	8a 00                	mov    (%eax),%al
  801331:	0f be c0             	movsbl %al,%eax
  801334:	83 e8 37             	sub    $0x37,%eax
  801337:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80133a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80133d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801340:	7d 19                	jge    80135b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801342:	ff 45 08             	incl   0x8(%ebp)
  801345:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801348:	0f af 45 10          	imul   0x10(%ebp),%eax
  80134c:	89 c2                	mov    %eax,%edx
  80134e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801351:	01 d0                	add    %edx,%eax
  801353:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801356:	e9 7b ff ff ff       	jmp    8012d6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80135b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80135c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801360:	74 08                	je     80136a <strtol+0x134>
		*endptr = (char *) s;
  801362:	8b 45 0c             	mov    0xc(%ebp),%eax
  801365:	8b 55 08             	mov    0x8(%ebp),%edx
  801368:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80136a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80136e:	74 07                	je     801377 <strtol+0x141>
  801370:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801373:	f7 d8                	neg    %eax
  801375:	eb 03                	jmp    80137a <strtol+0x144>
  801377:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <ltostr>:

void
ltostr(long value, char *str)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
  80137f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801389:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801390:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801394:	79 13                	jns    8013a9 <ltostr+0x2d>
	{
		neg = 1;
  801396:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80139d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013a3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8013a6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8013b1:	99                   	cltd   
  8013b2:	f7 f9                	idiv   %ecx
  8013b4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8013b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ba:	8d 50 01             	lea    0x1(%eax),%edx
  8013bd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013c0:	89 c2                	mov    %eax,%edx
  8013c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c5:	01 d0                	add    %edx,%eax
  8013c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013ca:	83 c2 30             	add    $0x30,%edx
  8013cd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013d2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013d7:	f7 e9                	imul   %ecx
  8013d9:	c1 fa 02             	sar    $0x2,%edx
  8013dc:	89 c8                	mov    %ecx,%eax
  8013de:	c1 f8 1f             	sar    $0x1f,%eax
  8013e1:	29 c2                	sub    %eax,%edx
  8013e3:	89 d0                	mov    %edx,%eax
  8013e5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8013e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013eb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013f0:	f7 e9                	imul   %ecx
  8013f2:	c1 fa 02             	sar    $0x2,%edx
  8013f5:	89 c8                	mov    %ecx,%eax
  8013f7:	c1 f8 1f             	sar    $0x1f,%eax
  8013fa:	29 c2                	sub    %eax,%edx
  8013fc:	89 d0                	mov    %edx,%eax
  8013fe:	c1 e0 02             	shl    $0x2,%eax
  801401:	01 d0                	add    %edx,%eax
  801403:	01 c0                	add    %eax,%eax
  801405:	29 c1                	sub    %eax,%ecx
  801407:	89 ca                	mov    %ecx,%edx
  801409:	85 d2                	test   %edx,%edx
  80140b:	75 9c                	jne    8013a9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80140d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801414:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801417:	48                   	dec    %eax
  801418:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80141b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80141f:	74 3d                	je     80145e <ltostr+0xe2>
		start = 1 ;
  801421:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801428:	eb 34                	jmp    80145e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80142a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80142d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801430:	01 d0                	add    %edx,%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801437:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80143a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143d:	01 c2                	add    %eax,%edx
  80143f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801442:	8b 45 0c             	mov    0xc(%ebp),%eax
  801445:	01 c8                	add    %ecx,%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80144b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80144e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801451:	01 c2                	add    %eax,%edx
  801453:	8a 45 eb             	mov    -0x15(%ebp),%al
  801456:	88 02                	mov    %al,(%edx)
		start++ ;
  801458:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80145b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80145e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801461:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801464:	7c c4                	jl     80142a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801466:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146c:	01 d0                	add    %edx,%eax
  80146e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801471:	90                   	nop
  801472:	c9                   	leave  
  801473:	c3                   	ret    

00801474 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801474:	55                   	push   %ebp
  801475:	89 e5                	mov    %esp,%ebp
  801477:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80147a:	ff 75 08             	pushl  0x8(%ebp)
  80147d:	e8 54 fa ff ff       	call   800ed6 <strlen>
  801482:	83 c4 04             	add    $0x4,%esp
  801485:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801488:	ff 75 0c             	pushl  0xc(%ebp)
  80148b:	e8 46 fa ff ff       	call   800ed6 <strlen>
  801490:	83 c4 04             	add    $0x4,%esp
  801493:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801496:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80149d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a4:	eb 17                	jmp    8014bd <strcconcat+0x49>
		final[s] = str1[s] ;
  8014a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ac:	01 c2                	add    %eax,%edx
  8014ae:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b4:	01 c8                	add    %ecx,%eax
  8014b6:	8a 00                	mov    (%eax),%al
  8014b8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8014ba:	ff 45 fc             	incl   -0x4(%ebp)
  8014bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014c3:	7c e1                	jl     8014a6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014cc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014d3:	eb 1f                	jmp    8014f4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d8:	8d 50 01             	lea    0x1(%eax),%edx
  8014db:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014de:	89 c2                	mov    %eax,%edx
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	01 c2                	add    %eax,%edx
  8014e5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014eb:	01 c8                	add    %ecx,%eax
  8014ed:	8a 00                	mov    (%eax),%al
  8014ef:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014f1:	ff 45 f8             	incl   -0x8(%ebp)
  8014f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014fa:	7c d9                	jl     8014d5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8014fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801502:	01 d0                	add    %edx,%eax
  801504:	c6 00 00             	movb   $0x0,(%eax)
}
  801507:	90                   	nop
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80150d:	8b 45 14             	mov    0x14(%ebp),%eax
  801510:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801516:	8b 45 14             	mov    0x14(%ebp),%eax
  801519:	8b 00                	mov    (%eax),%eax
  80151b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801522:	8b 45 10             	mov    0x10(%ebp),%eax
  801525:	01 d0                	add    %edx,%eax
  801527:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80152d:	eb 0c                	jmp    80153b <strsplit+0x31>
			*string++ = 0;
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	8d 50 01             	lea    0x1(%eax),%edx
  801535:	89 55 08             	mov    %edx,0x8(%ebp)
  801538:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	84 c0                	test   %al,%al
  801542:	74 18                	je     80155c <strsplit+0x52>
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
  801547:	8a 00                	mov    (%eax),%al
  801549:	0f be c0             	movsbl %al,%eax
  80154c:	50                   	push   %eax
  80154d:	ff 75 0c             	pushl  0xc(%ebp)
  801550:	e8 13 fb ff ff       	call   801068 <strchr>
  801555:	83 c4 08             	add    $0x8,%esp
  801558:	85 c0                	test   %eax,%eax
  80155a:	75 d3                	jne    80152f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	84 c0                	test   %al,%al
  801563:	74 5a                	je     8015bf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801565:	8b 45 14             	mov    0x14(%ebp),%eax
  801568:	8b 00                	mov    (%eax),%eax
  80156a:	83 f8 0f             	cmp    $0xf,%eax
  80156d:	75 07                	jne    801576 <strsplit+0x6c>
		{
			return 0;
  80156f:	b8 00 00 00 00       	mov    $0x0,%eax
  801574:	eb 66                	jmp    8015dc <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801576:	8b 45 14             	mov    0x14(%ebp),%eax
  801579:	8b 00                	mov    (%eax),%eax
  80157b:	8d 48 01             	lea    0x1(%eax),%ecx
  80157e:	8b 55 14             	mov    0x14(%ebp),%edx
  801581:	89 0a                	mov    %ecx,(%edx)
  801583:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80158a:	8b 45 10             	mov    0x10(%ebp),%eax
  80158d:	01 c2                	add    %eax,%edx
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801594:	eb 03                	jmp    801599 <strsplit+0x8f>
			string++;
  801596:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 00                	mov    (%eax),%al
  80159e:	84 c0                	test   %al,%al
  8015a0:	74 8b                	je     80152d <strsplit+0x23>
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	0f be c0             	movsbl %al,%eax
  8015aa:	50                   	push   %eax
  8015ab:	ff 75 0c             	pushl  0xc(%ebp)
  8015ae:	e8 b5 fa ff ff       	call   801068 <strchr>
  8015b3:	83 c4 08             	add    $0x8,%esp
  8015b6:	85 c0                	test   %eax,%eax
  8015b8:	74 dc                	je     801596 <strsplit+0x8c>
			string++;
	}
  8015ba:	e9 6e ff ff ff       	jmp    80152d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8015bf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8015c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c3:	8b 00                	mov    (%eax),%eax
  8015c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cf:	01 d0                	add    %edx,%eax
  8015d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8015d7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8015dc:	c9                   	leave  
  8015dd:	c3                   	ret    

008015de <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  8015de:	55                   	push   %ebp
  8015df:	89 e5                	mov    %esp,%ebp
  8015e1:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	c1 e8 0c             	shr    $0xc,%eax
  8015ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	25 ff 0f 00 00       	and    $0xfff,%eax
  8015f5:	85 c0                	test   %eax,%eax
  8015f7:	74 03                	je     8015fc <malloc+0x1e>
		num++;
  8015f9:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  8015fc:	a1 28 30 80 00       	mov    0x803028,%eax
  801601:	85 c0                	test   %eax,%eax
  801603:	75 71                	jne    801676 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  801605:	a1 04 30 80 00       	mov    0x803004,%eax
  80160a:	83 ec 08             	sub    $0x8,%esp
  80160d:	ff 75 08             	pushl  0x8(%ebp)
  801610:	50                   	push   %eax
  801611:	e8 e4 04 00 00       	call   801afa <sys_allocateMem>
  801616:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801619:	a1 04 30 80 00       	mov    0x803004,%eax
  80161e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801621:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801624:	c1 e0 0c             	shl    $0xc,%eax
  801627:	89 c2                	mov    %eax,%edx
  801629:	a1 04 30 80 00       	mov    0x803004,%eax
  80162e:	01 d0                	add    %edx,%eax
  801630:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801635:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80163a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80163d:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801644:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801649:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80164c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801653:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801658:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80165f:	01 00 00 00 
		sizeofarray++;
  801663:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801668:	40                   	inc    %eax
  801669:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  80166e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801671:	e9 f7 00 00 00       	jmp    80176d <malloc+0x18f>
	} else {
		int count = 0;
  801676:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  80167d:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801684:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80168b:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801692:	eb 7c                	jmp    801710 <malloc+0x132>
		{
			uint32 *pg = NULL;
  801694:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  80169b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8016a2:	eb 1a                	jmp    8016be <malloc+0xe0>
				if (addresses[j] == i) {
  8016a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8016a7:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8016ae:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8016b1:	75 08                	jne    8016bb <malloc+0xdd>
					index = j;
  8016b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8016b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  8016b9:	eb 0d                	jmp    8016c8 <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  8016bb:	ff 45 dc             	incl   -0x24(%ebp)
  8016be:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016c3:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8016c6:	7c dc                	jl     8016a4 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  8016c8:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8016cc:	75 05                	jne    8016d3 <malloc+0xf5>
				count++;
  8016ce:	ff 45 f0             	incl   -0x10(%ebp)
  8016d1:	eb 36                	jmp    801709 <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  8016d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016d6:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8016dd:	85 c0                	test   %eax,%eax
  8016df:	75 05                	jne    8016e6 <malloc+0x108>
					count++;
  8016e1:	ff 45 f0             	incl   -0x10(%ebp)
  8016e4:	eb 23                	jmp    801709 <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  8016e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016e9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8016ec:	7d 14                	jge    801702 <malloc+0x124>
  8016ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016f4:	7c 0c                	jl     801702 <malloc+0x124>
						min = count;
  8016f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  8016fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  801702:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801709:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801710:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801717:	0f 86 77 ff ff ff    	jbe    801694 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  80171d:	83 ec 08             	sub    $0x8,%esp
  801720:	ff 75 08             	pushl  0x8(%ebp)
  801723:	ff 75 e4             	pushl  -0x1c(%ebp)
  801726:	e8 cf 03 00 00       	call   801afa <sys_allocateMem>
  80172b:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  80172e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801733:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801736:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  80173d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801742:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801748:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  80174f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801754:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80175b:	01 00 00 00 
		sizeofarray++;
  80175f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801764:	40                   	inc    %eax
  801765:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) min_addresss;
  80176a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
  801772:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  80177b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801782:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801789:	eb 30                	jmp    8017bb <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  80178b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80178e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801795:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801798:	75 1e                	jne    8017b8 <free+0x49>
  80179a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80179d:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8017a4:	83 f8 01             	cmp    $0x1,%eax
  8017a7:	75 0f                	jne    8017b8 <free+0x49>
			is_found = 1;
  8017a9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8017b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8017b6:	eb 0d                	jmp    8017c5 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8017b8:	ff 45 ec             	incl   -0x14(%ebp)
  8017bb:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017c0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8017c3:	7c c6                	jl     80178b <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8017c5:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8017c9:	75 4f                	jne    80181a <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  8017cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017ce:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8017d5:	c1 e0 0c             	shl    $0xc,%eax
  8017d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  8017db:	83 ec 08             	sub    $0x8,%esp
  8017de:	ff 75 e4             	pushl  -0x1c(%ebp)
  8017e1:	68 70 2c 80 00       	push   $0x802c70
  8017e6:	e8 69 f0 ff ff       	call   800854 <cprintf>
  8017eb:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  8017ee:	83 ec 08             	sub    $0x8,%esp
  8017f1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8017f4:	ff 75 e8             	pushl  -0x18(%ebp)
  8017f7:	e8 e2 02 00 00       	call   801ade <sys_freeMem>
  8017fc:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  8017ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801802:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801809:	00 00 00 00 
		changes++;
  80180d:	a1 28 30 80 00       	mov    0x803028,%eax
  801812:	40                   	inc    %eax
  801813:	a3 28 30 80 00       	mov    %eax,0x803028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801818:	eb 39                	jmp    801853 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  80181a:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801821:	83 ec 08             	sub    $0x8,%esp
  801824:	ff 75 e4             	pushl  -0x1c(%ebp)
  801827:	68 70 2c 80 00       	push   $0x802c70
  80182c:	e8 23 f0 ff ff       	call   800854 <cprintf>
  801831:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801834:	83 ec 08             	sub    $0x8,%esp
  801837:	ff 75 e4             	pushl  -0x1c(%ebp)
  80183a:	ff 75 e8             	pushl  -0x18(%ebp)
  80183d:	e8 9c 02 00 00       	call   801ade <sys_freeMem>
  801842:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801845:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801848:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  80184f:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801853:	90                   	nop
  801854:	c9                   	leave  
  801855:	c3                   	ret    

00801856 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
  801859:	83 ec 18             	sub    $0x18,%esp
  80185c:	8b 45 10             	mov    0x10(%ebp),%eax
  80185f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801862:	83 ec 04             	sub    $0x4,%esp
  801865:	68 90 2c 80 00       	push   $0x802c90
  80186a:	68 9d 00 00 00       	push   $0x9d
  80186f:	68 b3 2c 80 00       	push   $0x802cb3
  801874:	e8 39 ed ff ff       	call   8005b2 <_panic>

00801879 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
  80187c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80187f:	83 ec 04             	sub    $0x4,%esp
  801882:	68 90 2c 80 00       	push   $0x802c90
  801887:	68 a2 00 00 00       	push   $0xa2
  80188c:	68 b3 2c 80 00       	push   $0x802cb3
  801891:	e8 1c ed ff ff       	call   8005b2 <_panic>

00801896 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801896:	55                   	push   %ebp
  801897:	89 e5                	mov    %esp,%ebp
  801899:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80189c:	83 ec 04             	sub    $0x4,%esp
  80189f:	68 90 2c 80 00       	push   $0x802c90
  8018a4:	68 a7 00 00 00       	push   $0xa7
  8018a9:	68 b3 2c 80 00       	push   $0x802cb3
  8018ae:	e8 ff ec ff ff       	call   8005b2 <_panic>

008018b3 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8018b3:	55                   	push   %ebp
  8018b4:	89 e5                	mov    %esp,%ebp
  8018b6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018b9:	83 ec 04             	sub    $0x4,%esp
  8018bc:	68 90 2c 80 00       	push   $0x802c90
  8018c1:	68 ab 00 00 00       	push   $0xab
  8018c6:	68 b3 2c 80 00       	push   $0x802cb3
  8018cb:	e8 e2 ec ff ff       	call   8005b2 <_panic>

008018d0 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
  8018d3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018d6:	83 ec 04             	sub    $0x4,%esp
  8018d9:	68 90 2c 80 00       	push   $0x802c90
  8018de:	68 b0 00 00 00       	push   $0xb0
  8018e3:	68 b3 2c 80 00       	push   $0x802cb3
  8018e8:	e8 c5 ec ff ff       	call   8005b2 <_panic>

008018ed <shrink>:
}
void shrink(uint32 newSize) {
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
  8018f0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018f3:	83 ec 04             	sub    $0x4,%esp
  8018f6:	68 90 2c 80 00       	push   $0x802c90
  8018fb:	68 b3 00 00 00       	push   $0xb3
  801900:	68 b3 2c 80 00       	push   $0x802cb3
  801905:	e8 a8 ec ff ff       	call   8005b2 <_panic>

0080190a <freeHeap>:
}

void freeHeap(void* virtual_address) {
  80190a:	55                   	push   %ebp
  80190b:	89 e5                	mov    %esp,%ebp
  80190d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801910:	83 ec 04             	sub    $0x4,%esp
  801913:	68 90 2c 80 00       	push   $0x802c90
  801918:	68 b7 00 00 00       	push   $0xb7
  80191d:	68 b3 2c 80 00       	push   $0x802cb3
  801922:	e8 8b ec ff ff       	call   8005b2 <_panic>

00801927 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
  80192a:	57                   	push   %edi
  80192b:	56                   	push   %esi
  80192c:	53                   	push   %ebx
  80192d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801930:	8b 45 08             	mov    0x8(%ebp),%eax
  801933:	8b 55 0c             	mov    0xc(%ebp),%edx
  801936:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801939:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80193c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80193f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801942:	cd 30                	int    $0x30
  801944:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801947:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80194a:	83 c4 10             	add    $0x10,%esp
  80194d:	5b                   	pop    %ebx
  80194e:	5e                   	pop    %esi
  80194f:	5f                   	pop    %edi
  801950:	5d                   	pop    %ebp
  801951:	c3                   	ret    

00801952 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	83 ec 04             	sub    $0x4,%esp
  801958:	8b 45 10             	mov    0x10(%ebp),%eax
  80195b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80195e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	52                   	push   %edx
  80196a:	ff 75 0c             	pushl  0xc(%ebp)
  80196d:	50                   	push   %eax
  80196e:	6a 00                	push   $0x0
  801970:	e8 b2 ff ff ff       	call   801927 <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	90                   	nop
  801979:	c9                   	leave  
  80197a:	c3                   	ret    

0080197b <sys_cgetc>:

int
sys_cgetc(void)
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 01                	push   $0x1
  80198a:	e8 98 ff ff ff       	call   801927 <syscall>
  80198f:	83 c4 18             	add    $0x18,%esp
}
  801992:	c9                   	leave  
  801993:	c3                   	ret    

00801994 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801994:	55                   	push   %ebp
  801995:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801997:	8b 45 08             	mov    0x8(%ebp),%eax
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	50                   	push   %eax
  8019a3:	6a 05                	push   $0x5
  8019a5:	e8 7d ff ff ff       	call   801927 <syscall>
  8019aa:	83 c4 18             	add    $0x18,%esp
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 02                	push   $0x2
  8019be:	e8 64 ff ff ff       	call   801927 <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 03                	push   $0x3
  8019d7:	e8 4b ff ff ff       	call   801927 <syscall>
  8019dc:	83 c4 18             	add    $0x18,%esp
}
  8019df:	c9                   	leave  
  8019e0:	c3                   	ret    

008019e1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019e1:	55                   	push   %ebp
  8019e2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 04                	push   $0x4
  8019f0:	e8 32 ff ff ff       	call   801927 <syscall>
  8019f5:	83 c4 18             	add    $0x18,%esp
}
  8019f8:	c9                   	leave  
  8019f9:	c3                   	ret    

008019fa <sys_env_exit>:


void sys_env_exit(void)
{
  8019fa:	55                   	push   %ebp
  8019fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 06                	push   $0x6
  801a09:	e8 19 ff ff ff       	call   801927 <syscall>
  801a0e:	83 c4 18             	add    $0x18,%esp
}
  801a11:	90                   	nop
  801a12:	c9                   	leave  
  801a13:	c3                   	ret    

00801a14 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a14:	55                   	push   %ebp
  801a15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	52                   	push   %edx
  801a24:	50                   	push   %eax
  801a25:	6a 07                	push   $0x7
  801a27:	e8 fb fe ff ff       	call   801927 <syscall>
  801a2c:	83 c4 18             	add    $0x18,%esp
}
  801a2f:	c9                   	leave  
  801a30:	c3                   	ret    

00801a31 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a31:	55                   	push   %ebp
  801a32:	89 e5                	mov    %esp,%ebp
  801a34:	56                   	push   %esi
  801a35:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a36:	8b 75 18             	mov    0x18(%ebp),%esi
  801a39:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a3c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a42:	8b 45 08             	mov    0x8(%ebp),%eax
  801a45:	56                   	push   %esi
  801a46:	53                   	push   %ebx
  801a47:	51                   	push   %ecx
  801a48:	52                   	push   %edx
  801a49:	50                   	push   %eax
  801a4a:	6a 08                	push   $0x8
  801a4c:	e8 d6 fe ff ff       	call   801927 <syscall>
  801a51:	83 c4 18             	add    $0x18,%esp
}
  801a54:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a57:	5b                   	pop    %ebx
  801a58:	5e                   	pop    %esi
  801a59:	5d                   	pop    %ebp
  801a5a:	c3                   	ret    

00801a5b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a61:	8b 45 08             	mov    0x8(%ebp),%eax
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	52                   	push   %edx
  801a6b:	50                   	push   %eax
  801a6c:	6a 09                	push   $0x9
  801a6e:	e8 b4 fe ff ff       	call   801927 <syscall>
  801a73:	83 c4 18             	add    $0x18,%esp
}
  801a76:	c9                   	leave  
  801a77:	c3                   	ret    

00801a78 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a78:	55                   	push   %ebp
  801a79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	ff 75 08             	pushl  0x8(%ebp)
  801a87:	6a 0a                	push   $0xa
  801a89:	e8 99 fe ff ff       	call   801927 <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
}
  801a91:	c9                   	leave  
  801a92:	c3                   	ret    

00801a93 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 0b                	push   $0xb
  801aa2:	e8 80 fe ff ff       	call   801927 <syscall>
  801aa7:	83 c4 18             	add    $0x18,%esp
}
  801aaa:	c9                   	leave  
  801aab:	c3                   	ret    

00801aac <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801aac:	55                   	push   %ebp
  801aad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 0c                	push   $0xc
  801abb:	e8 67 fe ff ff       	call   801927 <syscall>
  801ac0:	83 c4 18             	add    $0x18,%esp
}
  801ac3:	c9                   	leave  
  801ac4:	c3                   	ret    

00801ac5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ac5:	55                   	push   %ebp
  801ac6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 0d                	push   $0xd
  801ad4:	e8 4e fe ff ff       	call   801927 <syscall>
  801ad9:	83 c4 18             	add    $0x18,%esp
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	ff 75 0c             	pushl  0xc(%ebp)
  801aea:	ff 75 08             	pushl  0x8(%ebp)
  801aed:	6a 11                	push   $0x11
  801aef:	e8 33 fe ff ff       	call   801927 <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
	return;
  801af7:	90                   	nop
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	ff 75 0c             	pushl  0xc(%ebp)
  801b06:	ff 75 08             	pushl  0x8(%ebp)
  801b09:	6a 12                	push   $0x12
  801b0b:	e8 17 fe ff ff       	call   801927 <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
	return ;
  801b13:	90                   	nop
}
  801b14:	c9                   	leave  
  801b15:	c3                   	ret    

00801b16 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b16:	55                   	push   %ebp
  801b17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 0e                	push   $0xe
  801b25:	e8 fd fd ff ff       	call   801927 <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
}
  801b2d:	c9                   	leave  
  801b2e:	c3                   	ret    

00801b2f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	ff 75 08             	pushl  0x8(%ebp)
  801b3d:	6a 0f                	push   $0xf
  801b3f:	e8 e3 fd ff ff       	call   801927 <syscall>
  801b44:	83 c4 18             	add    $0x18,%esp
}
  801b47:	c9                   	leave  
  801b48:	c3                   	ret    

00801b49 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 10                	push   $0x10
  801b58:	e8 ca fd ff ff       	call   801927 <syscall>
  801b5d:	83 c4 18             	add    $0x18,%esp
}
  801b60:	90                   	nop
  801b61:	c9                   	leave  
  801b62:	c3                   	ret    

00801b63 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 14                	push   $0x14
  801b72:	e8 b0 fd ff ff       	call   801927 <syscall>
  801b77:	83 c4 18             	add    $0x18,%esp
}
  801b7a:	90                   	nop
  801b7b:	c9                   	leave  
  801b7c:	c3                   	ret    

00801b7d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 15                	push   $0x15
  801b8c:	e8 96 fd ff ff       	call   801927 <syscall>
  801b91:	83 c4 18             	add    $0x18,%esp
}
  801b94:	90                   	nop
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <sys_cputc>:


void
sys_cputc(const char c)
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
  801b9a:	83 ec 04             	sub    $0x4,%esp
  801b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ba3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	50                   	push   %eax
  801bb0:	6a 16                	push   $0x16
  801bb2:	e8 70 fd ff ff       	call   801927 <syscall>
  801bb7:	83 c4 18             	add    $0x18,%esp
}
  801bba:	90                   	nop
  801bbb:	c9                   	leave  
  801bbc:	c3                   	ret    

00801bbd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801bbd:	55                   	push   %ebp
  801bbe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 17                	push   $0x17
  801bcc:	e8 56 fd ff ff       	call   801927 <syscall>
  801bd1:	83 c4 18             	add    $0x18,%esp
}
  801bd4:	90                   	nop
  801bd5:	c9                   	leave  
  801bd6:	c3                   	ret    

00801bd7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801bda:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	ff 75 0c             	pushl  0xc(%ebp)
  801be6:	50                   	push   %eax
  801be7:	6a 18                	push   $0x18
  801be9:	e8 39 fd ff ff       	call   801927 <syscall>
  801bee:	83 c4 18             	add    $0x18,%esp
}
  801bf1:	c9                   	leave  
  801bf2:	c3                   	ret    

00801bf3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	52                   	push   %edx
  801c03:	50                   	push   %eax
  801c04:	6a 1b                	push   $0x1b
  801c06:	e8 1c fd ff ff       	call   801927 <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
}
  801c0e:	c9                   	leave  
  801c0f:	c3                   	ret    

00801c10 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c10:	55                   	push   %ebp
  801c11:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c16:	8b 45 08             	mov    0x8(%ebp),%eax
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	52                   	push   %edx
  801c20:	50                   	push   %eax
  801c21:	6a 19                	push   $0x19
  801c23:	e8 ff fc ff ff       	call   801927 <syscall>
  801c28:	83 c4 18             	add    $0x18,%esp
}
  801c2b:	90                   	nop
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c34:	8b 45 08             	mov    0x8(%ebp),%eax
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	52                   	push   %edx
  801c3e:	50                   	push   %eax
  801c3f:	6a 1a                	push   $0x1a
  801c41:	e8 e1 fc ff ff       	call   801927 <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
}
  801c49:	90                   	nop
  801c4a:	c9                   	leave  
  801c4b:	c3                   	ret    

00801c4c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
  801c4f:	83 ec 04             	sub    $0x4,%esp
  801c52:	8b 45 10             	mov    0x10(%ebp),%eax
  801c55:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c58:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c5b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c62:	6a 00                	push   $0x0
  801c64:	51                   	push   %ecx
  801c65:	52                   	push   %edx
  801c66:	ff 75 0c             	pushl  0xc(%ebp)
  801c69:	50                   	push   %eax
  801c6a:	6a 1c                	push   $0x1c
  801c6c:	e8 b6 fc ff ff       	call   801927 <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c79:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	52                   	push   %edx
  801c86:	50                   	push   %eax
  801c87:	6a 1d                	push   $0x1d
  801c89:	e8 99 fc ff ff       	call   801927 <syscall>
  801c8e:	83 c4 18             	add    $0x18,%esp
}
  801c91:	c9                   	leave  
  801c92:	c3                   	ret    

00801c93 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c93:	55                   	push   %ebp
  801c94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c96:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	51                   	push   %ecx
  801ca4:	52                   	push   %edx
  801ca5:	50                   	push   %eax
  801ca6:	6a 1e                	push   $0x1e
  801ca8:	e8 7a fc ff ff       	call   801927 <syscall>
  801cad:	83 c4 18             	add    $0x18,%esp
}
  801cb0:	c9                   	leave  
  801cb1:	c3                   	ret    

00801cb2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801cb2:	55                   	push   %ebp
  801cb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801cb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	52                   	push   %edx
  801cc2:	50                   	push   %eax
  801cc3:	6a 1f                	push   $0x1f
  801cc5:	e8 5d fc ff ff       	call   801927 <syscall>
  801cca:	83 c4 18             	add    $0x18,%esp
}
  801ccd:	c9                   	leave  
  801cce:	c3                   	ret    

00801ccf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 20                	push   $0x20
  801cde:	e8 44 fc ff ff       	call   801927 <syscall>
  801ce3:	83 c4 18             	add    $0x18,%esp
}
  801ce6:	c9                   	leave  
  801ce7:	c3                   	ret    

00801ce8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cee:	6a 00                	push   $0x0
  801cf0:	ff 75 14             	pushl  0x14(%ebp)
  801cf3:	ff 75 10             	pushl  0x10(%ebp)
  801cf6:	ff 75 0c             	pushl  0xc(%ebp)
  801cf9:	50                   	push   %eax
  801cfa:	6a 21                	push   $0x21
  801cfc:	e8 26 fc ff ff       	call   801927 <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d09:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	50                   	push   %eax
  801d15:	6a 22                	push   $0x22
  801d17:	e8 0b fc ff ff       	call   801927 <syscall>
  801d1c:	83 c4 18             	add    $0x18,%esp
}
  801d1f:	90                   	nop
  801d20:	c9                   	leave  
  801d21:	c3                   	ret    

00801d22 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d22:	55                   	push   %ebp
  801d23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d25:	8b 45 08             	mov    0x8(%ebp),%eax
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	50                   	push   %eax
  801d31:	6a 23                	push   $0x23
  801d33:	e8 ef fb ff ff       	call   801927 <syscall>
  801d38:	83 c4 18             	add    $0x18,%esp
}
  801d3b:	90                   	nop
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
  801d41:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d44:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d47:	8d 50 04             	lea    0x4(%eax),%edx
  801d4a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	52                   	push   %edx
  801d54:	50                   	push   %eax
  801d55:	6a 24                	push   $0x24
  801d57:	e8 cb fb ff ff       	call   801927 <syscall>
  801d5c:	83 c4 18             	add    $0x18,%esp
	return result;
  801d5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d62:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d65:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d68:	89 01                	mov    %eax,(%ecx)
  801d6a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d70:	c9                   	leave  
  801d71:	c2 04 00             	ret    $0x4

00801d74 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d74:	55                   	push   %ebp
  801d75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	ff 75 10             	pushl  0x10(%ebp)
  801d7e:	ff 75 0c             	pushl  0xc(%ebp)
  801d81:	ff 75 08             	pushl  0x8(%ebp)
  801d84:	6a 13                	push   $0x13
  801d86:	e8 9c fb ff ff       	call   801927 <syscall>
  801d8b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d8e:	90                   	nop
}
  801d8f:	c9                   	leave  
  801d90:	c3                   	ret    

00801d91 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d91:	55                   	push   %ebp
  801d92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 25                	push   $0x25
  801da0:	e8 82 fb ff ff       	call   801927 <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
}
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
  801dad:	83 ec 04             	sub    $0x4,%esp
  801db0:	8b 45 08             	mov    0x8(%ebp),%eax
  801db3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801db6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	50                   	push   %eax
  801dc3:	6a 26                	push   $0x26
  801dc5:	e8 5d fb ff ff       	call   801927 <syscall>
  801dca:	83 c4 18             	add    $0x18,%esp
	return ;
  801dcd:	90                   	nop
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <rsttst>:
void rsttst()
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 28                	push   $0x28
  801ddf:	e8 43 fb ff ff       	call   801927 <syscall>
  801de4:	83 c4 18             	add    $0x18,%esp
	return ;
  801de7:	90                   	nop
}
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
  801ded:	83 ec 04             	sub    $0x4,%esp
  801df0:	8b 45 14             	mov    0x14(%ebp),%eax
  801df3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801df6:	8b 55 18             	mov    0x18(%ebp),%edx
  801df9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dfd:	52                   	push   %edx
  801dfe:	50                   	push   %eax
  801dff:	ff 75 10             	pushl  0x10(%ebp)
  801e02:	ff 75 0c             	pushl  0xc(%ebp)
  801e05:	ff 75 08             	pushl  0x8(%ebp)
  801e08:	6a 27                	push   $0x27
  801e0a:	e8 18 fb ff ff       	call   801927 <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e12:	90                   	nop
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <chktst>:
void chktst(uint32 n)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	ff 75 08             	pushl  0x8(%ebp)
  801e23:	6a 29                	push   $0x29
  801e25:	e8 fd fa ff ff       	call   801927 <syscall>
  801e2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e2d:	90                   	nop
}
  801e2e:	c9                   	leave  
  801e2f:	c3                   	ret    

00801e30 <inctst>:

void inctst()
{
  801e30:	55                   	push   %ebp
  801e31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 2a                	push   $0x2a
  801e3f:	e8 e3 fa ff ff       	call   801927 <syscall>
  801e44:	83 c4 18             	add    $0x18,%esp
	return ;
  801e47:	90                   	nop
}
  801e48:	c9                   	leave  
  801e49:	c3                   	ret    

00801e4a <gettst>:
uint32 gettst()
{
  801e4a:	55                   	push   %ebp
  801e4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 2b                	push   $0x2b
  801e59:	e8 c9 fa ff ff       	call   801927 <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
  801e66:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 2c                	push   $0x2c
  801e75:	e8 ad fa ff ff       	call   801927 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
  801e7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e80:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e84:	75 07                	jne    801e8d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e86:	b8 01 00 00 00       	mov    $0x1,%eax
  801e8b:	eb 05                	jmp    801e92 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e92:	c9                   	leave  
  801e93:	c3                   	ret    

00801e94 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e94:	55                   	push   %ebp
  801e95:	89 e5                	mov    %esp,%ebp
  801e97:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 2c                	push   $0x2c
  801ea6:	e8 7c fa ff ff       	call   801927 <syscall>
  801eab:	83 c4 18             	add    $0x18,%esp
  801eae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801eb1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801eb5:	75 07                	jne    801ebe <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801eb7:	b8 01 00 00 00       	mov    $0x1,%eax
  801ebc:	eb 05                	jmp    801ec3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ebe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    

00801ec5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
  801ec8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 2c                	push   $0x2c
  801ed7:	e8 4b fa ff ff       	call   801927 <syscall>
  801edc:	83 c4 18             	add    $0x18,%esp
  801edf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ee2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ee6:	75 07                	jne    801eef <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ee8:	b8 01 00 00 00       	mov    $0x1,%eax
  801eed:	eb 05                	jmp    801ef4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801eef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ef4:	c9                   	leave  
  801ef5:	c3                   	ret    

00801ef6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ef6:	55                   	push   %ebp
  801ef7:	89 e5                	mov    %esp,%ebp
  801ef9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 2c                	push   $0x2c
  801f08:	e8 1a fa ff ff       	call   801927 <syscall>
  801f0d:	83 c4 18             	add    $0x18,%esp
  801f10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f13:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f17:	75 07                	jne    801f20 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f19:	b8 01 00 00 00       	mov    $0x1,%eax
  801f1e:	eb 05                	jmp    801f25 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f20:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f25:	c9                   	leave  
  801f26:	c3                   	ret    

00801f27 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	ff 75 08             	pushl  0x8(%ebp)
  801f35:	6a 2d                	push   $0x2d
  801f37:	e8 eb f9 ff ff       	call   801927 <syscall>
  801f3c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f3f:	90                   	nop
}
  801f40:	c9                   	leave  
  801f41:	c3                   	ret    

00801f42 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f42:	55                   	push   %ebp
  801f43:	89 e5                	mov    %esp,%ebp
  801f45:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f46:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f49:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f52:	6a 00                	push   $0x0
  801f54:	53                   	push   %ebx
  801f55:	51                   	push   %ecx
  801f56:	52                   	push   %edx
  801f57:	50                   	push   %eax
  801f58:	6a 2e                	push   $0x2e
  801f5a:	e8 c8 f9 ff ff       	call   801927 <syscall>
  801f5f:	83 c4 18             	add    $0x18,%esp
}
  801f62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f65:	c9                   	leave  
  801f66:	c3                   	ret    

00801f67 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801f67:	55                   	push   %ebp
  801f68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801f6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	52                   	push   %edx
  801f77:	50                   	push   %eax
  801f78:	6a 2f                	push   $0x2f
  801f7a:	e8 a8 f9 ff ff       	call   801927 <syscall>
  801f7f:	83 c4 18             	add    $0x18,%esp
}
  801f82:	c9                   	leave  
  801f83:	c3                   	ret    

00801f84 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801f84:	55                   	push   %ebp
  801f85:	89 e5                	mov    %esp,%ebp
  801f87:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801f8a:	8b 55 08             	mov    0x8(%ebp),%edx
  801f8d:	89 d0                	mov    %edx,%eax
  801f8f:	c1 e0 02             	shl    $0x2,%eax
  801f92:	01 d0                	add    %edx,%eax
  801f94:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f9b:	01 d0                	add    %edx,%eax
  801f9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fa4:	01 d0                	add    %edx,%eax
  801fa6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fad:	01 d0                	add    %edx,%eax
  801faf:	c1 e0 04             	shl    $0x4,%eax
  801fb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801fb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801fbc:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801fbf:	83 ec 0c             	sub    $0xc,%esp
  801fc2:	50                   	push   %eax
  801fc3:	e8 76 fd ff ff       	call   801d3e <sys_get_virtual_time>
  801fc8:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801fcb:	eb 41                	jmp    80200e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801fcd:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801fd0:	83 ec 0c             	sub    $0xc,%esp
  801fd3:	50                   	push   %eax
  801fd4:	e8 65 fd ff ff       	call   801d3e <sys_get_virtual_time>
  801fd9:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801fdc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801fdf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801fe2:	29 c2                	sub    %eax,%edx
  801fe4:	89 d0                	mov    %edx,%eax
  801fe6:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801fe9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801fec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fef:	89 d1                	mov    %edx,%ecx
  801ff1:	29 c1                	sub    %eax,%ecx
  801ff3:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801ff6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ff9:	39 c2                	cmp    %eax,%edx
  801ffb:	0f 97 c0             	seta   %al
  801ffe:	0f b6 c0             	movzbl %al,%eax
  802001:	29 c1                	sub    %eax,%ecx
  802003:	89 c8                	mov    %ecx,%eax
  802005:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  802008:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80200b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80200e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802011:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802014:	72 b7                	jb     801fcd <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  802016:	90                   	nop
  802017:	c9                   	leave  
  802018:	c3                   	ret    

00802019 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
  80201c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80201f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  802026:	eb 03                	jmp    80202b <busy_wait+0x12>
  802028:	ff 45 fc             	incl   -0x4(%ebp)
  80202b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80202e:	3b 45 08             	cmp    0x8(%ebp),%eax
  802031:	72 f5                	jb     802028 <busy_wait+0xf>
	return i;
  802033:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802036:	c9                   	leave  
  802037:	c3                   	ret    

00802038 <__udivdi3>:
  802038:	55                   	push   %ebp
  802039:	57                   	push   %edi
  80203a:	56                   	push   %esi
  80203b:	53                   	push   %ebx
  80203c:	83 ec 1c             	sub    $0x1c,%esp
  80203f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802043:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802047:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80204b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80204f:	89 ca                	mov    %ecx,%edx
  802051:	89 f8                	mov    %edi,%eax
  802053:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802057:	85 f6                	test   %esi,%esi
  802059:	75 2d                	jne    802088 <__udivdi3+0x50>
  80205b:	39 cf                	cmp    %ecx,%edi
  80205d:	77 65                	ja     8020c4 <__udivdi3+0x8c>
  80205f:	89 fd                	mov    %edi,%ebp
  802061:	85 ff                	test   %edi,%edi
  802063:	75 0b                	jne    802070 <__udivdi3+0x38>
  802065:	b8 01 00 00 00       	mov    $0x1,%eax
  80206a:	31 d2                	xor    %edx,%edx
  80206c:	f7 f7                	div    %edi
  80206e:	89 c5                	mov    %eax,%ebp
  802070:	31 d2                	xor    %edx,%edx
  802072:	89 c8                	mov    %ecx,%eax
  802074:	f7 f5                	div    %ebp
  802076:	89 c1                	mov    %eax,%ecx
  802078:	89 d8                	mov    %ebx,%eax
  80207a:	f7 f5                	div    %ebp
  80207c:	89 cf                	mov    %ecx,%edi
  80207e:	89 fa                	mov    %edi,%edx
  802080:	83 c4 1c             	add    $0x1c,%esp
  802083:	5b                   	pop    %ebx
  802084:	5e                   	pop    %esi
  802085:	5f                   	pop    %edi
  802086:	5d                   	pop    %ebp
  802087:	c3                   	ret    
  802088:	39 ce                	cmp    %ecx,%esi
  80208a:	77 28                	ja     8020b4 <__udivdi3+0x7c>
  80208c:	0f bd fe             	bsr    %esi,%edi
  80208f:	83 f7 1f             	xor    $0x1f,%edi
  802092:	75 40                	jne    8020d4 <__udivdi3+0x9c>
  802094:	39 ce                	cmp    %ecx,%esi
  802096:	72 0a                	jb     8020a2 <__udivdi3+0x6a>
  802098:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80209c:	0f 87 9e 00 00 00    	ja     802140 <__udivdi3+0x108>
  8020a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8020a7:	89 fa                	mov    %edi,%edx
  8020a9:	83 c4 1c             	add    $0x1c,%esp
  8020ac:	5b                   	pop    %ebx
  8020ad:	5e                   	pop    %esi
  8020ae:	5f                   	pop    %edi
  8020af:	5d                   	pop    %ebp
  8020b0:	c3                   	ret    
  8020b1:	8d 76 00             	lea    0x0(%esi),%esi
  8020b4:	31 ff                	xor    %edi,%edi
  8020b6:	31 c0                	xor    %eax,%eax
  8020b8:	89 fa                	mov    %edi,%edx
  8020ba:	83 c4 1c             	add    $0x1c,%esp
  8020bd:	5b                   	pop    %ebx
  8020be:	5e                   	pop    %esi
  8020bf:	5f                   	pop    %edi
  8020c0:	5d                   	pop    %ebp
  8020c1:	c3                   	ret    
  8020c2:	66 90                	xchg   %ax,%ax
  8020c4:	89 d8                	mov    %ebx,%eax
  8020c6:	f7 f7                	div    %edi
  8020c8:	31 ff                	xor    %edi,%edi
  8020ca:	89 fa                	mov    %edi,%edx
  8020cc:	83 c4 1c             	add    $0x1c,%esp
  8020cf:	5b                   	pop    %ebx
  8020d0:	5e                   	pop    %esi
  8020d1:	5f                   	pop    %edi
  8020d2:	5d                   	pop    %ebp
  8020d3:	c3                   	ret    
  8020d4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020d9:	89 eb                	mov    %ebp,%ebx
  8020db:	29 fb                	sub    %edi,%ebx
  8020dd:	89 f9                	mov    %edi,%ecx
  8020df:	d3 e6                	shl    %cl,%esi
  8020e1:	89 c5                	mov    %eax,%ebp
  8020e3:	88 d9                	mov    %bl,%cl
  8020e5:	d3 ed                	shr    %cl,%ebp
  8020e7:	89 e9                	mov    %ebp,%ecx
  8020e9:	09 f1                	or     %esi,%ecx
  8020eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020ef:	89 f9                	mov    %edi,%ecx
  8020f1:	d3 e0                	shl    %cl,%eax
  8020f3:	89 c5                	mov    %eax,%ebp
  8020f5:	89 d6                	mov    %edx,%esi
  8020f7:	88 d9                	mov    %bl,%cl
  8020f9:	d3 ee                	shr    %cl,%esi
  8020fb:	89 f9                	mov    %edi,%ecx
  8020fd:	d3 e2                	shl    %cl,%edx
  8020ff:	8b 44 24 08          	mov    0x8(%esp),%eax
  802103:	88 d9                	mov    %bl,%cl
  802105:	d3 e8                	shr    %cl,%eax
  802107:	09 c2                	or     %eax,%edx
  802109:	89 d0                	mov    %edx,%eax
  80210b:	89 f2                	mov    %esi,%edx
  80210d:	f7 74 24 0c          	divl   0xc(%esp)
  802111:	89 d6                	mov    %edx,%esi
  802113:	89 c3                	mov    %eax,%ebx
  802115:	f7 e5                	mul    %ebp
  802117:	39 d6                	cmp    %edx,%esi
  802119:	72 19                	jb     802134 <__udivdi3+0xfc>
  80211b:	74 0b                	je     802128 <__udivdi3+0xf0>
  80211d:	89 d8                	mov    %ebx,%eax
  80211f:	31 ff                	xor    %edi,%edi
  802121:	e9 58 ff ff ff       	jmp    80207e <__udivdi3+0x46>
  802126:	66 90                	xchg   %ax,%ax
  802128:	8b 54 24 08          	mov    0x8(%esp),%edx
  80212c:	89 f9                	mov    %edi,%ecx
  80212e:	d3 e2                	shl    %cl,%edx
  802130:	39 c2                	cmp    %eax,%edx
  802132:	73 e9                	jae    80211d <__udivdi3+0xe5>
  802134:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802137:	31 ff                	xor    %edi,%edi
  802139:	e9 40 ff ff ff       	jmp    80207e <__udivdi3+0x46>
  80213e:	66 90                	xchg   %ax,%ax
  802140:	31 c0                	xor    %eax,%eax
  802142:	e9 37 ff ff ff       	jmp    80207e <__udivdi3+0x46>
  802147:	90                   	nop

00802148 <__umoddi3>:
  802148:	55                   	push   %ebp
  802149:	57                   	push   %edi
  80214a:	56                   	push   %esi
  80214b:	53                   	push   %ebx
  80214c:	83 ec 1c             	sub    $0x1c,%esp
  80214f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802153:	8b 74 24 34          	mov    0x34(%esp),%esi
  802157:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80215b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80215f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802163:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802167:	89 f3                	mov    %esi,%ebx
  802169:	89 fa                	mov    %edi,%edx
  80216b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80216f:	89 34 24             	mov    %esi,(%esp)
  802172:	85 c0                	test   %eax,%eax
  802174:	75 1a                	jne    802190 <__umoddi3+0x48>
  802176:	39 f7                	cmp    %esi,%edi
  802178:	0f 86 a2 00 00 00    	jbe    802220 <__umoddi3+0xd8>
  80217e:	89 c8                	mov    %ecx,%eax
  802180:	89 f2                	mov    %esi,%edx
  802182:	f7 f7                	div    %edi
  802184:	89 d0                	mov    %edx,%eax
  802186:	31 d2                	xor    %edx,%edx
  802188:	83 c4 1c             	add    $0x1c,%esp
  80218b:	5b                   	pop    %ebx
  80218c:	5e                   	pop    %esi
  80218d:	5f                   	pop    %edi
  80218e:	5d                   	pop    %ebp
  80218f:	c3                   	ret    
  802190:	39 f0                	cmp    %esi,%eax
  802192:	0f 87 ac 00 00 00    	ja     802244 <__umoddi3+0xfc>
  802198:	0f bd e8             	bsr    %eax,%ebp
  80219b:	83 f5 1f             	xor    $0x1f,%ebp
  80219e:	0f 84 ac 00 00 00    	je     802250 <__umoddi3+0x108>
  8021a4:	bf 20 00 00 00       	mov    $0x20,%edi
  8021a9:	29 ef                	sub    %ebp,%edi
  8021ab:	89 fe                	mov    %edi,%esi
  8021ad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021b1:	89 e9                	mov    %ebp,%ecx
  8021b3:	d3 e0                	shl    %cl,%eax
  8021b5:	89 d7                	mov    %edx,%edi
  8021b7:	89 f1                	mov    %esi,%ecx
  8021b9:	d3 ef                	shr    %cl,%edi
  8021bb:	09 c7                	or     %eax,%edi
  8021bd:	89 e9                	mov    %ebp,%ecx
  8021bf:	d3 e2                	shl    %cl,%edx
  8021c1:	89 14 24             	mov    %edx,(%esp)
  8021c4:	89 d8                	mov    %ebx,%eax
  8021c6:	d3 e0                	shl    %cl,%eax
  8021c8:	89 c2                	mov    %eax,%edx
  8021ca:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ce:	d3 e0                	shl    %cl,%eax
  8021d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021d4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021d8:	89 f1                	mov    %esi,%ecx
  8021da:	d3 e8                	shr    %cl,%eax
  8021dc:	09 d0                	or     %edx,%eax
  8021de:	d3 eb                	shr    %cl,%ebx
  8021e0:	89 da                	mov    %ebx,%edx
  8021e2:	f7 f7                	div    %edi
  8021e4:	89 d3                	mov    %edx,%ebx
  8021e6:	f7 24 24             	mull   (%esp)
  8021e9:	89 c6                	mov    %eax,%esi
  8021eb:	89 d1                	mov    %edx,%ecx
  8021ed:	39 d3                	cmp    %edx,%ebx
  8021ef:	0f 82 87 00 00 00    	jb     80227c <__umoddi3+0x134>
  8021f5:	0f 84 91 00 00 00    	je     80228c <__umoddi3+0x144>
  8021fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021ff:	29 f2                	sub    %esi,%edx
  802201:	19 cb                	sbb    %ecx,%ebx
  802203:	89 d8                	mov    %ebx,%eax
  802205:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802209:	d3 e0                	shl    %cl,%eax
  80220b:	89 e9                	mov    %ebp,%ecx
  80220d:	d3 ea                	shr    %cl,%edx
  80220f:	09 d0                	or     %edx,%eax
  802211:	89 e9                	mov    %ebp,%ecx
  802213:	d3 eb                	shr    %cl,%ebx
  802215:	89 da                	mov    %ebx,%edx
  802217:	83 c4 1c             	add    $0x1c,%esp
  80221a:	5b                   	pop    %ebx
  80221b:	5e                   	pop    %esi
  80221c:	5f                   	pop    %edi
  80221d:	5d                   	pop    %ebp
  80221e:	c3                   	ret    
  80221f:	90                   	nop
  802220:	89 fd                	mov    %edi,%ebp
  802222:	85 ff                	test   %edi,%edi
  802224:	75 0b                	jne    802231 <__umoddi3+0xe9>
  802226:	b8 01 00 00 00       	mov    $0x1,%eax
  80222b:	31 d2                	xor    %edx,%edx
  80222d:	f7 f7                	div    %edi
  80222f:	89 c5                	mov    %eax,%ebp
  802231:	89 f0                	mov    %esi,%eax
  802233:	31 d2                	xor    %edx,%edx
  802235:	f7 f5                	div    %ebp
  802237:	89 c8                	mov    %ecx,%eax
  802239:	f7 f5                	div    %ebp
  80223b:	89 d0                	mov    %edx,%eax
  80223d:	e9 44 ff ff ff       	jmp    802186 <__umoddi3+0x3e>
  802242:	66 90                	xchg   %ax,%ax
  802244:	89 c8                	mov    %ecx,%eax
  802246:	89 f2                	mov    %esi,%edx
  802248:	83 c4 1c             	add    $0x1c,%esp
  80224b:	5b                   	pop    %ebx
  80224c:	5e                   	pop    %esi
  80224d:	5f                   	pop    %edi
  80224e:	5d                   	pop    %ebp
  80224f:	c3                   	ret    
  802250:	3b 04 24             	cmp    (%esp),%eax
  802253:	72 06                	jb     80225b <__umoddi3+0x113>
  802255:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802259:	77 0f                	ja     80226a <__umoddi3+0x122>
  80225b:	89 f2                	mov    %esi,%edx
  80225d:	29 f9                	sub    %edi,%ecx
  80225f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802263:	89 14 24             	mov    %edx,(%esp)
  802266:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80226a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80226e:	8b 14 24             	mov    (%esp),%edx
  802271:	83 c4 1c             	add    $0x1c,%esp
  802274:	5b                   	pop    %ebx
  802275:	5e                   	pop    %esi
  802276:	5f                   	pop    %edi
  802277:	5d                   	pop    %ebp
  802278:	c3                   	ret    
  802279:	8d 76 00             	lea    0x0(%esi),%esi
  80227c:	2b 04 24             	sub    (%esp),%eax
  80227f:	19 fa                	sbb    %edi,%edx
  802281:	89 d1                	mov    %edx,%ecx
  802283:	89 c6                	mov    %eax,%esi
  802285:	e9 71 ff ff ff       	jmp    8021fb <__umoddi3+0xb3>
  80228a:	66 90                	xchg   %ax,%ax
  80228c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802290:	72 ea                	jb     80227c <__umoddi3+0x134>
  802292:	89 d9                	mov    %ebx,%ecx
  802294:	e9 62 ff ff ff       	jmp    8021fb <__umoddi3+0xb3>
