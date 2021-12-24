
obj/user/tst_sharing_5_master:     file format elf32-i386


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
  800031:	e8 b1 03 00 00       	call   8003e7 <libmain>
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
  800087:	68 20 22 80 00       	push   $0x802220
  80008c:	6a 12                	push   $0x12
  80008e:	68 3c 22 80 00       	push   $0x80223c
  800093:	e8 94 04 00 00       	call   80052c <_panic>
	}

	cprintf("************************************************\n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 58 22 80 00       	push   $0x802258
  8000a0:	e8 29 07 00 00       	call   8007ce <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	68 8c 22 80 00       	push   $0x80228c
  8000b0:	e8 19 07 00 00       	call   8007ce <cprintf>
  8000b5:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000b8:	83 ec 0c             	sub    $0xc,%esp
  8000bb:	68 e8 22 80 00       	push   $0x8022e8
  8000c0:	e8 09 07 00 00       	call   8007ce <cprintf>
  8000c5:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  8000c8:	e8 5c 18 00 00       	call   801929 <sys_getenvid>
  8000cd:	89 45 ec             	mov    %eax,-0x14(%ebp)

	cprintf("STEP A: checking free of shared object using 2 environments... \n");
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 1c 23 80 00       	push   $0x80231c
  8000d8:	e8 f1 06 00 00       	call   8007ce <cprintf>
  8000dd:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		int32 envIdSlave1 = sys_create_env("tshr5slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f0:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000f6:	89 c1                	mov    %eax,%ecx
  8000f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fd:	8b 40 74             	mov    0x74(%eax),%eax
  800100:	52                   	push   %edx
  800101:	51                   	push   %ecx
  800102:	50                   	push   %eax
  800103:	68 5d 23 80 00       	push   $0x80235d
  800108:	e8 55 1b 00 00       	call   801c62 <sys_create_env>
  80010d:	83 c4 10             	add    $0x10,%esp
  800110:	89 45 e8             	mov    %eax,-0x18(%ebp)
		int32 envIdSlave2 = sys_create_env("tshr5slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80011e:	a1 20 30 80 00       	mov    0x803020,%eax
  800123:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800129:	89 c1                	mov    %eax,%ecx
  80012b:	a1 20 30 80 00       	mov    0x803020,%eax
  800130:	8b 40 74             	mov    0x74(%eax),%eax
  800133:	52                   	push   %edx
  800134:	51                   	push   %ecx
  800135:	50                   	push   %eax
  800136:	68 5d 23 80 00       	push   $0x80235d
  80013b:	e8 22 1b 00 00       	call   801c62 <sys_create_env>
  800140:	83 c4 10             	add    $0x10,%esp
  800143:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		int freeFrames = sys_calculate_free_frames() ;
  800146:	e8 c2 18 00 00       	call   801a0d <sys_calculate_free_frames>
  80014b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  80014e:	83 ec 04             	sub    $0x4,%esp
  800151:	6a 01                	push   $0x1
  800153:	68 00 10 00 00       	push   $0x1000
  800158:	68 68 23 80 00       	push   $0x802368
  80015d:	e8 6e 16 00 00       	call   8017d0 <smalloc>
  800162:	83 c4 10             	add    $0x10,%esp
  800165:	89 45 dc             	mov    %eax,-0x24(%ebp)
		cprintf("Master env created x (1 page) \n");
  800168:	83 ec 0c             	sub    $0xc,%esp
  80016b:	68 6c 23 80 00       	push   $0x80236c
  800170:	e8 59 06 00 00       	call   8007ce <cprintf>
  800175:	83 c4 10             	add    $0x10,%esp
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800178:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  80017f:	74 14                	je     800195 <_main+0x15d>
  800181:	83 ec 04             	sub    $0x4,%esp
  800184:	68 8c 23 80 00       	push   $0x80238c
  800189:	6a 24                	push   $0x24
  80018b:	68 3c 22 80 00       	push   $0x80223c
  800190:	e8 97 03 00 00       	call   80052c <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800195:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800198:	e8 70 18 00 00       	call   801a0d <sys_calculate_free_frames>
  80019d:	29 c3                	sub    %eax,%ebx
  80019f:	89 d8                	mov    %ebx,%eax
  8001a1:	83 f8 04             	cmp    $0x4,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 f8 23 80 00       	push   $0x8023f8
  8001ae:	6a 25                	push   $0x25
  8001b0:	68 3c 22 80 00       	push   $0x80223c
  8001b5:	e8 72 03 00 00       	call   80052c <_panic>

		//to check that the slave environments completed successfully
		rsttst();
  8001ba:	e8 8b 1b 00 00       	call   801d4a <rsttst>

		sys_run_env(envIdSlave1);
  8001bf:	83 ec 0c             	sub    $0xc,%esp
  8001c2:	ff 75 e8             	pushl  -0x18(%ebp)
  8001c5:	e8 b6 1a 00 00       	call   801c80 <sys_run_env>
  8001ca:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdSlave2);
  8001cd:	83 ec 0c             	sub    $0xc,%esp
  8001d0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001d3:	e8 a8 1a 00 00       	call   801c80 <sys_run_env>
  8001d8:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  8001db:	83 ec 0c             	sub    $0xc,%esp
  8001de:	68 76 24 80 00       	push   $0x802476
  8001e3:	e8 e6 05 00 00       	call   8007ce <cprintf>
  8001e8:	83 c4 10             	add    $0x10,%esp
		env_sleep(3000);
  8001eb:	83 ec 0c             	sub    $0xc,%esp
  8001ee:	68 b8 0b 00 00       	push   $0xbb8
  8001f3:	e8 06 1d 00 00       	call   801efe <env_sleep>
  8001f8:	83 c4 10             	add    $0x10,%esp

		//to ensure that the slave environments completed successfully
		if (gettst()!=2) panic("test failed");
  8001fb:	e8 c4 1b 00 00       	call   801dc4 <gettst>
  800200:	83 f8 02             	cmp    $0x2,%eax
  800203:	74 14                	je     800219 <_main+0x1e1>
  800205:	83 ec 04             	sub    $0x4,%esp
  800208:	68 8d 24 80 00       	push   $0x80248d
  80020d:	6a 31                	push   $0x31
  80020f:	68 3c 22 80 00       	push   $0x80223c
  800214:	e8 13 03 00 00       	call   80052c <_panic>

		sfree(x);
  800219:	83 ec 0c             	sub    $0xc,%esp
  80021c:	ff 75 dc             	pushl  -0x24(%ebp)
  80021f:	e8 ec 15 00 00       	call   801810 <sfree>
  800224:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed x (1 page) \n");
  800227:	83 ec 0c             	sub    $0xc,%esp
  80022a:	68 9c 24 80 00       	push   $0x80249c
  80022f:	e8 9a 05 00 00       	call   8007ce <cprintf>
  800234:	83 c4 10             	add    $0x10,%esp
		int diff = (sys_calculate_free_frames() - freeFrames);
  800237:	e8 d1 17 00 00       	call   801a0d <sys_calculate_free_frames>
  80023c:	89 c2                	mov    %eax,%edx
  80023e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800241:	29 c2                	sub    %eax,%edx
  800243:	89 d0                	mov    %edx,%eax
  800245:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if ( diff !=  0) panic("Wrong free: revise your freeSharedObject logic\n");
  800248:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  80024c:	74 14                	je     800262 <_main+0x22a>
  80024e:	83 ec 04             	sub    $0x4,%esp
  800251:	68 bc 24 80 00       	push   $0x8024bc
  800256:	6a 36                	push   $0x36
  800258:	68 3c 22 80 00       	push   $0x80223c
  80025d:	e8 ca 02 00 00       	call   80052c <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 ec 24 80 00       	push   $0x8024ec
  80026a:	e8 5f 05 00 00       	call   8007ce <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP B: checking free of 2 shared objects ... \n");
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 10 25 80 00       	push   $0x802510
  80027a:	e8 4f 05 00 00       	call   8007ce <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		int32 envIdSlaveB1 = sys_create_env("tshr5slaveB1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800282:	a1 20 30 80 00       	mov    0x803020,%eax
  800287:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800298:	89 c1                	mov    %eax,%ecx
  80029a:	a1 20 30 80 00       	mov    0x803020,%eax
  80029f:	8b 40 74             	mov    0x74(%eax),%eax
  8002a2:	52                   	push   %edx
  8002a3:	51                   	push   %ecx
  8002a4:	50                   	push   %eax
  8002a5:	68 40 25 80 00       	push   $0x802540
  8002aa:	e8 b3 19 00 00       	call   801c62 <sys_create_env>
  8002af:	83 c4 10             	add    $0x10,%esp
  8002b2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int32 envIdSlaveB2 = sys_create_env("tshr5slaveB2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8002b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ba:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8002c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c5:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8002cb:	89 c1                	mov    %eax,%ecx
  8002cd:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d2:	8b 40 74             	mov    0x74(%eax),%eax
  8002d5:	52                   	push   %edx
  8002d6:	51                   	push   %ecx
  8002d7:	50                   	push   %eax
  8002d8:	68 4d 25 80 00       	push   $0x80254d
  8002dd:	e8 80 19 00 00       	call   801c62 <sys_create_env>
  8002e2:	83 c4 10             	add    $0x10,%esp
  8002e5:	89 45 d0             	mov    %eax,-0x30(%ebp)

		z = smalloc("z", PAGE_SIZE, 1);
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	6a 01                	push   $0x1
  8002ed:	68 00 10 00 00       	push   $0x1000
  8002f2:	68 5a 25 80 00       	push   $0x80255a
  8002f7:	e8 d4 14 00 00       	call   8017d0 <smalloc>
  8002fc:	83 c4 10             	add    $0x10,%esp
  8002ff:	89 45 cc             	mov    %eax,-0x34(%ebp)
		cprintf("Master env created z (1 page) \n");
  800302:	83 ec 0c             	sub    $0xc,%esp
  800305:	68 5c 25 80 00       	push   $0x80255c
  80030a:	e8 bf 04 00 00       	call   8007ce <cprintf>
  80030f:	83 c4 10             	add    $0x10,%esp

		x = smalloc("x", PAGE_SIZE, 1);
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	6a 01                	push   $0x1
  800317:	68 00 10 00 00       	push   $0x1000
  80031c:	68 68 23 80 00       	push   $0x802368
  800321:	e8 aa 14 00 00       	call   8017d0 <smalloc>
  800326:	83 c4 10             	add    $0x10,%esp
  800329:	89 45 c8             	mov    %eax,-0x38(%ebp)
		cprintf("Master env created x (1 page) \n");
  80032c:	83 ec 0c             	sub    $0xc,%esp
  80032f:	68 6c 23 80 00       	push   $0x80236c
  800334:	e8 95 04 00 00       	call   8007ce <cprintf>
  800339:	83 c4 10             	add    $0x10,%esp

		rsttst();
  80033c:	e8 09 1a 00 00       	call   801d4a <rsttst>

		sys_run_env(envIdSlaveB1);
  800341:	83 ec 0c             	sub    $0xc,%esp
  800344:	ff 75 d4             	pushl  -0x2c(%ebp)
  800347:	e8 34 19 00 00       	call   801c80 <sys_run_env>
  80034c:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdSlaveB2);
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	ff 75 d0             	pushl  -0x30(%ebp)
  800355:	e8 26 19 00 00       	call   801c80 <sys_run_env>
  80035a:	83 c4 10             	add    $0x10,%esp

		env_sleep(4000); //give slaves time to catch the shared object before removal
  80035d:	83 ec 0c             	sub    $0xc,%esp
  800360:	68 a0 0f 00 00       	push   $0xfa0
  800365:	e8 94 1b 00 00       	call   801efe <env_sleep>
  80036a:	83 c4 10             	add    $0x10,%esp

		int freeFrames = sys_calculate_free_frames() ;
  80036d:	e8 9b 16 00 00       	call   801a0d <sys_calculate_free_frames>
  800372:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		sfree(z);
  800375:	83 ec 0c             	sub    $0xc,%esp
  800378:	ff 75 cc             	pushl  -0x34(%ebp)
  80037b:	e8 90 14 00 00       	call   801810 <sfree>
  800380:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed z\n");
  800383:	83 ec 0c             	sub    $0xc,%esp
  800386:	68 7c 25 80 00       	push   $0x80257c
  80038b:	e8 3e 04 00 00       	call   8007ce <cprintf>
  800390:	83 c4 10             	add    $0x10,%esp

		sfree(x);
  800393:	83 ec 0c             	sub    $0xc,%esp
  800396:	ff 75 c8             	pushl  -0x38(%ebp)
  800399:	e8 72 14 00 00       	call   801810 <sfree>
  80039e:	83 c4 10             	add    $0x10,%esp
		cprintf("Master env removed x\n");
  8003a1:	83 ec 0c             	sub    $0xc,%esp
  8003a4:	68 92 25 80 00       	push   $0x802592
  8003a9:	e8 20 04 00 00       	call   8007ce <cprintf>
  8003ae:	83 c4 10             	add    $0x10,%esp

		int diff = (sys_calculate_free_frames() - freeFrames);
  8003b1:	e8 57 16 00 00       	call   801a0d <sys_calculate_free_frames>
  8003b6:	89 c2                	mov    %eax,%edx
  8003b8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8003bb:	29 c2                	sub    %eax,%edx
  8003bd:	89 d0                	mov    %edx,%eax
  8003bf:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if (diff !=  1) panic("Wrong free: frames removed not equal 1 !, correct frames to be removed are 1:\nfrom the env: 1 table\nframes_storage of z & x: should NOT cleared yet (still in use!)\n");
  8003c2:	83 7d c0 01          	cmpl   $0x1,-0x40(%ebp)
  8003c6:	74 14                	je     8003dc <_main+0x3a4>
  8003c8:	83 ec 04             	sub    $0x4,%esp
  8003cb:	68 a8 25 80 00       	push   $0x8025a8
  8003d0:	6a 57                	push   $0x57
  8003d2:	68 3c 22 80 00       	push   $0x80223c
  8003d7:	e8 50 01 00 00       	call   80052c <_panic>

		//To indicate that it's completed successfully
		inctst();
  8003dc:	e8 c9 19 00 00       	call   801daa <inctst>


	}


	return;
  8003e1:	90                   	nop
}
  8003e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003e5:	c9                   	leave  
  8003e6:	c3                   	ret    

008003e7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003e7:	55                   	push   %ebp
  8003e8:	89 e5                	mov    %esp,%ebp
  8003ea:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003ed:	e8 50 15 00 00       	call   801942 <sys_getenvindex>
  8003f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003f8:	89 d0                	mov    %edx,%eax
  8003fa:	c1 e0 03             	shl    $0x3,%eax
  8003fd:	01 d0                	add    %edx,%eax
  8003ff:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800406:	01 c8                	add    %ecx,%eax
  800408:	01 c0                	add    %eax,%eax
  80040a:	01 d0                	add    %edx,%eax
  80040c:	01 c0                	add    %eax,%eax
  80040e:	01 d0                	add    %edx,%eax
  800410:	89 c2                	mov    %eax,%edx
  800412:	c1 e2 05             	shl    $0x5,%edx
  800415:	29 c2                	sub    %eax,%edx
  800417:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80041e:	89 c2                	mov    %eax,%edx
  800420:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800426:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80042b:	a1 20 30 80 00       	mov    0x803020,%eax
  800430:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800436:	84 c0                	test   %al,%al
  800438:	74 0f                	je     800449 <libmain+0x62>
		binaryname = myEnv->prog_name;
  80043a:	a1 20 30 80 00       	mov    0x803020,%eax
  80043f:	05 40 3c 01 00       	add    $0x13c40,%eax
  800444:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800449:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80044d:	7e 0a                	jle    800459 <libmain+0x72>
		binaryname = argv[0];
  80044f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800459:	83 ec 08             	sub    $0x8,%esp
  80045c:	ff 75 0c             	pushl  0xc(%ebp)
  80045f:	ff 75 08             	pushl  0x8(%ebp)
  800462:	e8 d1 fb ff ff       	call   800038 <_main>
  800467:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80046a:	e8 6e 16 00 00       	call   801add <sys_disable_interrupt>
	cprintf("**************************************\n");
  80046f:	83 ec 0c             	sub    $0xc,%esp
  800472:	68 68 26 80 00       	push   $0x802668
  800477:	e8 52 03 00 00       	call   8007ce <cprintf>
  80047c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80047f:	a1 20 30 80 00       	mov    0x803020,%eax
  800484:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80048a:	a1 20 30 80 00       	mov    0x803020,%eax
  80048f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800495:	83 ec 04             	sub    $0x4,%esp
  800498:	52                   	push   %edx
  800499:	50                   	push   %eax
  80049a:	68 90 26 80 00       	push   $0x802690
  80049f:	e8 2a 03 00 00       	call   8007ce <cprintf>
  8004a4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8004a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ac:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8004b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b7:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8004bd:	83 ec 04             	sub    $0x4,%esp
  8004c0:	52                   	push   %edx
  8004c1:	50                   	push   %eax
  8004c2:	68 b8 26 80 00       	push   $0x8026b8
  8004c7:	e8 02 03 00 00       	call   8007ce <cprintf>
  8004cc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d4:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8004da:	83 ec 08             	sub    $0x8,%esp
  8004dd:	50                   	push   %eax
  8004de:	68 f9 26 80 00       	push   $0x8026f9
  8004e3:	e8 e6 02 00 00       	call   8007ce <cprintf>
  8004e8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004eb:	83 ec 0c             	sub    $0xc,%esp
  8004ee:	68 68 26 80 00       	push   $0x802668
  8004f3:	e8 d6 02 00 00       	call   8007ce <cprintf>
  8004f8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004fb:	e8 f7 15 00 00       	call   801af7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800500:	e8 19 00 00 00       	call   80051e <exit>
}
  800505:	90                   	nop
  800506:	c9                   	leave  
  800507:	c3                   	ret    

00800508 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800508:	55                   	push   %ebp
  800509:	89 e5                	mov    %esp,%ebp
  80050b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80050e:	83 ec 0c             	sub    $0xc,%esp
  800511:	6a 00                	push   $0x0
  800513:	e8 f6 13 00 00       	call   80190e <sys_env_destroy>
  800518:	83 c4 10             	add    $0x10,%esp
}
  80051b:	90                   	nop
  80051c:	c9                   	leave  
  80051d:	c3                   	ret    

0080051e <exit>:

void
exit(void)
{
  80051e:	55                   	push   %ebp
  80051f:	89 e5                	mov    %esp,%ebp
  800521:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800524:	e8 4b 14 00 00       	call   801974 <sys_env_exit>
}
  800529:	90                   	nop
  80052a:	c9                   	leave  
  80052b:	c3                   	ret    

0080052c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80052c:	55                   	push   %ebp
  80052d:	89 e5                	mov    %esp,%ebp
  80052f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800532:	8d 45 10             	lea    0x10(%ebp),%eax
  800535:	83 c0 04             	add    $0x4,%eax
  800538:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80053b:	a1 18 31 80 00       	mov    0x803118,%eax
  800540:	85 c0                	test   %eax,%eax
  800542:	74 16                	je     80055a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800544:	a1 18 31 80 00       	mov    0x803118,%eax
  800549:	83 ec 08             	sub    $0x8,%esp
  80054c:	50                   	push   %eax
  80054d:	68 10 27 80 00       	push   $0x802710
  800552:	e8 77 02 00 00       	call   8007ce <cprintf>
  800557:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80055a:	a1 00 30 80 00       	mov    0x803000,%eax
  80055f:	ff 75 0c             	pushl  0xc(%ebp)
  800562:	ff 75 08             	pushl  0x8(%ebp)
  800565:	50                   	push   %eax
  800566:	68 15 27 80 00       	push   $0x802715
  80056b:	e8 5e 02 00 00       	call   8007ce <cprintf>
  800570:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800573:	8b 45 10             	mov    0x10(%ebp),%eax
  800576:	83 ec 08             	sub    $0x8,%esp
  800579:	ff 75 f4             	pushl  -0xc(%ebp)
  80057c:	50                   	push   %eax
  80057d:	e8 e1 01 00 00       	call   800763 <vcprintf>
  800582:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800585:	83 ec 08             	sub    $0x8,%esp
  800588:	6a 00                	push   $0x0
  80058a:	68 31 27 80 00       	push   $0x802731
  80058f:	e8 cf 01 00 00       	call   800763 <vcprintf>
  800594:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800597:	e8 82 ff ff ff       	call   80051e <exit>

	// should not return here
	while (1) ;
  80059c:	eb fe                	jmp    80059c <_panic+0x70>

0080059e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80059e:	55                   	push   %ebp
  80059f:	89 e5                	mov    %esp,%ebp
  8005a1:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8005a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a9:	8b 50 74             	mov    0x74(%eax),%edx
  8005ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005af:	39 c2                	cmp    %eax,%edx
  8005b1:	74 14                	je     8005c7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005b3:	83 ec 04             	sub    $0x4,%esp
  8005b6:	68 34 27 80 00       	push   $0x802734
  8005bb:	6a 26                	push   $0x26
  8005bd:	68 80 27 80 00       	push   $0x802780
  8005c2:	e8 65 ff ff ff       	call   80052c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005d5:	e9 b6 00 00 00       	jmp    800690 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8005da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e7:	01 d0                	add    %edx,%eax
  8005e9:	8b 00                	mov    (%eax),%eax
  8005eb:	85 c0                	test   %eax,%eax
  8005ed:	75 08                	jne    8005f7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005ef:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005f2:	e9 96 00 00 00       	jmp    80068d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8005f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005fe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800605:	eb 5d                	jmp    800664 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800607:	a1 20 30 80 00       	mov    0x803020,%eax
  80060c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800612:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800615:	c1 e2 04             	shl    $0x4,%edx
  800618:	01 d0                	add    %edx,%eax
  80061a:	8a 40 04             	mov    0x4(%eax),%al
  80061d:	84 c0                	test   %al,%al
  80061f:	75 40                	jne    800661 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800621:	a1 20 30 80 00       	mov    0x803020,%eax
  800626:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80062c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80062f:	c1 e2 04             	shl    $0x4,%edx
  800632:	01 d0                	add    %edx,%eax
  800634:	8b 00                	mov    (%eax),%eax
  800636:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800639:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80063c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800641:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800643:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800646:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80064d:	8b 45 08             	mov    0x8(%ebp),%eax
  800650:	01 c8                	add    %ecx,%eax
  800652:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800654:	39 c2                	cmp    %eax,%edx
  800656:	75 09                	jne    800661 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800658:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80065f:	eb 12                	jmp    800673 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800661:	ff 45 e8             	incl   -0x18(%ebp)
  800664:	a1 20 30 80 00       	mov    0x803020,%eax
  800669:	8b 50 74             	mov    0x74(%eax),%edx
  80066c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80066f:	39 c2                	cmp    %eax,%edx
  800671:	77 94                	ja     800607 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800673:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800677:	75 14                	jne    80068d <CheckWSWithoutLastIndex+0xef>
			panic(
  800679:	83 ec 04             	sub    $0x4,%esp
  80067c:	68 8c 27 80 00       	push   $0x80278c
  800681:	6a 3a                	push   $0x3a
  800683:	68 80 27 80 00       	push   $0x802780
  800688:	e8 9f fe ff ff       	call   80052c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80068d:	ff 45 f0             	incl   -0x10(%ebp)
  800690:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800693:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800696:	0f 8c 3e ff ff ff    	jl     8005da <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80069c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006a3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006aa:	eb 20                	jmp    8006cc <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006ba:	c1 e2 04             	shl    $0x4,%edx
  8006bd:	01 d0                	add    %edx,%eax
  8006bf:	8a 40 04             	mov    0x4(%eax),%al
  8006c2:	3c 01                	cmp    $0x1,%al
  8006c4:	75 03                	jne    8006c9 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8006c6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006c9:	ff 45 e0             	incl   -0x20(%ebp)
  8006cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d1:	8b 50 74             	mov    0x74(%eax),%edx
  8006d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006d7:	39 c2                	cmp    %eax,%edx
  8006d9:	77 d1                	ja     8006ac <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006de:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006e1:	74 14                	je     8006f7 <CheckWSWithoutLastIndex+0x159>
		panic(
  8006e3:	83 ec 04             	sub    $0x4,%esp
  8006e6:	68 e0 27 80 00       	push   $0x8027e0
  8006eb:	6a 44                	push   $0x44
  8006ed:	68 80 27 80 00       	push   $0x802780
  8006f2:	e8 35 fe ff ff       	call   80052c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006f7:	90                   	nop
  8006f8:	c9                   	leave  
  8006f9:	c3                   	ret    

008006fa <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006fa:	55                   	push   %ebp
  8006fb:	89 e5                	mov    %esp,%ebp
  8006fd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800700:	8b 45 0c             	mov    0xc(%ebp),%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	8d 48 01             	lea    0x1(%eax),%ecx
  800708:	8b 55 0c             	mov    0xc(%ebp),%edx
  80070b:	89 0a                	mov    %ecx,(%edx)
  80070d:	8b 55 08             	mov    0x8(%ebp),%edx
  800710:	88 d1                	mov    %dl,%cl
  800712:	8b 55 0c             	mov    0xc(%ebp),%edx
  800715:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800719:	8b 45 0c             	mov    0xc(%ebp),%eax
  80071c:	8b 00                	mov    (%eax),%eax
  80071e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800723:	75 2c                	jne    800751 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800725:	a0 24 30 80 00       	mov    0x803024,%al
  80072a:	0f b6 c0             	movzbl %al,%eax
  80072d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800730:	8b 12                	mov    (%edx),%edx
  800732:	89 d1                	mov    %edx,%ecx
  800734:	8b 55 0c             	mov    0xc(%ebp),%edx
  800737:	83 c2 08             	add    $0x8,%edx
  80073a:	83 ec 04             	sub    $0x4,%esp
  80073d:	50                   	push   %eax
  80073e:	51                   	push   %ecx
  80073f:	52                   	push   %edx
  800740:	e8 87 11 00 00       	call   8018cc <sys_cputs>
  800745:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800748:	8b 45 0c             	mov    0xc(%ebp),%eax
  80074b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800751:	8b 45 0c             	mov    0xc(%ebp),%eax
  800754:	8b 40 04             	mov    0x4(%eax),%eax
  800757:	8d 50 01             	lea    0x1(%eax),%edx
  80075a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800760:	90                   	nop
  800761:	c9                   	leave  
  800762:	c3                   	ret    

00800763 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800763:	55                   	push   %ebp
  800764:	89 e5                	mov    %esp,%ebp
  800766:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80076c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800773:	00 00 00 
	b.cnt = 0;
  800776:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80077d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800780:	ff 75 0c             	pushl  0xc(%ebp)
  800783:	ff 75 08             	pushl  0x8(%ebp)
  800786:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80078c:	50                   	push   %eax
  80078d:	68 fa 06 80 00       	push   $0x8006fa
  800792:	e8 11 02 00 00       	call   8009a8 <vprintfmt>
  800797:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80079a:	a0 24 30 80 00       	mov    0x803024,%al
  80079f:	0f b6 c0             	movzbl %al,%eax
  8007a2:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007a8:	83 ec 04             	sub    $0x4,%esp
  8007ab:	50                   	push   %eax
  8007ac:	52                   	push   %edx
  8007ad:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007b3:	83 c0 08             	add    $0x8,%eax
  8007b6:	50                   	push   %eax
  8007b7:	e8 10 11 00 00       	call   8018cc <sys_cputs>
  8007bc:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007bf:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007c6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007cc:	c9                   	leave  
  8007cd:	c3                   	ret    

008007ce <cprintf>:

int cprintf(const char *fmt, ...) {
  8007ce:	55                   	push   %ebp
  8007cf:	89 e5                	mov    %esp,%ebp
  8007d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007d4:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007db:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e4:	83 ec 08             	sub    $0x8,%esp
  8007e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ea:	50                   	push   %eax
  8007eb:	e8 73 ff ff ff       	call   800763 <vcprintf>
  8007f0:	83 c4 10             	add    $0x10,%esp
  8007f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007f9:	c9                   	leave  
  8007fa:	c3                   	ret    

008007fb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007fb:	55                   	push   %ebp
  8007fc:	89 e5                	mov    %esp,%ebp
  8007fe:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800801:	e8 d7 12 00 00       	call   801add <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800806:	8d 45 0c             	lea    0xc(%ebp),%eax
  800809:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80080c:	8b 45 08             	mov    0x8(%ebp),%eax
  80080f:	83 ec 08             	sub    $0x8,%esp
  800812:	ff 75 f4             	pushl  -0xc(%ebp)
  800815:	50                   	push   %eax
  800816:	e8 48 ff ff ff       	call   800763 <vcprintf>
  80081b:	83 c4 10             	add    $0x10,%esp
  80081e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800821:	e8 d1 12 00 00       	call   801af7 <sys_enable_interrupt>
	return cnt;
  800826:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800829:	c9                   	leave  
  80082a:	c3                   	ret    

0080082b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80082b:	55                   	push   %ebp
  80082c:	89 e5                	mov    %esp,%ebp
  80082e:	53                   	push   %ebx
  80082f:	83 ec 14             	sub    $0x14,%esp
  800832:	8b 45 10             	mov    0x10(%ebp),%eax
  800835:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800838:	8b 45 14             	mov    0x14(%ebp),%eax
  80083b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80083e:	8b 45 18             	mov    0x18(%ebp),%eax
  800841:	ba 00 00 00 00       	mov    $0x0,%edx
  800846:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800849:	77 55                	ja     8008a0 <printnum+0x75>
  80084b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80084e:	72 05                	jb     800855 <printnum+0x2a>
  800850:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800853:	77 4b                	ja     8008a0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800855:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800858:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80085b:	8b 45 18             	mov    0x18(%ebp),%eax
  80085e:	ba 00 00 00 00       	mov    $0x0,%edx
  800863:	52                   	push   %edx
  800864:	50                   	push   %eax
  800865:	ff 75 f4             	pushl  -0xc(%ebp)
  800868:	ff 75 f0             	pushl  -0x10(%ebp)
  80086b:	e8 44 17 00 00       	call   801fb4 <__udivdi3>
  800870:	83 c4 10             	add    $0x10,%esp
  800873:	83 ec 04             	sub    $0x4,%esp
  800876:	ff 75 20             	pushl  0x20(%ebp)
  800879:	53                   	push   %ebx
  80087a:	ff 75 18             	pushl  0x18(%ebp)
  80087d:	52                   	push   %edx
  80087e:	50                   	push   %eax
  80087f:	ff 75 0c             	pushl  0xc(%ebp)
  800882:	ff 75 08             	pushl  0x8(%ebp)
  800885:	e8 a1 ff ff ff       	call   80082b <printnum>
  80088a:	83 c4 20             	add    $0x20,%esp
  80088d:	eb 1a                	jmp    8008a9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80088f:	83 ec 08             	sub    $0x8,%esp
  800892:	ff 75 0c             	pushl  0xc(%ebp)
  800895:	ff 75 20             	pushl  0x20(%ebp)
  800898:	8b 45 08             	mov    0x8(%ebp),%eax
  80089b:	ff d0                	call   *%eax
  80089d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008a0:	ff 4d 1c             	decl   0x1c(%ebp)
  8008a3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008a7:	7f e6                	jg     80088f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008a9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008ac:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b7:	53                   	push   %ebx
  8008b8:	51                   	push   %ecx
  8008b9:	52                   	push   %edx
  8008ba:	50                   	push   %eax
  8008bb:	e8 04 18 00 00       	call   8020c4 <__umoddi3>
  8008c0:	83 c4 10             	add    $0x10,%esp
  8008c3:	05 54 2a 80 00       	add    $0x802a54,%eax
  8008c8:	8a 00                	mov    (%eax),%al
  8008ca:	0f be c0             	movsbl %al,%eax
  8008cd:	83 ec 08             	sub    $0x8,%esp
  8008d0:	ff 75 0c             	pushl  0xc(%ebp)
  8008d3:	50                   	push   %eax
  8008d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d7:	ff d0                	call   *%eax
  8008d9:	83 c4 10             	add    $0x10,%esp
}
  8008dc:	90                   	nop
  8008dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008e0:	c9                   	leave  
  8008e1:	c3                   	ret    

008008e2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008e2:	55                   	push   %ebp
  8008e3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008e5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e9:	7e 1c                	jle    800907 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ee:	8b 00                	mov    (%eax),%eax
  8008f0:	8d 50 08             	lea    0x8(%eax),%edx
  8008f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f6:	89 10                	mov    %edx,(%eax)
  8008f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fb:	8b 00                	mov    (%eax),%eax
  8008fd:	83 e8 08             	sub    $0x8,%eax
  800900:	8b 50 04             	mov    0x4(%eax),%edx
  800903:	8b 00                	mov    (%eax),%eax
  800905:	eb 40                	jmp    800947 <getuint+0x65>
	else if (lflag)
  800907:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80090b:	74 1e                	je     80092b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	8b 00                	mov    (%eax),%eax
  800912:	8d 50 04             	lea    0x4(%eax),%edx
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	89 10                	mov    %edx,(%eax)
  80091a:	8b 45 08             	mov    0x8(%ebp),%eax
  80091d:	8b 00                	mov    (%eax),%eax
  80091f:	83 e8 04             	sub    $0x4,%eax
  800922:	8b 00                	mov    (%eax),%eax
  800924:	ba 00 00 00 00       	mov    $0x0,%edx
  800929:	eb 1c                	jmp    800947 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	8b 00                	mov    (%eax),%eax
  800930:	8d 50 04             	lea    0x4(%eax),%edx
  800933:	8b 45 08             	mov    0x8(%ebp),%eax
  800936:	89 10                	mov    %edx,(%eax)
  800938:	8b 45 08             	mov    0x8(%ebp),%eax
  80093b:	8b 00                	mov    (%eax),%eax
  80093d:	83 e8 04             	sub    $0x4,%eax
  800940:	8b 00                	mov    (%eax),%eax
  800942:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800947:	5d                   	pop    %ebp
  800948:	c3                   	ret    

00800949 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800949:	55                   	push   %ebp
  80094a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80094c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800950:	7e 1c                	jle    80096e <getint+0x25>
		return va_arg(*ap, long long);
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	8b 00                	mov    (%eax),%eax
  800957:	8d 50 08             	lea    0x8(%eax),%edx
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	89 10                	mov    %edx,(%eax)
  80095f:	8b 45 08             	mov    0x8(%ebp),%eax
  800962:	8b 00                	mov    (%eax),%eax
  800964:	83 e8 08             	sub    $0x8,%eax
  800967:	8b 50 04             	mov    0x4(%eax),%edx
  80096a:	8b 00                	mov    (%eax),%eax
  80096c:	eb 38                	jmp    8009a6 <getint+0x5d>
	else if (lflag)
  80096e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800972:	74 1a                	je     80098e <getint+0x45>
		return va_arg(*ap, long);
  800974:	8b 45 08             	mov    0x8(%ebp),%eax
  800977:	8b 00                	mov    (%eax),%eax
  800979:	8d 50 04             	lea    0x4(%eax),%edx
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	89 10                	mov    %edx,(%eax)
  800981:	8b 45 08             	mov    0x8(%ebp),%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	83 e8 04             	sub    $0x4,%eax
  800989:	8b 00                	mov    (%eax),%eax
  80098b:	99                   	cltd   
  80098c:	eb 18                	jmp    8009a6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80098e:	8b 45 08             	mov    0x8(%ebp),%eax
  800991:	8b 00                	mov    (%eax),%eax
  800993:	8d 50 04             	lea    0x4(%eax),%edx
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	89 10                	mov    %edx,(%eax)
  80099b:	8b 45 08             	mov    0x8(%ebp),%eax
  80099e:	8b 00                	mov    (%eax),%eax
  8009a0:	83 e8 04             	sub    $0x4,%eax
  8009a3:	8b 00                	mov    (%eax),%eax
  8009a5:	99                   	cltd   
}
  8009a6:	5d                   	pop    %ebp
  8009a7:	c3                   	ret    

008009a8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009a8:	55                   	push   %ebp
  8009a9:	89 e5                	mov    %esp,%ebp
  8009ab:	56                   	push   %esi
  8009ac:	53                   	push   %ebx
  8009ad:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009b0:	eb 17                	jmp    8009c9 <vprintfmt+0x21>
			if (ch == '\0')
  8009b2:	85 db                	test   %ebx,%ebx
  8009b4:	0f 84 af 03 00 00    	je     800d69 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	ff 75 0c             	pushl  0xc(%ebp)
  8009c0:	53                   	push   %ebx
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	ff d0                	call   *%eax
  8009c6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009cc:	8d 50 01             	lea    0x1(%eax),%edx
  8009cf:	89 55 10             	mov    %edx,0x10(%ebp)
  8009d2:	8a 00                	mov    (%eax),%al
  8009d4:	0f b6 d8             	movzbl %al,%ebx
  8009d7:	83 fb 25             	cmp    $0x25,%ebx
  8009da:	75 d6                	jne    8009b2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009dc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009e0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009e7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009ee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009f5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ff:	8d 50 01             	lea    0x1(%eax),%edx
  800a02:	89 55 10             	mov    %edx,0x10(%ebp)
  800a05:	8a 00                	mov    (%eax),%al
  800a07:	0f b6 d8             	movzbl %al,%ebx
  800a0a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a0d:	83 f8 55             	cmp    $0x55,%eax
  800a10:	0f 87 2b 03 00 00    	ja     800d41 <vprintfmt+0x399>
  800a16:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800a1d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a1f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a23:	eb d7                	jmp    8009fc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a25:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a29:	eb d1                	jmp    8009fc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a2b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a32:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a35:	89 d0                	mov    %edx,%eax
  800a37:	c1 e0 02             	shl    $0x2,%eax
  800a3a:	01 d0                	add    %edx,%eax
  800a3c:	01 c0                	add    %eax,%eax
  800a3e:	01 d8                	add    %ebx,%eax
  800a40:	83 e8 30             	sub    $0x30,%eax
  800a43:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a46:	8b 45 10             	mov    0x10(%ebp),%eax
  800a49:	8a 00                	mov    (%eax),%al
  800a4b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a4e:	83 fb 2f             	cmp    $0x2f,%ebx
  800a51:	7e 3e                	jle    800a91 <vprintfmt+0xe9>
  800a53:	83 fb 39             	cmp    $0x39,%ebx
  800a56:	7f 39                	jg     800a91 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a58:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a5b:	eb d5                	jmp    800a32 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a60:	83 c0 04             	add    $0x4,%eax
  800a63:	89 45 14             	mov    %eax,0x14(%ebp)
  800a66:	8b 45 14             	mov    0x14(%ebp),%eax
  800a69:	83 e8 04             	sub    $0x4,%eax
  800a6c:	8b 00                	mov    (%eax),%eax
  800a6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a71:	eb 1f                	jmp    800a92 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a73:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a77:	79 83                	jns    8009fc <vprintfmt+0x54>
				width = 0;
  800a79:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a80:	e9 77 ff ff ff       	jmp    8009fc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a85:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a8c:	e9 6b ff ff ff       	jmp    8009fc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a91:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a96:	0f 89 60 ff ff ff    	jns    8009fc <vprintfmt+0x54>
				width = precision, precision = -1;
  800a9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a9f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800aa2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800aa9:	e9 4e ff ff ff       	jmp    8009fc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800aae:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ab1:	e9 46 ff ff ff       	jmp    8009fc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ab6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab9:	83 c0 04             	add    $0x4,%eax
  800abc:	89 45 14             	mov    %eax,0x14(%ebp)
  800abf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac2:	83 e8 04             	sub    $0x4,%eax
  800ac5:	8b 00                	mov    (%eax),%eax
  800ac7:	83 ec 08             	sub    $0x8,%esp
  800aca:	ff 75 0c             	pushl  0xc(%ebp)
  800acd:	50                   	push   %eax
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	ff d0                	call   *%eax
  800ad3:	83 c4 10             	add    $0x10,%esp
			break;
  800ad6:	e9 89 02 00 00       	jmp    800d64 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800adb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ade:	83 c0 04             	add    $0x4,%eax
  800ae1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ae4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae7:	83 e8 04             	sub    $0x4,%eax
  800aea:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800aec:	85 db                	test   %ebx,%ebx
  800aee:	79 02                	jns    800af2 <vprintfmt+0x14a>
				err = -err;
  800af0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800af2:	83 fb 64             	cmp    $0x64,%ebx
  800af5:	7f 0b                	jg     800b02 <vprintfmt+0x15a>
  800af7:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800afe:	85 f6                	test   %esi,%esi
  800b00:	75 19                	jne    800b1b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b02:	53                   	push   %ebx
  800b03:	68 65 2a 80 00       	push   $0x802a65
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	ff 75 08             	pushl  0x8(%ebp)
  800b0e:	e8 5e 02 00 00       	call   800d71 <printfmt>
  800b13:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b16:	e9 49 02 00 00       	jmp    800d64 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b1b:	56                   	push   %esi
  800b1c:	68 6e 2a 80 00       	push   $0x802a6e
  800b21:	ff 75 0c             	pushl  0xc(%ebp)
  800b24:	ff 75 08             	pushl  0x8(%ebp)
  800b27:	e8 45 02 00 00       	call   800d71 <printfmt>
  800b2c:	83 c4 10             	add    $0x10,%esp
			break;
  800b2f:	e9 30 02 00 00       	jmp    800d64 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b34:	8b 45 14             	mov    0x14(%ebp),%eax
  800b37:	83 c0 04             	add    $0x4,%eax
  800b3a:	89 45 14             	mov    %eax,0x14(%ebp)
  800b3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b40:	83 e8 04             	sub    $0x4,%eax
  800b43:	8b 30                	mov    (%eax),%esi
  800b45:	85 f6                	test   %esi,%esi
  800b47:	75 05                	jne    800b4e <vprintfmt+0x1a6>
				p = "(null)";
  800b49:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800b4e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b52:	7e 6d                	jle    800bc1 <vprintfmt+0x219>
  800b54:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b58:	74 67                	je     800bc1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b5d:	83 ec 08             	sub    $0x8,%esp
  800b60:	50                   	push   %eax
  800b61:	56                   	push   %esi
  800b62:	e8 0c 03 00 00       	call   800e73 <strnlen>
  800b67:	83 c4 10             	add    $0x10,%esp
  800b6a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b6d:	eb 16                	jmp    800b85 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b6f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b73:	83 ec 08             	sub    $0x8,%esp
  800b76:	ff 75 0c             	pushl  0xc(%ebp)
  800b79:	50                   	push   %eax
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	ff d0                	call   *%eax
  800b7f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b82:	ff 4d e4             	decl   -0x1c(%ebp)
  800b85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b89:	7f e4                	jg     800b6f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b8b:	eb 34                	jmp    800bc1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b8d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b91:	74 1c                	je     800baf <vprintfmt+0x207>
  800b93:	83 fb 1f             	cmp    $0x1f,%ebx
  800b96:	7e 05                	jle    800b9d <vprintfmt+0x1f5>
  800b98:	83 fb 7e             	cmp    $0x7e,%ebx
  800b9b:	7e 12                	jle    800baf <vprintfmt+0x207>
					putch('?', putdat);
  800b9d:	83 ec 08             	sub    $0x8,%esp
  800ba0:	ff 75 0c             	pushl  0xc(%ebp)
  800ba3:	6a 3f                	push   $0x3f
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	ff d0                	call   *%eax
  800baa:	83 c4 10             	add    $0x10,%esp
  800bad:	eb 0f                	jmp    800bbe <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800baf:	83 ec 08             	sub    $0x8,%esp
  800bb2:	ff 75 0c             	pushl  0xc(%ebp)
  800bb5:	53                   	push   %ebx
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb9:	ff d0                	call   *%eax
  800bbb:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bbe:	ff 4d e4             	decl   -0x1c(%ebp)
  800bc1:	89 f0                	mov    %esi,%eax
  800bc3:	8d 70 01             	lea    0x1(%eax),%esi
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	0f be d8             	movsbl %al,%ebx
  800bcb:	85 db                	test   %ebx,%ebx
  800bcd:	74 24                	je     800bf3 <vprintfmt+0x24b>
  800bcf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bd3:	78 b8                	js     800b8d <vprintfmt+0x1e5>
  800bd5:	ff 4d e0             	decl   -0x20(%ebp)
  800bd8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bdc:	79 af                	jns    800b8d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bde:	eb 13                	jmp    800bf3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800be0:	83 ec 08             	sub    $0x8,%esp
  800be3:	ff 75 0c             	pushl  0xc(%ebp)
  800be6:	6a 20                	push   $0x20
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	ff d0                	call   *%eax
  800bed:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bf0:	ff 4d e4             	decl   -0x1c(%ebp)
  800bf3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bf7:	7f e7                	jg     800be0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800bf9:	e9 66 01 00 00       	jmp    800d64 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bfe:	83 ec 08             	sub    $0x8,%esp
  800c01:	ff 75 e8             	pushl  -0x18(%ebp)
  800c04:	8d 45 14             	lea    0x14(%ebp),%eax
  800c07:	50                   	push   %eax
  800c08:	e8 3c fd ff ff       	call   800949 <getint>
  800c0d:	83 c4 10             	add    $0x10,%esp
  800c10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c13:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c1c:	85 d2                	test   %edx,%edx
  800c1e:	79 23                	jns    800c43 <vprintfmt+0x29b>
				putch('-', putdat);
  800c20:	83 ec 08             	sub    $0x8,%esp
  800c23:	ff 75 0c             	pushl  0xc(%ebp)
  800c26:	6a 2d                	push   $0x2d
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	ff d0                	call   *%eax
  800c2d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c30:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c36:	f7 d8                	neg    %eax
  800c38:	83 d2 00             	adc    $0x0,%edx
  800c3b:	f7 da                	neg    %edx
  800c3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c40:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c43:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c4a:	e9 bc 00 00 00       	jmp    800d0b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c4f:	83 ec 08             	sub    $0x8,%esp
  800c52:	ff 75 e8             	pushl  -0x18(%ebp)
  800c55:	8d 45 14             	lea    0x14(%ebp),%eax
  800c58:	50                   	push   %eax
  800c59:	e8 84 fc ff ff       	call   8008e2 <getuint>
  800c5e:	83 c4 10             	add    $0x10,%esp
  800c61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c64:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c67:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c6e:	e9 98 00 00 00       	jmp    800d0b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c73:	83 ec 08             	sub    $0x8,%esp
  800c76:	ff 75 0c             	pushl  0xc(%ebp)
  800c79:	6a 58                	push   $0x58
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	ff d0                	call   *%eax
  800c80:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c83:	83 ec 08             	sub    $0x8,%esp
  800c86:	ff 75 0c             	pushl  0xc(%ebp)
  800c89:	6a 58                	push   $0x58
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	ff d0                	call   *%eax
  800c90:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c93:	83 ec 08             	sub    $0x8,%esp
  800c96:	ff 75 0c             	pushl  0xc(%ebp)
  800c99:	6a 58                	push   $0x58
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	ff d0                	call   *%eax
  800ca0:	83 c4 10             	add    $0x10,%esp
			break;
  800ca3:	e9 bc 00 00 00       	jmp    800d64 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ca8:	83 ec 08             	sub    $0x8,%esp
  800cab:	ff 75 0c             	pushl  0xc(%ebp)
  800cae:	6a 30                	push   $0x30
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	ff d0                	call   *%eax
  800cb5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cb8:	83 ec 08             	sub    $0x8,%esp
  800cbb:	ff 75 0c             	pushl  0xc(%ebp)
  800cbe:	6a 78                	push   $0x78
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	ff d0                	call   *%eax
  800cc5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccb:	83 c0 04             	add    $0x4,%eax
  800cce:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd4:	83 e8 04             	sub    $0x4,%eax
  800cd7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ce3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800cea:	eb 1f                	jmp    800d0b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800cec:	83 ec 08             	sub    $0x8,%esp
  800cef:	ff 75 e8             	pushl  -0x18(%ebp)
  800cf2:	8d 45 14             	lea    0x14(%ebp),%eax
  800cf5:	50                   	push   %eax
  800cf6:	e8 e7 fb ff ff       	call   8008e2 <getuint>
  800cfb:	83 c4 10             	add    $0x10,%esp
  800cfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d01:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d04:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d0b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d12:	83 ec 04             	sub    $0x4,%esp
  800d15:	52                   	push   %edx
  800d16:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d19:	50                   	push   %eax
  800d1a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1d:	ff 75 f0             	pushl  -0x10(%ebp)
  800d20:	ff 75 0c             	pushl  0xc(%ebp)
  800d23:	ff 75 08             	pushl  0x8(%ebp)
  800d26:	e8 00 fb ff ff       	call   80082b <printnum>
  800d2b:	83 c4 20             	add    $0x20,%esp
			break;
  800d2e:	eb 34                	jmp    800d64 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d30:	83 ec 08             	sub    $0x8,%esp
  800d33:	ff 75 0c             	pushl  0xc(%ebp)
  800d36:	53                   	push   %ebx
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	ff d0                	call   *%eax
  800d3c:	83 c4 10             	add    $0x10,%esp
			break;
  800d3f:	eb 23                	jmp    800d64 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d41:	83 ec 08             	sub    $0x8,%esp
  800d44:	ff 75 0c             	pushl  0xc(%ebp)
  800d47:	6a 25                	push   $0x25
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	ff d0                	call   *%eax
  800d4e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d51:	ff 4d 10             	decl   0x10(%ebp)
  800d54:	eb 03                	jmp    800d59 <vprintfmt+0x3b1>
  800d56:	ff 4d 10             	decl   0x10(%ebp)
  800d59:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5c:	48                   	dec    %eax
  800d5d:	8a 00                	mov    (%eax),%al
  800d5f:	3c 25                	cmp    $0x25,%al
  800d61:	75 f3                	jne    800d56 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d63:	90                   	nop
		}
	}
  800d64:	e9 47 fc ff ff       	jmp    8009b0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d69:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d6d:	5b                   	pop    %ebx
  800d6e:	5e                   	pop    %esi
  800d6f:	5d                   	pop    %ebp
  800d70:	c3                   	ret    

00800d71 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d77:	8d 45 10             	lea    0x10(%ebp),%eax
  800d7a:	83 c0 04             	add    $0x4,%eax
  800d7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d80:	8b 45 10             	mov    0x10(%ebp),%eax
  800d83:	ff 75 f4             	pushl  -0xc(%ebp)
  800d86:	50                   	push   %eax
  800d87:	ff 75 0c             	pushl  0xc(%ebp)
  800d8a:	ff 75 08             	pushl  0x8(%ebp)
  800d8d:	e8 16 fc ff ff       	call   8009a8 <vprintfmt>
  800d92:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d95:	90                   	nop
  800d96:	c9                   	leave  
  800d97:	c3                   	ret    

00800d98 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d98:	55                   	push   %ebp
  800d99:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9e:	8b 40 08             	mov    0x8(%eax),%eax
  800da1:	8d 50 01             	lea    0x1(%eax),%edx
  800da4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da7:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dad:	8b 10                	mov    (%eax),%edx
  800daf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db2:	8b 40 04             	mov    0x4(%eax),%eax
  800db5:	39 c2                	cmp    %eax,%edx
  800db7:	73 12                	jae    800dcb <sprintputch+0x33>
		*b->buf++ = ch;
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	8b 00                	mov    (%eax),%eax
  800dbe:	8d 48 01             	lea    0x1(%eax),%ecx
  800dc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc4:	89 0a                	mov    %ecx,(%edx)
  800dc6:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc9:	88 10                	mov    %dl,(%eax)
}
  800dcb:	90                   	nop
  800dcc:	5d                   	pop    %ebp
  800dcd:	c3                   	ret    

00800dce <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800dce:	55                   	push   %ebp
  800dcf:	89 e5                	mov    %esp,%ebp
  800dd1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800dda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	01 d0                	add    %edx,%eax
  800de5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800def:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800df3:	74 06                	je     800dfb <vsnprintf+0x2d>
  800df5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df9:	7f 07                	jg     800e02 <vsnprintf+0x34>
		return -E_INVAL;
  800dfb:	b8 03 00 00 00       	mov    $0x3,%eax
  800e00:	eb 20                	jmp    800e22 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e02:	ff 75 14             	pushl  0x14(%ebp)
  800e05:	ff 75 10             	pushl  0x10(%ebp)
  800e08:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e0b:	50                   	push   %eax
  800e0c:	68 98 0d 80 00       	push   $0x800d98
  800e11:	e8 92 fb ff ff       	call   8009a8 <vprintfmt>
  800e16:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e19:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e1c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e22:	c9                   	leave  
  800e23:	c3                   	ret    

00800e24 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e24:	55                   	push   %ebp
  800e25:	89 e5                	mov    %esp,%ebp
  800e27:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e2a:	8d 45 10             	lea    0x10(%ebp),%eax
  800e2d:	83 c0 04             	add    $0x4,%eax
  800e30:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e33:	8b 45 10             	mov    0x10(%ebp),%eax
  800e36:	ff 75 f4             	pushl  -0xc(%ebp)
  800e39:	50                   	push   %eax
  800e3a:	ff 75 0c             	pushl  0xc(%ebp)
  800e3d:	ff 75 08             	pushl  0x8(%ebp)
  800e40:	e8 89 ff ff ff       	call   800dce <vsnprintf>
  800e45:	83 c4 10             	add    $0x10,%esp
  800e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e4e:	c9                   	leave  
  800e4f:	c3                   	ret    

00800e50 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e50:	55                   	push   %ebp
  800e51:	89 e5                	mov    %esp,%ebp
  800e53:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e5d:	eb 06                	jmp    800e65 <strlen+0x15>
		n++;
  800e5f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e62:	ff 45 08             	incl   0x8(%ebp)
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	8a 00                	mov    (%eax),%al
  800e6a:	84 c0                	test   %al,%al
  800e6c:	75 f1                	jne    800e5f <strlen+0xf>
		n++;
	return n;
  800e6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e71:	c9                   	leave  
  800e72:	c3                   	ret    

00800e73 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e73:	55                   	push   %ebp
  800e74:	89 e5                	mov    %esp,%ebp
  800e76:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e80:	eb 09                	jmp    800e8b <strnlen+0x18>
		n++;
  800e82:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e85:	ff 45 08             	incl   0x8(%ebp)
  800e88:	ff 4d 0c             	decl   0xc(%ebp)
  800e8b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e8f:	74 09                	je     800e9a <strnlen+0x27>
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	8a 00                	mov    (%eax),%al
  800e96:	84 c0                	test   %al,%al
  800e98:	75 e8                	jne    800e82 <strnlen+0xf>
		n++;
	return n;
  800e9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e9d:	c9                   	leave  
  800e9e:	c3                   	ret    

00800e9f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e9f:	55                   	push   %ebp
  800ea0:	89 e5                	mov    %esp,%ebp
  800ea2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800eab:	90                   	nop
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	8d 50 01             	lea    0x1(%eax),%edx
  800eb2:	89 55 08             	mov    %edx,0x8(%ebp)
  800eb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ebb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ebe:	8a 12                	mov    (%edx),%dl
  800ec0:	88 10                	mov    %dl,(%eax)
  800ec2:	8a 00                	mov    (%eax),%al
  800ec4:	84 c0                	test   %al,%al
  800ec6:	75 e4                	jne    800eac <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ec8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ecb:	c9                   	leave  
  800ecc:	c3                   	ret    

00800ecd <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ecd:	55                   	push   %ebp
  800ece:	89 e5                	mov    %esp,%ebp
  800ed0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ed9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee0:	eb 1f                	jmp    800f01 <strncpy+0x34>
		*dst++ = *src;
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	8d 50 01             	lea    0x1(%eax),%edx
  800ee8:	89 55 08             	mov    %edx,0x8(%ebp)
  800eeb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eee:	8a 12                	mov    (%edx),%dl
  800ef0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	84 c0                	test   %al,%al
  800ef9:	74 03                	je     800efe <strncpy+0x31>
			src++;
  800efb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800efe:	ff 45 fc             	incl   -0x4(%ebp)
  800f01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f04:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f07:	72 d9                	jb     800ee2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f09:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f0c:	c9                   	leave  
  800f0d:	c3                   	ret    

00800f0e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f0e:	55                   	push   %ebp
  800f0f:	89 e5                	mov    %esp,%ebp
  800f11:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f1e:	74 30                	je     800f50 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f20:	eb 16                	jmp    800f38 <strlcpy+0x2a>
			*dst++ = *src++;
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	8d 50 01             	lea    0x1(%eax),%edx
  800f28:	89 55 08             	mov    %edx,0x8(%ebp)
  800f2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f31:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f34:	8a 12                	mov    (%edx),%dl
  800f36:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f38:	ff 4d 10             	decl   0x10(%ebp)
  800f3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3f:	74 09                	je     800f4a <strlcpy+0x3c>
  800f41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	84 c0                	test   %al,%al
  800f48:	75 d8                	jne    800f22 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f50:	8b 55 08             	mov    0x8(%ebp),%edx
  800f53:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f56:	29 c2                	sub    %eax,%edx
  800f58:	89 d0                	mov    %edx,%eax
}
  800f5a:	c9                   	leave  
  800f5b:	c3                   	ret    

00800f5c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f5c:	55                   	push   %ebp
  800f5d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f5f:	eb 06                	jmp    800f67 <strcmp+0xb>
		p++, q++;
  800f61:	ff 45 08             	incl   0x8(%ebp)
  800f64:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	84 c0                	test   %al,%al
  800f6e:	74 0e                	je     800f7e <strcmp+0x22>
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 10                	mov    (%eax),%dl
  800f75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	38 c2                	cmp    %al,%dl
  800f7c:	74 e3                	je     800f61 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	8a 00                	mov    (%eax),%al
  800f83:	0f b6 d0             	movzbl %al,%edx
  800f86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	0f b6 c0             	movzbl %al,%eax
  800f8e:	29 c2                	sub    %eax,%edx
  800f90:	89 d0                	mov    %edx,%eax
}
  800f92:	5d                   	pop    %ebp
  800f93:	c3                   	ret    

00800f94 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f94:	55                   	push   %ebp
  800f95:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f97:	eb 09                	jmp    800fa2 <strncmp+0xe>
		n--, p++, q++;
  800f99:	ff 4d 10             	decl   0x10(%ebp)
  800f9c:	ff 45 08             	incl   0x8(%ebp)
  800f9f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fa2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa6:	74 17                	je     800fbf <strncmp+0x2b>
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	84 c0                	test   %al,%al
  800faf:	74 0e                	je     800fbf <strncmp+0x2b>
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	8a 10                	mov    (%eax),%dl
  800fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	38 c2                	cmp    %al,%dl
  800fbd:	74 da                	je     800f99 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fbf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fc3:	75 07                	jne    800fcc <strncmp+0x38>
		return 0;
  800fc5:	b8 00 00 00 00       	mov    $0x0,%eax
  800fca:	eb 14                	jmp    800fe0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	0f b6 d0             	movzbl %al,%edx
  800fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd7:	8a 00                	mov    (%eax),%al
  800fd9:	0f b6 c0             	movzbl %al,%eax
  800fdc:	29 c2                	sub    %eax,%edx
  800fde:	89 d0                	mov    %edx,%eax
}
  800fe0:	5d                   	pop    %ebp
  800fe1:	c3                   	ret    

00800fe2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
  800fe5:	83 ec 04             	sub    $0x4,%esp
  800fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800feb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fee:	eb 12                	jmp    801002 <strchr+0x20>
		if (*s == c)
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ff8:	75 05                	jne    800fff <strchr+0x1d>
			return (char *) s;
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	eb 11                	jmp    801010 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fff:	ff 45 08             	incl   0x8(%ebp)
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	84 c0                	test   %al,%al
  801009:	75 e5                	jne    800ff0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80100b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801010:	c9                   	leave  
  801011:	c3                   	ret    

00801012 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801012:	55                   	push   %ebp
  801013:	89 e5                	mov    %esp,%ebp
  801015:	83 ec 04             	sub    $0x4,%esp
  801018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80101e:	eb 0d                	jmp    80102d <strfind+0x1b>
		if (*s == c)
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	8a 00                	mov    (%eax),%al
  801025:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801028:	74 0e                	je     801038 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80102a:	ff 45 08             	incl   0x8(%ebp)
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	84 c0                	test   %al,%al
  801034:	75 ea                	jne    801020 <strfind+0xe>
  801036:	eb 01                	jmp    801039 <strfind+0x27>
		if (*s == c)
			break;
  801038:	90                   	nop
	return (char *) s;
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
  801041:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80104a:	8b 45 10             	mov    0x10(%ebp),%eax
  80104d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801050:	eb 0e                	jmp    801060 <memset+0x22>
		*p++ = c;
  801052:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801055:	8d 50 01             	lea    0x1(%eax),%edx
  801058:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80105b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801060:	ff 4d f8             	decl   -0x8(%ebp)
  801063:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801067:	79 e9                	jns    801052 <memset+0x14>
		*p++ = c;

	return v;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801074:	8b 45 0c             	mov    0xc(%ebp),%eax
  801077:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801080:	eb 16                	jmp    801098 <memcpy+0x2a>
		*d++ = *s++;
  801082:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801085:	8d 50 01             	lea    0x1(%eax),%edx
  801088:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80108b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80108e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801091:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801094:	8a 12                	mov    (%edx),%dl
  801096:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801098:	8b 45 10             	mov    0x10(%ebp),%eax
  80109b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80109e:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a1:	85 c0                	test   %eax,%eax
  8010a3:	75 dd                	jne    801082 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010a8:	c9                   	leave  
  8010a9:	c3                   	ret    

008010aa <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010aa:	55                   	push   %ebp
  8010ab:	89 e5                	mov    %esp,%ebp
  8010ad:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010c2:	73 50                	jae    801114 <memmove+0x6a>
  8010c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ca:	01 d0                	add    %edx,%eax
  8010cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010cf:	76 43                	jbe    801114 <memmove+0x6a>
		s += n;
  8010d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010da:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010dd:	eb 10                	jmp    8010ef <memmove+0x45>
			*--d = *--s;
  8010df:	ff 4d f8             	decl   -0x8(%ebp)
  8010e2:	ff 4d fc             	decl   -0x4(%ebp)
  8010e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e8:	8a 10                	mov    (%eax),%dl
  8010ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ed:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f8:	85 c0                	test   %eax,%eax
  8010fa:	75 e3                	jne    8010df <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010fc:	eb 23                	jmp    801121 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801101:	8d 50 01             	lea    0x1(%eax),%edx
  801104:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801107:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80110a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80110d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801110:	8a 12                	mov    (%edx),%dl
  801112:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801114:	8b 45 10             	mov    0x10(%ebp),%eax
  801117:	8d 50 ff             	lea    -0x1(%eax),%edx
  80111a:	89 55 10             	mov    %edx,0x10(%ebp)
  80111d:	85 c0                	test   %eax,%eax
  80111f:	75 dd                	jne    8010fe <memmove+0x54>
			*d++ = *s++;

	return dst;
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801124:	c9                   	leave  
  801125:	c3                   	ret    

00801126 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801126:	55                   	push   %ebp
  801127:	89 e5                	mov    %esp,%ebp
  801129:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801132:	8b 45 0c             	mov    0xc(%ebp),%eax
  801135:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801138:	eb 2a                	jmp    801164 <memcmp+0x3e>
		if (*s1 != *s2)
  80113a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113d:	8a 10                	mov    (%eax),%dl
  80113f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	38 c2                	cmp    %al,%dl
  801146:	74 16                	je     80115e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801148:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	0f b6 d0             	movzbl %al,%edx
  801150:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	0f b6 c0             	movzbl %al,%eax
  801158:	29 c2                	sub    %eax,%edx
  80115a:	89 d0                	mov    %edx,%eax
  80115c:	eb 18                	jmp    801176 <memcmp+0x50>
		s1++, s2++;
  80115e:	ff 45 fc             	incl   -0x4(%ebp)
  801161:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801164:	8b 45 10             	mov    0x10(%ebp),%eax
  801167:	8d 50 ff             	lea    -0x1(%eax),%edx
  80116a:	89 55 10             	mov    %edx,0x10(%ebp)
  80116d:	85 c0                	test   %eax,%eax
  80116f:	75 c9                	jne    80113a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801171:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
  80117b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80117e:	8b 55 08             	mov    0x8(%ebp),%edx
  801181:	8b 45 10             	mov    0x10(%ebp),%eax
  801184:	01 d0                	add    %edx,%eax
  801186:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801189:	eb 15                	jmp    8011a0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	8a 00                	mov    (%eax),%al
  801190:	0f b6 d0             	movzbl %al,%edx
  801193:	8b 45 0c             	mov    0xc(%ebp),%eax
  801196:	0f b6 c0             	movzbl %al,%eax
  801199:	39 c2                	cmp    %eax,%edx
  80119b:	74 0d                	je     8011aa <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80119d:	ff 45 08             	incl   0x8(%ebp)
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011a6:	72 e3                	jb     80118b <memfind+0x13>
  8011a8:	eb 01                	jmp    8011ab <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011aa:	90                   	nop
	return (void *) s;
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
  8011b3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011c4:	eb 03                	jmp    8011c9 <strtol+0x19>
		s++;
  8011c6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3c 20                	cmp    $0x20,%al
  8011d0:	74 f4                	je     8011c6 <strtol+0x16>
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	3c 09                	cmp    $0x9,%al
  8011d9:	74 eb                	je     8011c6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	3c 2b                	cmp    $0x2b,%al
  8011e2:	75 05                	jne    8011e9 <strtol+0x39>
		s++;
  8011e4:	ff 45 08             	incl   0x8(%ebp)
  8011e7:	eb 13                	jmp    8011fc <strtol+0x4c>
	else if (*s == '-')
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	3c 2d                	cmp    $0x2d,%al
  8011f0:	75 0a                	jne    8011fc <strtol+0x4c>
		s++, neg = 1;
  8011f2:	ff 45 08             	incl   0x8(%ebp)
  8011f5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801200:	74 06                	je     801208 <strtol+0x58>
  801202:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801206:	75 20                	jne    801228 <strtol+0x78>
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	3c 30                	cmp    $0x30,%al
  80120f:	75 17                	jne    801228 <strtol+0x78>
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	40                   	inc    %eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	3c 78                	cmp    $0x78,%al
  801219:	75 0d                	jne    801228 <strtol+0x78>
		s += 2, base = 16;
  80121b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80121f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801226:	eb 28                	jmp    801250 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801228:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80122c:	75 15                	jne    801243 <strtol+0x93>
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	3c 30                	cmp    $0x30,%al
  801235:	75 0c                	jne    801243 <strtol+0x93>
		s++, base = 8;
  801237:	ff 45 08             	incl   0x8(%ebp)
  80123a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801241:	eb 0d                	jmp    801250 <strtol+0xa0>
	else if (base == 0)
  801243:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801247:	75 07                	jne    801250 <strtol+0xa0>
		base = 10;
  801249:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	3c 2f                	cmp    $0x2f,%al
  801257:	7e 19                	jle    801272 <strtol+0xc2>
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	8a 00                	mov    (%eax),%al
  80125e:	3c 39                	cmp    $0x39,%al
  801260:	7f 10                	jg     801272 <strtol+0xc2>
			dig = *s - '0';
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	8a 00                	mov    (%eax),%al
  801267:	0f be c0             	movsbl %al,%eax
  80126a:	83 e8 30             	sub    $0x30,%eax
  80126d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801270:	eb 42                	jmp    8012b4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	3c 60                	cmp    $0x60,%al
  801279:	7e 19                	jle    801294 <strtol+0xe4>
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	8a 00                	mov    (%eax),%al
  801280:	3c 7a                	cmp    $0x7a,%al
  801282:	7f 10                	jg     801294 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	8a 00                	mov    (%eax),%al
  801289:	0f be c0             	movsbl %al,%eax
  80128c:	83 e8 57             	sub    $0x57,%eax
  80128f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801292:	eb 20                	jmp    8012b4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	3c 40                	cmp    $0x40,%al
  80129b:	7e 39                	jle    8012d6 <strtol+0x126>
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	3c 5a                	cmp    $0x5a,%al
  8012a4:	7f 30                	jg     8012d6 <strtol+0x126>
			dig = *s - 'A' + 10;
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	8a 00                	mov    (%eax),%al
  8012ab:	0f be c0             	movsbl %al,%eax
  8012ae:	83 e8 37             	sub    $0x37,%eax
  8012b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012b7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012ba:	7d 19                	jge    8012d5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012bc:	ff 45 08             	incl   0x8(%ebp)
  8012bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012c6:	89 c2                	mov    %eax,%edx
  8012c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012cb:	01 d0                	add    %edx,%eax
  8012cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012d0:	e9 7b ff ff ff       	jmp    801250 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012d5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012da:	74 08                	je     8012e4 <strtol+0x134>
		*endptr = (char *) s;
  8012dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012df:	8b 55 08             	mov    0x8(%ebp),%edx
  8012e2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012e4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012e8:	74 07                	je     8012f1 <strtol+0x141>
  8012ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ed:	f7 d8                	neg    %eax
  8012ef:	eb 03                	jmp    8012f4 <strtol+0x144>
  8012f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012f4:	c9                   	leave  
  8012f5:	c3                   	ret    

008012f6 <ltostr>:

void
ltostr(long value, char *str)
{
  8012f6:	55                   	push   %ebp
  8012f7:	89 e5                	mov    %esp,%ebp
  8012f9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801303:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80130a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80130e:	79 13                	jns    801323 <ltostr+0x2d>
	{
		neg = 1;
  801310:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801317:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80131d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801320:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80132b:	99                   	cltd   
  80132c:	f7 f9                	idiv   %ecx
  80132e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801331:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801334:	8d 50 01             	lea    0x1(%eax),%edx
  801337:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80133a:	89 c2                	mov    %eax,%edx
  80133c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133f:	01 d0                	add    %edx,%eax
  801341:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801344:	83 c2 30             	add    $0x30,%edx
  801347:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801349:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80134c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801351:	f7 e9                	imul   %ecx
  801353:	c1 fa 02             	sar    $0x2,%edx
  801356:	89 c8                	mov    %ecx,%eax
  801358:	c1 f8 1f             	sar    $0x1f,%eax
  80135b:	29 c2                	sub    %eax,%edx
  80135d:	89 d0                	mov    %edx,%eax
  80135f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801362:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801365:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80136a:	f7 e9                	imul   %ecx
  80136c:	c1 fa 02             	sar    $0x2,%edx
  80136f:	89 c8                	mov    %ecx,%eax
  801371:	c1 f8 1f             	sar    $0x1f,%eax
  801374:	29 c2                	sub    %eax,%edx
  801376:	89 d0                	mov    %edx,%eax
  801378:	c1 e0 02             	shl    $0x2,%eax
  80137b:	01 d0                	add    %edx,%eax
  80137d:	01 c0                	add    %eax,%eax
  80137f:	29 c1                	sub    %eax,%ecx
  801381:	89 ca                	mov    %ecx,%edx
  801383:	85 d2                	test   %edx,%edx
  801385:	75 9c                	jne    801323 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801387:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80138e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801391:	48                   	dec    %eax
  801392:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801395:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801399:	74 3d                	je     8013d8 <ltostr+0xe2>
		start = 1 ;
  80139b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013a2:	eb 34                	jmp    8013d8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8013a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	01 d0                	add    %edx,%eax
  8013ac:	8a 00                	mov    (%eax),%al
  8013ae:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b7:	01 c2                	add    %eax,%edx
  8013b9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bf:	01 c8                	add    %ecx,%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cb:	01 c2                	add    %eax,%edx
  8013cd:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013d0:	88 02                	mov    %al,(%edx)
		start++ ;
  8013d2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013d5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013db:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013de:	7c c4                	jl     8013a4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e6:	01 d0                	add    %edx,%eax
  8013e8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013eb:	90                   	nop
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013f4:	ff 75 08             	pushl  0x8(%ebp)
  8013f7:	e8 54 fa ff ff       	call   800e50 <strlen>
  8013fc:	83 c4 04             	add    $0x4,%esp
  8013ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801402:	ff 75 0c             	pushl  0xc(%ebp)
  801405:	e8 46 fa ff ff       	call   800e50 <strlen>
  80140a:	83 c4 04             	add    $0x4,%esp
  80140d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801417:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80141e:	eb 17                	jmp    801437 <strcconcat+0x49>
		final[s] = str1[s] ;
  801420:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801423:	8b 45 10             	mov    0x10(%ebp),%eax
  801426:	01 c2                	add    %eax,%edx
  801428:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	01 c8                	add    %ecx,%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801434:	ff 45 fc             	incl   -0x4(%ebp)
  801437:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80143d:	7c e1                	jl     801420 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80143f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801446:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80144d:	eb 1f                	jmp    80146e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80144f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801452:	8d 50 01             	lea    0x1(%eax),%edx
  801455:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801458:	89 c2                	mov    %eax,%edx
  80145a:	8b 45 10             	mov    0x10(%ebp),%eax
  80145d:	01 c2                	add    %eax,%edx
  80145f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801462:	8b 45 0c             	mov    0xc(%ebp),%eax
  801465:	01 c8                	add    %ecx,%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80146b:	ff 45 f8             	incl   -0x8(%ebp)
  80146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801471:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801474:	7c d9                	jl     80144f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801476:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801479:	8b 45 10             	mov    0x10(%ebp),%eax
  80147c:	01 d0                	add    %edx,%eax
  80147e:	c6 00 00             	movb   $0x0,(%eax)
}
  801481:	90                   	nop
  801482:	c9                   	leave  
  801483:	c3                   	ret    

00801484 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801484:	55                   	push   %ebp
  801485:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801487:	8b 45 14             	mov    0x14(%ebp),%eax
  80148a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801490:	8b 45 14             	mov    0x14(%ebp),%eax
  801493:	8b 00                	mov    (%eax),%eax
  801495:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80149c:	8b 45 10             	mov    0x10(%ebp),%eax
  80149f:	01 d0                	add    %edx,%eax
  8014a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014a7:	eb 0c                	jmp    8014b5 <strsplit+0x31>
			*string++ = 0;
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	8d 50 01             	lea    0x1(%eax),%edx
  8014af:	89 55 08             	mov    %edx,0x8(%ebp)
  8014b2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b8:	8a 00                	mov    (%eax),%al
  8014ba:	84 c0                	test   %al,%al
  8014bc:	74 18                	je     8014d6 <strsplit+0x52>
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	8a 00                	mov    (%eax),%al
  8014c3:	0f be c0             	movsbl %al,%eax
  8014c6:	50                   	push   %eax
  8014c7:	ff 75 0c             	pushl  0xc(%ebp)
  8014ca:	e8 13 fb ff ff       	call   800fe2 <strchr>
  8014cf:	83 c4 08             	add    $0x8,%esp
  8014d2:	85 c0                	test   %eax,%eax
  8014d4:	75 d3                	jne    8014a9 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	8a 00                	mov    (%eax),%al
  8014db:	84 c0                	test   %al,%al
  8014dd:	74 5a                	je     801539 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014df:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e2:	8b 00                	mov    (%eax),%eax
  8014e4:	83 f8 0f             	cmp    $0xf,%eax
  8014e7:	75 07                	jne    8014f0 <strsplit+0x6c>
		{
			return 0;
  8014e9:	b8 00 00 00 00       	mov    $0x0,%eax
  8014ee:	eb 66                	jmp    801556 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f3:	8b 00                	mov    (%eax),%eax
  8014f5:	8d 48 01             	lea    0x1(%eax),%ecx
  8014f8:	8b 55 14             	mov    0x14(%ebp),%edx
  8014fb:	89 0a                	mov    %ecx,(%edx)
  8014fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801504:	8b 45 10             	mov    0x10(%ebp),%eax
  801507:	01 c2                	add    %eax,%edx
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80150e:	eb 03                	jmp    801513 <strsplit+0x8f>
			string++;
  801510:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	8a 00                	mov    (%eax),%al
  801518:	84 c0                	test   %al,%al
  80151a:	74 8b                	je     8014a7 <strsplit+0x23>
  80151c:	8b 45 08             	mov    0x8(%ebp),%eax
  80151f:	8a 00                	mov    (%eax),%al
  801521:	0f be c0             	movsbl %al,%eax
  801524:	50                   	push   %eax
  801525:	ff 75 0c             	pushl  0xc(%ebp)
  801528:	e8 b5 fa ff ff       	call   800fe2 <strchr>
  80152d:	83 c4 08             	add    $0x8,%esp
  801530:	85 c0                	test   %eax,%eax
  801532:	74 dc                	je     801510 <strsplit+0x8c>
			string++;
	}
  801534:	e9 6e ff ff ff       	jmp    8014a7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801539:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80153a:	8b 45 14             	mov    0x14(%ebp),%eax
  80153d:	8b 00                	mov    (%eax),%eax
  80153f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801546:	8b 45 10             	mov    0x10(%ebp),%eax
  801549:	01 d0                	add    %edx,%eax
  80154b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801551:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
  80155b:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  80155e:	8b 45 08             	mov    0x8(%ebp),%eax
  801561:	c1 e8 0c             	shr    $0xc,%eax
  801564:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	25 ff 0f 00 00       	and    $0xfff,%eax
  80156f:	85 c0                	test   %eax,%eax
  801571:	74 03                	je     801576 <malloc+0x1e>
		num++;
  801573:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  801576:	a1 28 30 80 00       	mov    0x803028,%eax
  80157b:	85 c0                	test   %eax,%eax
  80157d:	75 71                	jne    8015f0 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  80157f:	a1 04 30 80 00       	mov    0x803004,%eax
  801584:	83 ec 08             	sub    $0x8,%esp
  801587:	ff 75 08             	pushl  0x8(%ebp)
  80158a:	50                   	push   %eax
  80158b:	e8 e4 04 00 00       	call   801a74 <sys_allocateMem>
  801590:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801593:	a1 04 30 80 00       	mov    0x803004,%eax
  801598:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  80159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159e:	c1 e0 0c             	shl    $0xc,%eax
  8015a1:	89 c2                	mov    %eax,%edx
  8015a3:	a1 04 30 80 00       	mov    0x803004,%eax
  8015a8:	01 d0                	add    %edx,%eax
  8015aa:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8015af:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015b7:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8015be:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015c3:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8015c6:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  8015cd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015d2:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8015d9:	01 00 00 00 
		sizeofarray++;
  8015dd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015e2:	40                   	inc    %eax
  8015e3:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  8015e8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015eb:	e9 f7 00 00 00       	jmp    8016e7 <malloc+0x18f>
	} else {
		int count = 0;
  8015f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  8015f7:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  8015fe:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801605:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80160c:	eb 7c                	jmp    80168a <malloc+0x132>
		{
			uint32 *pg = NULL;
  80160e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  801615:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80161c:	eb 1a                	jmp    801638 <malloc+0xe0>
				if (addresses[j] == i) {
  80161e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801621:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801628:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80162b:	75 08                	jne    801635 <malloc+0xdd>
					index = j;
  80162d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801630:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  801633:	eb 0d                	jmp    801642 <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  801635:	ff 45 dc             	incl   -0x24(%ebp)
  801638:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80163d:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801640:	7c dc                	jl     80161e <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  801642:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801646:	75 05                	jne    80164d <malloc+0xf5>
				count++;
  801648:	ff 45 f0             	incl   -0x10(%ebp)
  80164b:	eb 36                	jmp    801683 <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  80164d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801650:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801657:	85 c0                	test   %eax,%eax
  801659:	75 05                	jne    801660 <malloc+0x108>
					count++;
  80165b:	ff 45 f0             	incl   -0x10(%ebp)
  80165e:	eb 23                	jmp    801683 <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  801660:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801663:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801666:	7d 14                	jge    80167c <malloc+0x124>
  801668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80166b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80166e:	7c 0c                	jl     80167c <malloc+0x124>
						min = count;
  801670:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801673:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  801676:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801679:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  80167c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801683:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80168a:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801691:	0f 86 77 ff ff ff    	jbe    80160e <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  801697:	83 ec 08             	sub    $0x8,%esp
  80169a:	ff 75 08             	pushl  0x8(%ebp)
  80169d:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016a0:	e8 cf 03 00 00       	call   801a74 <sys_allocateMem>
  8016a5:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  8016a8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016b0:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  8016b7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016bc:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8016c2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  8016c9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016ce:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8016d5:	01 00 00 00 
		sizeofarray++;
  8016d9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016de:	40                   	inc    %eax
  8016df:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) min_addresss;
  8016e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8016e7:	c9                   	leave  
  8016e8:	c3                   	ret    

008016e9 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8016e9:	55                   	push   %ebp
  8016ea:	89 e5                	mov    %esp,%ebp
  8016ec:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8016f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8016fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801703:	eb 30                	jmp    801735 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801705:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801708:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80170f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801712:	75 1e                	jne    801732 <free+0x49>
  801714:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801717:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80171e:	83 f8 01             	cmp    $0x1,%eax
  801721:	75 0f                	jne    801732 <free+0x49>
			is_found = 1;
  801723:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  80172a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80172d:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801730:	eb 0d                	jmp    80173f <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801732:	ff 45 ec             	incl   -0x14(%ebp)
  801735:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80173a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  80173d:	7c c6                	jl     801705 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  80173f:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801743:	75 4f                	jne    801794 <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  801745:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801748:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  80174f:	c1 e0 0c             	shl    $0xc,%eax
  801752:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801755:	83 ec 08             	sub    $0x8,%esp
  801758:	ff 75 e4             	pushl  -0x1c(%ebp)
  80175b:	68 d0 2b 80 00       	push   $0x802bd0
  801760:	e8 69 f0 ff ff       	call   8007ce <cprintf>
  801765:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801768:	83 ec 08             	sub    $0x8,%esp
  80176b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80176e:	ff 75 e8             	pushl  -0x18(%ebp)
  801771:	e8 e2 02 00 00       	call   801a58 <sys_freeMem>
  801776:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801779:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80177c:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801783:	00 00 00 00 
		changes++;
  801787:	a1 28 30 80 00       	mov    0x803028,%eax
  80178c:	40                   	inc    %eax
  80178d:	a3 28 30 80 00       	mov    %eax,0x803028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801792:	eb 39                	jmp    8017cd <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  801794:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  80179b:	83 ec 08             	sub    $0x8,%esp
  80179e:	ff 75 e4             	pushl  -0x1c(%ebp)
  8017a1:	68 d0 2b 80 00       	push   $0x802bd0
  8017a6:	e8 23 f0 ff ff       	call   8007ce <cprintf>
  8017ab:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  8017ae:	83 ec 08             	sub    $0x8,%esp
  8017b1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8017b4:	ff 75 e8             	pushl  -0x18(%ebp)
  8017b7:	e8 9c 02 00 00       	call   801a58 <sys_freeMem>
  8017bc:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  8017bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017c2:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  8017c9:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  8017cd:	90                   	nop
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
  8017d3:	83 ec 18             	sub    $0x18,%esp
  8017d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8017dc:	83 ec 04             	sub    $0x4,%esp
  8017df:	68 f0 2b 80 00       	push   $0x802bf0
  8017e4:	68 9d 00 00 00       	push   $0x9d
  8017e9:	68 13 2c 80 00       	push   $0x802c13
  8017ee:	e8 39 ed ff ff       	call   80052c <_panic>

008017f3 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
  8017f6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017f9:	83 ec 04             	sub    $0x4,%esp
  8017fc:	68 f0 2b 80 00       	push   $0x802bf0
  801801:	68 a2 00 00 00       	push   $0xa2
  801806:	68 13 2c 80 00       	push   $0x802c13
  80180b:	e8 1c ed ff ff       	call   80052c <_panic>

00801810 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
  801813:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801816:	83 ec 04             	sub    $0x4,%esp
  801819:	68 f0 2b 80 00       	push   $0x802bf0
  80181e:	68 a7 00 00 00       	push   $0xa7
  801823:	68 13 2c 80 00       	push   $0x802c13
  801828:	e8 ff ec ff ff       	call   80052c <_panic>

0080182d <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
  801830:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801833:	83 ec 04             	sub    $0x4,%esp
  801836:	68 f0 2b 80 00       	push   $0x802bf0
  80183b:	68 ab 00 00 00       	push   $0xab
  801840:	68 13 2c 80 00       	push   $0x802c13
  801845:	e8 e2 ec ff ff       	call   80052c <_panic>

0080184a <expand>:
	return 0;
}

void expand(uint32 newSize) {
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
  80184d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801850:	83 ec 04             	sub    $0x4,%esp
  801853:	68 f0 2b 80 00       	push   $0x802bf0
  801858:	68 b0 00 00 00       	push   $0xb0
  80185d:	68 13 2c 80 00       	push   $0x802c13
  801862:	e8 c5 ec ff ff       	call   80052c <_panic>

00801867 <shrink>:
}
void shrink(uint32 newSize) {
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
  80186a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80186d:	83 ec 04             	sub    $0x4,%esp
  801870:	68 f0 2b 80 00       	push   $0x802bf0
  801875:	68 b3 00 00 00       	push   $0xb3
  80187a:	68 13 2c 80 00       	push   $0x802c13
  80187f:	e8 a8 ec ff ff       	call   80052c <_panic>

00801884 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
  801887:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80188a:	83 ec 04             	sub    $0x4,%esp
  80188d:	68 f0 2b 80 00       	push   $0x802bf0
  801892:	68 b7 00 00 00       	push   $0xb7
  801897:	68 13 2c 80 00       	push   $0x802c13
  80189c:	e8 8b ec ff ff       	call   80052c <_panic>

008018a1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
  8018a4:	57                   	push   %edi
  8018a5:	56                   	push   %esi
  8018a6:	53                   	push   %ebx
  8018a7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018b3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018b6:	8b 7d 18             	mov    0x18(%ebp),%edi
  8018b9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8018bc:	cd 30                	int    $0x30
  8018be:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8018c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018c4:	83 c4 10             	add    $0x10,%esp
  8018c7:	5b                   	pop    %ebx
  8018c8:	5e                   	pop    %esi
  8018c9:	5f                   	pop    %edi
  8018ca:	5d                   	pop    %ebp
  8018cb:	c3                   	ret    

008018cc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
  8018cf:	83 ec 04             	sub    $0x4,%esp
  8018d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018d8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	52                   	push   %edx
  8018e4:	ff 75 0c             	pushl  0xc(%ebp)
  8018e7:	50                   	push   %eax
  8018e8:	6a 00                	push   $0x0
  8018ea:	e8 b2 ff ff ff       	call   8018a1 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	90                   	nop
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <sys_cgetc>:

int
sys_cgetc(void)
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 01                	push   $0x1
  801904:	e8 98 ff ff ff       	call   8018a1 <syscall>
  801909:	83 c4 18             	add    $0x18,%esp
}
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	50                   	push   %eax
  80191d:	6a 05                	push   $0x5
  80191f:	e8 7d ff ff ff       	call   8018a1 <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 02                	push   $0x2
  801938:	e8 64 ff ff ff       	call   8018a1 <syscall>
  80193d:	83 c4 18             	add    $0x18,%esp
}
  801940:	c9                   	leave  
  801941:	c3                   	ret    

00801942 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801942:	55                   	push   %ebp
  801943:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 03                	push   $0x3
  801951:	e8 4b ff ff ff       	call   8018a1 <syscall>
  801956:	83 c4 18             	add    $0x18,%esp
}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 04                	push   $0x4
  80196a:	e8 32 ff ff ff       	call   8018a1 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <sys_env_exit>:


void sys_env_exit(void)
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 06                	push   $0x6
  801983:	e8 19 ff ff ff       	call   8018a1 <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
}
  80198b:	90                   	nop
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801991:	8b 55 0c             	mov    0xc(%ebp),%edx
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	52                   	push   %edx
  80199e:	50                   	push   %eax
  80199f:	6a 07                	push   $0x7
  8019a1:	e8 fb fe ff ff       	call   8018a1 <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
}
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
  8019ae:	56                   	push   %esi
  8019af:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8019b0:	8b 75 18             	mov    0x18(%ebp),%esi
  8019b3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	56                   	push   %esi
  8019c0:	53                   	push   %ebx
  8019c1:	51                   	push   %ecx
  8019c2:	52                   	push   %edx
  8019c3:	50                   	push   %eax
  8019c4:	6a 08                	push   $0x8
  8019c6:	e8 d6 fe ff ff       	call   8018a1 <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
}
  8019ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019d1:	5b                   	pop    %ebx
  8019d2:	5e                   	pop    %esi
  8019d3:	5d                   	pop    %ebp
  8019d4:	c3                   	ret    

008019d5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	52                   	push   %edx
  8019e5:	50                   	push   %eax
  8019e6:	6a 09                	push   $0x9
  8019e8:	e8 b4 fe ff ff       	call   8018a1 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	ff 75 0c             	pushl  0xc(%ebp)
  8019fe:	ff 75 08             	pushl  0x8(%ebp)
  801a01:	6a 0a                	push   $0xa
  801a03:	e8 99 fe ff ff       	call   8018a1 <syscall>
  801a08:	83 c4 18             	add    $0x18,%esp
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 0b                	push   $0xb
  801a1c:	e8 80 fe ff ff       	call   8018a1 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 0c                	push   $0xc
  801a35:	e8 67 fe ff ff       	call   8018a1 <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
}
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 0d                	push   $0xd
  801a4e:	e8 4e fe ff ff       	call   8018a1 <syscall>
  801a53:	83 c4 18             	add    $0x18,%esp
}
  801a56:	c9                   	leave  
  801a57:	c3                   	ret    

00801a58 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a58:	55                   	push   %ebp
  801a59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	ff 75 0c             	pushl  0xc(%ebp)
  801a64:	ff 75 08             	pushl  0x8(%ebp)
  801a67:	6a 11                	push   $0x11
  801a69:	e8 33 fe ff ff       	call   8018a1 <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
	return;
  801a71:	90                   	nop
}
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	ff 75 0c             	pushl  0xc(%ebp)
  801a80:	ff 75 08             	pushl  0x8(%ebp)
  801a83:	6a 12                	push   $0x12
  801a85:	e8 17 fe ff ff       	call   8018a1 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8d:	90                   	nop
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 0e                	push   $0xe
  801a9f:	e8 fd fd ff ff       	call   8018a1 <syscall>
  801aa4:	83 c4 18             	add    $0x18,%esp
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    

00801aa9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	ff 75 08             	pushl  0x8(%ebp)
  801ab7:	6a 0f                	push   $0xf
  801ab9:	e8 e3 fd ff ff       	call   8018a1 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 10                	push   $0x10
  801ad2:	e8 ca fd ff ff       	call   8018a1 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
}
  801ada:	90                   	nop
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 14                	push   $0x14
  801aec:	e8 b0 fd ff ff       	call   8018a1 <syscall>
  801af1:	83 c4 18             	add    $0x18,%esp
}
  801af4:	90                   	nop
  801af5:	c9                   	leave  
  801af6:	c3                   	ret    

00801af7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801af7:	55                   	push   %ebp
  801af8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 15                	push   $0x15
  801b06:	e8 96 fd ff ff       	call   8018a1 <syscall>
  801b0b:	83 c4 18             	add    $0x18,%esp
}
  801b0e:	90                   	nop
  801b0f:	c9                   	leave  
  801b10:	c3                   	ret    

00801b11 <sys_cputc>:


void
sys_cputc(const char c)
{
  801b11:	55                   	push   %ebp
  801b12:	89 e5                	mov    %esp,%ebp
  801b14:	83 ec 04             	sub    $0x4,%esp
  801b17:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b1d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	50                   	push   %eax
  801b2a:	6a 16                	push   $0x16
  801b2c:	e8 70 fd ff ff       	call   8018a1 <syscall>
  801b31:	83 c4 18             	add    $0x18,%esp
}
  801b34:	90                   	nop
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 17                	push   $0x17
  801b46:	e8 56 fd ff ff       	call   8018a1 <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
}
  801b4e:	90                   	nop
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b54:	8b 45 08             	mov    0x8(%ebp),%eax
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	ff 75 0c             	pushl  0xc(%ebp)
  801b60:	50                   	push   %eax
  801b61:	6a 18                	push   $0x18
  801b63:	e8 39 fd ff ff       	call   8018a1 <syscall>
  801b68:	83 c4 18             	add    $0x18,%esp
}
  801b6b:	c9                   	leave  
  801b6c:	c3                   	ret    

00801b6d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b6d:	55                   	push   %ebp
  801b6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b73:	8b 45 08             	mov    0x8(%ebp),%eax
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	52                   	push   %edx
  801b7d:	50                   	push   %eax
  801b7e:	6a 1b                	push   $0x1b
  801b80:	e8 1c fd ff ff       	call   8018a1 <syscall>
  801b85:	83 c4 18             	add    $0x18,%esp
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b90:	8b 45 08             	mov    0x8(%ebp),%eax
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	52                   	push   %edx
  801b9a:	50                   	push   %eax
  801b9b:	6a 19                	push   $0x19
  801b9d:	e8 ff fc ff ff       	call   8018a1 <syscall>
  801ba2:	83 c4 18             	add    $0x18,%esp
}
  801ba5:	90                   	nop
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bab:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bae:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	52                   	push   %edx
  801bb8:	50                   	push   %eax
  801bb9:	6a 1a                	push   $0x1a
  801bbb:	e8 e1 fc ff ff       	call   8018a1 <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	90                   	nop
  801bc4:	c9                   	leave  
  801bc5:	c3                   	ret    

00801bc6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
  801bc9:	83 ec 04             	sub    $0x4,%esp
  801bcc:	8b 45 10             	mov    0x10(%ebp),%eax
  801bcf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801bd2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801bd5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	6a 00                	push   $0x0
  801bde:	51                   	push   %ecx
  801bdf:	52                   	push   %edx
  801be0:	ff 75 0c             	pushl  0xc(%ebp)
  801be3:	50                   	push   %eax
  801be4:	6a 1c                	push   $0x1c
  801be6:	e8 b6 fc ff ff       	call   8018a1 <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
}
  801bee:	c9                   	leave  
  801bef:	c3                   	ret    

00801bf0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801bf3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	52                   	push   %edx
  801c00:	50                   	push   %eax
  801c01:	6a 1d                	push   $0x1d
  801c03:	e8 99 fc ff ff       	call   8018a1 <syscall>
  801c08:	83 c4 18             	add    $0x18,%esp
}
  801c0b:	c9                   	leave  
  801c0c:	c3                   	ret    

00801c0d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c0d:	55                   	push   %ebp
  801c0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c10:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c16:	8b 45 08             	mov    0x8(%ebp),%eax
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	51                   	push   %ecx
  801c1e:	52                   	push   %edx
  801c1f:	50                   	push   %eax
  801c20:	6a 1e                	push   $0x1e
  801c22:	e8 7a fc ff ff       	call   8018a1 <syscall>
  801c27:	83 c4 18             	add    $0x18,%esp
}
  801c2a:	c9                   	leave  
  801c2b:	c3                   	ret    

00801c2c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c2c:	55                   	push   %ebp
  801c2d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c32:	8b 45 08             	mov    0x8(%ebp),%eax
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	52                   	push   %edx
  801c3c:	50                   	push   %eax
  801c3d:	6a 1f                	push   $0x1f
  801c3f:	e8 5d fc ff ff       	call   8018a1 <syscall>
  801c44:	83 c4 18             	add    $0x18,%esp
}
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 20                	push   $0x20
  801c58:	e8 44 fc ff ff       	call   8018a1 <syscall>
  801c5d:	83 c4 18             	add    $0x18,%esp
}
  801c60:	c9                   	leave  
  801c61:	c3                   	ret    

00801c62 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c62:	55                   	push   %ebp
  801c63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c65:	8b 45 08             	mov    0x8(%ebp),%eax
  801c68:	6a 00                	push   $0x0
  801c6a:	ff 75 14             	pushl  0x14(%ebp)
  801c6d:	ff 75 10             	pushl  0x10(%ebp)
  801c70:	ff 75 0c             	pushl  0xc(%ebp)
  801c73:	50                   	push   %eax
  801c74:	6a 21                	push   $0x21
  801c76:	e8 26 fc ff ff       	call   8018a1 <syscall>
  801c7b:	83 c4 18             	add    $0x18,%esp
}
  801c7e:	c9                   	leave  
  801c7f:	c3                   	ret    

00801c80 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c83:	8b 45 08             	mov    0x8(%ebp),%eax
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	50                   	push   %eax
  801c8f:	6a 22                	push   $0x22
  801c91:	e8 0b fc ff ff       	call   8018a1 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	90                   	nop
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	50                   	push   %eax
  801cab:	6a 23                	push   $0x23
  801cad:	e8 ef fb ff ff       	call   8018a1 <syscall>
  801cb2:	83 c4 18             	add    $0x18,%esp
}
  801cb5:	90                   	nop
  801cb6:	c9                   	leave  
  801cb7:	c3                   	ret    

00801cb8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801cb8:	55                   	push   %ebp
  801cb9:	89 e5                	mov    %esp,%ebp
  801cbb:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801cbe:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cc1:	8d 50 04             	lea    0x4(%eax),%edx
  801cc4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	52                   	push   %edx
  801cce:	50                   	push   %eax
  801ccf:	6a 24                	push   $0x24
  801cd1:	e8 cb fb ff ff       	call   8018a1 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
	return result;
  801cd9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801cdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cdf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ce2:	89 01                	mov    %eax,(%ecx)
  801ce4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cea:	c9                   	leave  
  801ceb:	c2 04 00             	ret    $0x4

00801cee <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801cee:	55                   	push   %ebp
  801cef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	ff 75 10             	pushl  0x10(%ebp)
  801cf8:	ff 75 0c             	pushl  0xc(%ebp)
  801cfb:	ff 75 08             	pushl  0x8(%ebp)
  801cfe:	6a 13                	push   $0x13
  801d00:	e8 9c fb ff ff       	call   8018a1 <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
	return ;
  801d08:	90                   	nop
}
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <sys_rcr2>:
uint32 sys_rcr2()
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 25                	push   $0x25
  801d1a:	e8 82 fb ff ff       	call   8018a1 <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
}
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d24:	55                   	push   %ebp
  801d25:	89 e5                	mov    %esp,%ebp
  801d27:	83 ec 04             	sub    $0x4,%esp
  801d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d30:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	50                   	push   %eax
  801d3d:	6a 26                	push   $0x26
  801d3f:	e8 5d fb ff ff       	call   8018a1 <syscall>
  801d44:	83 c4 18             	add    $0x18,%esp
	return ;
  801d47:	90                   	nop
}
  801d48:	c9                   	leave  
  801d49:	c3                   	ret    

00801d4a <rsttst>:
void rsttst()
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 28                	push   $0x28
  801d59:	e8 43 fb ff ff       	call   8018a1 <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
	return ;
  801d61:	90                   	nop
}
  801d62:	c9                   	leave  
  801d63:	c3                   	ret    

00801d64 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d64:	55                   	push   %ebp
  801d65:	89 e5                	mov    %esp,%ebp
  801d67:	83 ec 04             	sub    $0x4,%esp
  801d6a:	8b 45 14             	mov    0x14(%ebp),%eax
  801d6d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d70:	8b 55 18             	mov    0x18(%ebp),%edx
  801d73:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d77:	52                   	push   %edx
  801d78:	50                   	push   %eax
  801d79:	ff 75 10             	pushl  0x10(%ebp)
  801d7c:	ff 75 0c             	pushl  0xc(%ebp)
  801d7f:	ff 75 08             	pushl  0x8(%ebp)
  801d82:	6a 27                	push   $0x27
  801d84:	e8 18 fb ff ff       	call   8018a1 <syscall>
  801d89:	83 c4 18             	add    $0x18,%esp
	return ;
  801d8c:	90                   	nop
}
  801d8d:	c9                   	leave  
  801d8e:	c3                   	ret    

00801d8f <chktst>:
void chktst(uint32 n)
{
  801d8f:	55                   	push   %ebp
  801d90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	ff 75 08             	pushl  0x8(%ebp)
  801d9d:	6a 29                	push   $0x29
  801d9f:	e8 fd fa ff ff       	call   8018a1 <syscall>
  801da4:	83 c4 18             	add    $0x18,%esp
	return ;
  801da7:	90                   	nop
}
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <inctst>:

void inctst()
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 2a                	push   $0x2a
  801db9:	e8 e3 fa ff ff       	call   8018a1 <syscall>
  801dbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801dc1:	90                   	nop
}
  801dc2:	c9                   	leave  
  801dc3:	c3                   	ret    

00801dc4 <gettst>:
uint32 gettst()
{
  801dc4:	55                   	push   %ebp
  801dc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 2b                	push   $0x2b
  801dd3:	e8 c9 fa ff ff       	call   8018a1 <syscall>
  801dd8:	83 c4 18             	add    $0x18,%esp
}
  801ddb:	c9                   	leave  
  801ddc:	c3                   	ret    

00801ddd <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
  801de0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 2c                	push   $0x2c
  801def:	e8 ad fa ff ff       	call   8018a1 <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
  801df7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801dfa:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801dfe:	75 07                	jne    801e07 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e00:	b8 01 00 00 00       	mov    $0x1,%eax
  801e05:	eb 05                	jmp    801e0c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e07:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
  801e11:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 2c                	push   $0x2c
  801e20:	e8 7c fa ff ff       	call   8018a1 <syscall>
  801e25:	83 c4 18             	add    $0x18,%esp
  801e28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e2b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e2f:	75 07                	jne    801e38 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e31:	b8 01 00 00 00       	mov    $0x1,%eax
  801e36:	eb 05                	jmp    801e3d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e38:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e3d:	c9                   	leave  
  801e3e:	c3                   	ret    

00801e3f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e3f:	55                   	push   %ebp
  801e40:	89 e5                	mov    %esp,%ebp
  801e42:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 2c                	push   $0x2c
  801e51:	e8 4b fa ff ff       	call   8018a1 <syscall>
  801e56:	83 c4 18             	add    $0x18,%esp
  801e59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e5c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e60:	75 07                	jne    801e69 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e62:	b8 01 00 00 00       	mov    $0x1,%eax
  801e67:	eb 05                	jmp    801e6e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e69:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e6e:	c9                   	leave  
  801e6f:	c3                   	ret    

00801e70 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e70:	55                   	push   %ebp
  801e71:	89 e5                	mov    %esp,%ebp
  801e73:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 2c                	push   $0x2c
  801e82:	e8 1a fa ff ff       	call   8018a1 <syscall>
  801e87:	83 c4 18             	add    $0x18,%esp
  801e8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e8d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e91:	75 07                	jne    801e9a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e93:	b8 01 00 00 00       	mov    $0x1,%eax
  801e98:	eb 05                	jmp    801e9f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e9f:	c9                   	leave  
  801ea0:	c3                   	ret    

00801ea1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	ff 75 08             	pushl  0x8(%ebp)
  801eaf:	6a 2d                	push   $0x2d
  801eb1:	e8 eb f9 ff ff       	call   8018a1 <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
	return ;
  801eb9:	90                   	nop
}
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
  801ebf:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801ec0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ec3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ec6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecc:	6a 00                	push   $0x0
  801ece:	53                   	push   %ebx
  801ecf:	51                   	push   %ecx
  801ed0:	52                   	push   %edx
  801ed1:	50                   	push   %eax
  801ed2:	6a 2e                	push   $0x2e
  801ed4:	e8 c8 f9 ff ff       	call   8018a1 <syscall>
  801ed9:	83 c4 18             	add    $0x18,%esp
}
  801edc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801edf:	c9                   	leave  
  801ee0:	c3                   	ret    

00801ee1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ee1:	55                   	push   %ebp
  801ee2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ee4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	52                   	push   %edx
  801ef1:	50                   	push   %eax
  801ef2:	6a 2f                	push   $0x2f
  801ef4:	e8 a8 f9 ff ff       	call   8018a1 <syscall>
  801ef9:	83 c4 18             	add    $0x18,%esp
}
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
  801f01:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801f04:	8b 55 08             	mov    0x8(%ebp),%edx
  801f07:	89 d0                	mov    %edx,%eax
  801f09:	c1 e0 02             	shl    $0x2,%eax
  801f0c:	01 d0                	add    %edx,%eax
  801f0e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f15:	01 d0                	add    %edx,%eax
  801f17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f1e:	01 d0                	add    %edx,%eax
  801f20:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f27:	01 d0                	add    %edx,%eax
  801f29:	c1 e0 04             	shl    $0x4,%eax
  801f2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801f2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801f36:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801f39:	83 ec 0c             	sub    $0xc,%esp
  801f3c:	50                   	push   %eax
  801f3d:	e8 76 fd ff ff       	call   801cb8 <sys_get_virtual_time>
  801f42:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801f45:	eb 41                	jmp    801f88 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801f47:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801f4a:	83 ec 0c             	sub    $0xc,%esp
  801f4d:	50                   	push   %eax
  801f4e:	e8 65 fd ff ff       	call   801cb8 <sys_get_virtual_time>
  801f53:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801f56:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801f59:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f5c:	29 c2                	sub    %eax,%edx
  801f5e:	89 d0                	mov    %edx,%eax
  801f60:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801f63:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801f66:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f69:	89 d1                	mov    %edx,%ecx
  801f6b:	29 c1                	sub    %eax,%ecx
  801f6d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801f70:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f73:	39 c2                	cmp    %eax,%edx
  801f75:	0f 97 c0             	seta   %al
  801f78:	0f b6 c0             	movzbl %al,%eax
  801f7b:	29 c1                	sub    %eax,%ecx
  801f7d:	89 c8                	mov    %ecx,%eax
  801f7f:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801f82:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801f85:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801f88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f8b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801f8e:	72 b7                	jb     801f47 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801f90:	90                   	nop
  801f91:	c9                   	leave  
  801f92:	c3                   	ret    

00801f93 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801f93:	55                   	push   %ebp
  801f94:	89 e5                	mov    %esp,%ebp
  801f96:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801f99:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801fa0:	eb 03                	jmp    801fa5 <busy_wait+0x12>
  801fa2:	ff 45 fc             	incl   -0x4(%ebp)
  801fa5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fa8:	3b 45 08             	cmp    0x8(%ebp),%eax
  801fab:	72 f5                	jb     801fa2 <busy_wait+0xf>
	return i;
  801fad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801fb0:	c9                   	leave  
  801fb1:	c3                   	ret    
  801fb2:	66 90                	xchg   %ax,%ax

00801fb4 <__udivdi3>:
  801fb4:	55                   	push   %ebp
  801fb5:	57                   	push   %edi
  801fb6:	56                   	push   %esi
  801fb7:	53                   	push   %ebx
  801fb8:	83 ec 1c             	sub    $0x1c,%esp
  801fbb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fbf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fc3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fc7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fcb:	89 ca                	mov    %ecx,%edx
  801fcd:	89 f8                	mov    %edi,%eax
  801fcf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fd3:	85 f6                	test   %esi,%esi
  801fd5:	75 2d                	jne    802004 <__udivdi3+0x50>
  801fd7:	39 cf                	cmp    %ecx,%edi
  801fd9:	77 65                	ja     802040 <__udivdi3+0x8c>
  801fdb:	89 fd                	mov    %edi,%ebp
  801fdd:	85 ff                	test   %edi,%edi
  801fdf:	75 0b                	jne    801fec <__udivdi3+0x38>
  801fe1:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe6:	31 d2                	xor    %edx,%edx
  801fe8:	f7 f7                	div    %edi
  801fea:	89 c5                	mov    %eax,%ebp
  801fec:	31 d2                	xor    %edx,%edx
  801fee:	89 c8                	mov    %ecx,%eax
  801ff0:	f7 f5                	div    %ebp
  801ff2:	89 c1                	mov    %eax,%ecx
  801ff4:	89 d8                	mov    %ebx,%eax
  801ff6:	f7 f5                	div    %ebp
  801ff8:	89 cf                	mov    %ecx,%edi
  801ffa:	89 fa                	mov    %edi,%edx
  801ffc:	83 c4 1c             	add    $0x1c,%esp
  801fff:	5b                   	pop    %ebx
  802000:	5e                   	pop    %esi
  802001:	5f                   	pop    %edi
  802002:	5d                   	pop    %ebp
  802003:	c3                   	ret    
  802004:	39 ce                	cmp    %ecx,%esi
  802006:	77 28                	ja     802030 <__udivdi3+0x7c>
  802008:	0f bd fe             	bsr    %esi,%edi
  80200b:	83 f7 1f             	xor    $0x1f,%edi
  80200e:	75 40                	jne    802050 <__udivdi3+0x9c>
  802010:	39 ce                	cmp    %ecx,%esi
  802012:	72 0a                	jb     80201e <__udivdi3+0x6a>
  802014:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802018:	0f 87 9e 00 00 00    	ja     8020bc <__udivdi3+0x108>
  80201e:	b8 01 00 00 00       	mov    $0x1,%eax
  802023:	89 fa                	mov    %edi,%edx
  802025:	83 c4 1c             	add    $0x1c,%esp
  802028:	5b                   	pop    %ebx
  802029:	5e                   	pop    %esi
  80202a:	5f                   	pop    %edi
  80202b:	5d                   	pop    %ebp
  80202c:	c3                   	ret    
  80202d:	8d 76 00             	lea    0x0(%esi),%esi
  802030:	31 ff                	xor    %edi,%edi
  802032:	31 c0                	xor    %eax,%eax
  802034:	89 fa                	mov    %edi,%edx
  802036:	83 c4 1c             	add    $0x1c,%esp
  802039:	5b                   	pop    %ebx
  80203a:	5e                   	pop    %esi
  80203b:	5f                   	pop    %edi
  80203c:	5d                   	pop    %ebp
  80203d:	c3                   	ret    
  80203e:	66 90                	xchg   %ax,%ax
  802040:	89 d8                	mov    %ebx,%eax
  802042:	f7 f7                	div    %edi
  802044:	31 ff                	xor    %edi,%edi
  802046:	89 fa                	mov    %edi,%edx
  802048:	83 c4 1c             	add    $0x1c,%esp
  80204b:	5b                   	pop    %ebx
  80204c:	5e                   	pop    %esi
  80204d:	5f                   	pop    %edi
  80204e:	5d                   	pop    %ebp
  80204f:	c3                   	ret    
  802050:	bd 20 00 00 00       	mov    $0x20,%ebp
  802055:	89 eb                	mov    %ebp,%ebx
  802057:	29 fb                	sub    %edi,%ebx
  802059:	89 f9                	mov    %edi,%ecx
  80205b:	d3 e6                	shl    %cl,%esi
  80205d:	89 c5                	mov    %eax,%ebp
  80205f:	88 d9                	mov    %bl,%cl
  802061:	d3 ed                	shr    %cl,%ebp
  802063:	89 e9                	mov    %ebp,%ecx
  802065:	09 f1                	or     %esi,%ecx
  802067:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80206b:	89 f9                	mov    %edi,%ecx
  80206d:	d3 e0                	shl    %cl,%eax
  80206f:	89 c5                	mov    %eax,%ebp
  802071:	89 d6                	mov    %edx,%esi
  802073:	88 d9                	mov    %bl,%cl
  802075:	d3 ee                	shr    %cl,%esi
  802077:	89 f9                	mov    %edi,%ecx
  802079:	d3 e2                	shl    %cl,%edx
  80207b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80207f:	88 d9                	mov    %bl,%cl
  802081:	d3 e8                	shr    %cl,%eax
  802083:	09 c2                	or     %eax,%edx
  802085:	89 d0                	mov    %edx,%eax
  802087:	89 f2                	mov    %esi,%edx
  802089:	f7 74 24 0c          	divl   0xc(%esp)
  80208d:	89 d6                	mov    %edx,%esi
  80208f:	89 c3                	mov    %eax,%ebx
  802091:	f7 e5                	mul    %ebp
  802093:	39 d6                	cmp    %edx,%esi
  802095:	72 19                	jb     8020b0 <__udivdi3+0xfc>
  802097:	74 0b                	je     8020a4 <__udivdi3+0xf0>
  802099:	89 d8                	mov    %ebx,%eax
  80209b:	31 ff                	xor    %edi,%edi
  80209d:	e9 58 ff ff ff       	jmp    801ffa <__udivdi3+0x46>
  8020a2:	66 90                	xchg   %ax,%ax
  8020a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020a8:	89 f9                	mov    %edi,%ecx
  8020aa:	d3 e2                	shl    %cl,%edx
  8020ac:	39 c2                	cmp    %eax,%edx
  8020ae:	73 e9                	jae    802099 <__udivdi3+0xe5>
  8020b0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020b3:	31 ff                	xor    %edi,%edi
  8020b5:	e9 40 ff ff ff       	jmp    801ffa <__udivdi3+0x46>
  8020ba:	66 90                	xchg   %ax,%ax
  8020bc:	31 c0                	xor    %eax,%eax
  8020be:	e9 37 ff ff ff       	jmp    801ffa <__udivdi3+0x46>
  8020c3:	90                   	nop

008020c4 <__umoddi3>:
  8020c4:	55                   	push   %ebp
  8020c5:	57                   	push   %edi
  8020c6:	56                   	push   %esi
  8020c7:	53                   	push   %ebx
  8020c8:	83 ec 1c             	sub    $0x1c,%esp
  8020cb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020cf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020d7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020db:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020df:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020e3:	89 f3                	mov    %esi,%ebx
  8020e5:	89 fa                	mov    %edi,%edx
  8020e7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020eb:	89 34 24             	mov    %esi,(%esp)
  8020ee:	85 c0                	test   %eax,%eax
  8020f0:	75 1a                	jne    80210c <__umoddi3+0x48>
  8020f2:	39 f7                	cmp    %esi,%edi
  8020f4:	0f 86 a2 00 00 00    	jbe    80219c <__umoddi3+0xd8>
  8020fa:	89 c8                	mov    %ecx,%eax
  8020fc:	89 f2                	mov    %esi,%edx
  8020fe:	f7 f7                	div    %edi
  802100:	89 d0                	mov    %edx,%eax
  802102:	31 d2                	xor    %edx,%edx
  802104:	83 c4 1c             	add    $0x1c,%esp
  802107:	5b                   	pop    %ebx
  802108:	5e                   	pop    %esi
  802109:	5f                   	pop    %edi
  80210a:	5d                   	pop    %ebp
  80210b:	c3                   	ret    
  80210c:	39 f0                	cmp    %esi,%eax
  80210e:	0f 87 ac 00 00 00    	ja     8021c0 <__umoddi3+0xfc>
  802114:	0f bd e8             	bsr    %eax,%ebp
  802117:	83 f5 1f             	xor    $0x1f,%ebp
  80211a:	0f 84 ac 00 00 00    	je     8021cc <__umoddi3+0x108>
  802120:	bf 20 00 00 00       	mov    $0x20,%edi
  802125:	29 ef                	sub    %ebp,%edi
  802127:	89 fe                	mov    %edi,%esi
  802129:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80212d:	89 e9                	mov    %ebp,%ecx
  80212f:	d3 e0                	shl    %cl,%eax
  802131:	89 d7                	mov    %edx,%edi
  802133:	89 f1                	mov    %esi,%ecx
  802135:	d3 ef                	shr    %cl,%edi
  802137:	09 c7                	or     %eax,%edi
  802139:	89 e9                	mov    %ebp,%ecx
  80213b:	d3 e2                	shl    %cl,%edx
  80213d:	89 14 24             	mov    %edx,(%esp)
  802140:	89 d8                	mov    %ebx,%eax
  802142:	d3 e0                	shl    %cl,%eax
  802144:	89 c2                	mov    %eax,%edx
  802146:	8b 44 24 08          	mov    0x8(%esp),%eax
  80214a:	d3 e0                	shl    %cl,%eax
  80214c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802150:	8b 44 24 08          	mov    0x8(%esp),%eax
  802154:	89 f1                	mov    %esi,%ecx
  802156:	d3 e8                	shr    %cl,%eax
  802158:	09 d0                	or     %edx,%eax
  80215a:	d3 eb                	shr    %cl,%ebx
  80215c:	89 da                	mov    %ebx,%edx
  80215e:	f7 f7                	div    %edi
  802160:	89 d3                	mov    %edx,%ebx
  802162:	f7 24 24             	mull   (%esp)
  802165:	89 c6                	mov    %eax,%esi
  802167:	89 d1                	mov    %edx,%ecx
  802169:	39 d3                	cmp    %edx,%ebx
  80216b:	0f 82 87 00 00 00    	jb     8021f8 <__umoddi3+0x134>
  802171:	0f 84 91 00 00 00    	je     802208 <__umoddi3+0x144>
  802177:	8b 54 24 04          	mov    0x4(%esp),%edx
  80217b:	29 f2                	sub    %esi,%edx
  80217d:	19 cb                	sbb    %ecx,%ebx
  80217f:	89 d8                	mov    %ebx,%eax
  802181:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802185:	d3 e0                	shl    %cl,%eax
  802187:	89 e9                	mov    %ebp,%ecx
  802189:	d3 ea                	shr    %cl,%edx
  80218b:	09 d0                	or     %edx,%eax
  80218d:	89 e9                	mov    %ebp,%ecx
  80218f:	d3 eb                	shr    %cl,%ebx
  802191:	89 da                	mov    %ebx,%edx
  802193:	83 c4 1c             	add    $0x1c,%esp
  802196:	5b                   	pop    %ebx
  802197:	5e                   	pop    %esi
  802198:	5f                   	pop    %edi
  802199:	5d                   	pop    %ebp
  80219a:	c3                   	ret    
  80219b:	90                   	nop
  80219c:	89 fd                	mov    %edi,%ebp
  80219e:	85 ff                	test   %edi,%edi
  8021a0:	75 0b                	jne    8021ad <__umoddi3+0xe9>
  8021a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a7:	31 d2                	xor    %edx,%edx
  8021a9:	f7 f7                	div    %edi
  8021ab:	89 c5                	mov    %eax,%ebp
  8021ad:	89 f0                	mov    %esi,%eax
  8021af:	31 d2                	xor    %edx,%edx
  8021b1:	f7 f5                	div    %ebp
  8021b3:	89 c8                	mov    %ecx,%eax
  8021b5:	f7 f5                	div    %ebp
  8021b7:	89 d0                	mov    %edx,%eax
  8021b9:	e9 44 ff ff ff       	jmp    802102 <__umoddi3+0x3e>
  8021be:	66 90                	xchg   %ax,%ax
  8021c0:	89 c8                	mov    %ecx,%eax
  8021c2:	89 f2                	mov    %esi,%edx
  8021c4:	83 c4 1c             	add    $0x1c,%esp
  8021c7:	5b                   	pop    %ebx
  8021c8:	5e                   	pop    %esi
  8021c9:	5f                   	pop    %edi
  8021ca:	5d                   	pop    %ebp
  8021cb:	c3                   	ret    
  8021cc:	3b 04 24             	cmp    (%esp),%eax
  8021cf:	72 06                	jb     8021d7 <__umoddi3+0x113>
  8021d1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021d5:	77 0f                	ja     8021e6 <__umoddi3+0x122>
  8021d7:	89 f2                	mov    %esi,%edx
  8021d9:	29 f9                	sub    %edi,%ecx
  8021db:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021df:	89 14 24             	mov    %edx,(%esp)
  8021e2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021e6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021ea:	8b 14 24             	mov    (%esp),%edx
  8021ed:	83 c4 1c             	add    $0x1c,%esp
  8021f0:	5b                   	pop    %ebx
  8021f1:	5e                   	pop    %esi
  8021f2:	5f                   	pop    %edi
  8021f3:	5d                   	pop    %ebp
  8021f4:	c3                   	ret    
  8021f5:	8d 76 00             	lea    0x0(%esi),%esi
  8021f8:	2b 04 24             	sub    (%esp),%eax
  8021fb:	19 fa                	sbb    %edi,%edx
  8021fd:	89 d1                	mov    %edx,%ecx
  8021ff:	89 c6                	mov    %eax,%esi
  802201:	e9 71 ff ff ff       	jmp    802177 <__umoddi3+0xb3>
  802206:	66 90                	xchg   %ax,%ax
  802208:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80220c:	72 ea                	jb     8021f8 <__umoddi3+0x134>
  80220e:	89 d9                	mov    %ebx,%ecx
  802210:	e9 62 ff ff ff       	jmp    802177 <__umoddi3+0xb3>
