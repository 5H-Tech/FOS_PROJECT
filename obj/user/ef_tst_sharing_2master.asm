
obj/user/ef_tst_sharing_2master:     file format elf32-i386


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
  800031:	e8 43 03 00 00       	call   800379 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create the shared variables, initialize them and run slaves
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 34             	sub    $0x34,%esp
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
  800087:	68 e0 21 80 00       	push   $0x8021e0
  80008c:	6a 13                	push   $0x13
  80008e:	68 fc 21 80 00       	push   $0x8021fc
  800093:	e8 26 04 00 00       	call   8004be <_panic>
	}
	uint32 *x, *y, *z ;

	//x: Readonly
	int freeFrames = sys_calculate_free_frames() ;
  800098:	e8 33 19 00 00       	call   8019d0 <sys_calculate_free_frames>
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	x = smalloc("x", 4, 0);
  8000a0:	83 ec 04             	sub    $0x4,%esp
  8000a3:	6a 00                	push   $0x0
  8000a5:	6a 04                	push   $0x4
  8000a7:	68 1a 22 80 00       	push   $0x80221a
  8000ac:	e8 e2 16 00 00       	call   801793 <smalloc>
  8000b1:	83 c4 10             	add    $0x10,%esp
  8000b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
	if (x != (uint32*)USER_HEAP_START) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000b7:	81 7d e8 00 00 00 80 	cmpl   $0x80000000,-0x18(%ebp)
  8000be:	74 14                	je     8000d4 <_main+0x9c>
  8000c0:	83 ec 04             	sub    $0x4,%esp
  8000c3:	68 1c 22 80 00       	push   $0x80221c
  8000c8:	6a 1a                	push   $0x1a
  8000ca:	68 fc 21 80 00       	push   $0x8021fc
  8000cf:	e8 ea 03 00 00       	call   8004be <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage %d %d %d", freeFrames, sys_calculate_free_frames(), freeFrames - sys_calculate_free_frames());
  8000d4:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000d7:	e8 f4 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  8000dc:	29 c3                	sub    %eax,%ebx
  8000de:	89 d8                	mov    %ebx,%eax
  8000e0:	83 f8 04             	cmp    $0x4,%eax
  8000e3:	74 28                	je     80010d <_main+0xd5>
  8000e5:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000e8:	e8 e3 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  8000ed:	29 c3                	sub    %eax,%ebx
  8000ef:	e8 dc 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  8000f4:	83 ec 08             	sub    $0x8,%esp
  8000f7:	53                   	push   %ebx
  8000f8:	50                   	push   %eax
  8000f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000fc:	68 80 22 80 00       	push   $0x802280
  800101:	6a 1b                	push   $0x1b
  800103:	68 fc 21 80 00       	push   $0x8021fc
  800108:	e8 b1 03 00 00       	call   8004be <_panic>

	//y: Readonly
	freeFrames = sys_calculate_free_frames() ;
  80010d:	e8 be 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  800112:	89 45 ec             	mov    %eax,-0x14(%ebp)
	y = smalloc("y", 4, 0);
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	6a 00                	push   $0x0
  80011a:	6a 04                	push   $0x4
  80011c:	68 11 23 80 00       	push   $0x802311
  800121:	e8 6d 16 00 00       	call   801793 <smalloc>
  800126:	83 c4 10             	add    $0x10,%esp
  800129:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (y != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  80012c:	81 7d e4 00 10 00 80 	cmpl   $0x80001000,-0x1c(%ebp)
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 1c 22 80 00       	push   $0x80221c
  80013d:	6a 20                	push   $0x20
  80013f:	68 fc 21 80 00       	push   $0x8021fc
  800144:	e8 75 03 00 00       	call   8004be <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage %d %d %d", freeFrames, sys_calculate_free_frames(), freeFrames - sys_calculate_free_frames());
  800149:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80014c:	e8 7f 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  800151:	29 c3                	sub    %eax,%ebx
  800153:	89 d8                	mov    %ebx,%eax
  800155:	83 f8 03             	cmp    $0x3,%eax
  800158:	74 28                	je     800182 <_main+0x14a>
  80015a:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80015d:	e8 6e 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  800162:	29 c3                	sub    %eax,%ebx
  800164:	e8 67 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  800169:	83 ec 08             	sub    $0x8,%esp
  80016c:	53                   	push   %ebx
  80016d:	50                   	push   %eax
  80016e:	ff 75 ec             	pushl  -0x14(%ebp)
  800171:	68 80 22 80 00       	push   $0x802280
  800176:	6a 21                	push   $0x21
  800178:	68 fc 21 80 00       	push   $0x8021fc
  80017d:	e8 3c 03 00 00       	call   8004be <_panic>

	//z: Writable
	freeFrames = sys_calculate_free_frames() ;
  800182:	e8 49 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  800187:	89 45 ec             	mov    %eax,-0x14(%ebp)
	z = smalloc("z", 4, 1);
  80018a:	83 ec 04             	sub    $0x4,%esp
  80018d:	6a 01                	push   $0x1
  80018f:	6a 04                	push   $0x4
  800191:	68 13 23 80 00       	push   $0x802313
  800196:	e8 f8 15 00 00       	call   801793 <smalloc>
  80019b:	83 c4 10             	add    $0x10,%esp
  80019e:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 2 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8001a1:	81 7d e0 00 20 00 80 	cmpl   $0x80002000,-0x20(%ebp)
  8001a8:	74 14                	je     8001be <_main+0x186>
  8001aa:	83 ec 04             	sub    $0x4,%esp
  8001ad:	68 1c 22 80 00       	push   $0x80221c
  8001b2:	6a 26                	push   $0x26
  8001b4:	68 fc 21 80 00       	push   $0x8021fc
  8001b9:	e8 00 03 00 00       	call   8004be <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8001be:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8001c1:	e8 0a 18 00 00       	call   8019d0 <sys_calculate_free_frames>
  8001c6:	29 c3                	sub    %eax,%ebx
  8001c8:	89 d8                	mov    %ebx,%eax
  8001ca:	83 f8 03             	cmp    $0x3,%eax
  8001cd:	74 14                	je     8001e3 <_main+0x1ab>
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	68 18 23 80 00       	push   $0x802318
  8001d7:	6a 27                	push   $0x27
  8001d9:	68 fc 21 80 00       	push   $0x8021fc
  8001de:	e8 db 02 00 00       	call   8004be <_panic>

	*x = 10 ;
  8001e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e6:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
	*y = 20 ;
  8001ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001ef:	c7 00 14 00 00 00    	movl   $0x14,(%eax)

	int id1, id2, id3;
	id1 = sys_create_env("ef_shr2Slave1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8001f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fa:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800200:	89 c2                	mov    %eax,%edx
  800202:	a1 20 30 80 00       	mov    0x803020,%eax
  800207:	8b 40 74             	mov    0x74(%eax),%eax
  80020a:	6a 32                	push   $0x32
  80020c:	52                   	push   %edx
  80020d:	50                   	push   %eax
  80020e:	68 a0 23 80 00       	push   $0x8023a0
  800213:	e8 0d 1a 00 00       	call   801c25 <sys_create_env>
  800218:	83 c4 10             	add    $0x10,%esp
  80021b:	89 45 dc             	mov    %eax,-0x24(%ebp)
	id2 = sys_create_env("ef_shr2Slave1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  80021e:	a1 20 30 80 00       	mov    0x803020,%eax
  800223:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800229:	89 c2                	mov    %eax,%edx
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 40 74             	mov    0x74(%eax),%eax
  800233:	6a 32                	push   $0x32
  800235:	52                   	push   %edx
  800236:	50                   	push   %eax
  800237:	68 a0 23 80 00       	push   $0x8023a0
  80023c:	e8 e4 19 00 00       	call   801c25 <sys_create_env>
  800241:	83 c4 10             	add    $0x10,%esp
  800244:	89 45 d8             	mov    %eax,-0x28(%ebp)
	id3 = sys_create_env("ef_shr2Slave1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  800247:	a1 20 30 80 00       	mov    0x803020,%eax
  80024c:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800252:	89 c2                	mov    %eax,%edx
  800254:	a1 20 30 80 00       	mov    0x803020,%eax
  800259:	8b 40 74             	mov    0x74(%eax),%eax
  80025c:	6a 32                	push   $0x32
  80025e:	52                   	push   %edx
  80025f:	50                   	push   %eax
  800260:	68 a0 23 80 00       	push   $0x8023a0
  800265:	e8 bb 19 00 00       	call   801c25 <sys_create_env>
  80026a:	83 c4 10             	add    $0x10,%esp
  80026d:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//to check that the slave environments completed successfully
	rsttst();
  800270:	e8 98 1a 00 00       	call   801d0d <rsttst>

	int* finish_children = smalloc("finish_children", sizeof(int), 1);
  800275:	83 ec 04             	sub    $0x4,%esp
  800278:	6a 01                	push   $0x1
  80027a:	6a 04                	push   $0x4
  80027c:	68 ae 23 80 00       	push   $0x8023ae
  800281:	e8 0d 15 00 00       	call   801793 <smalloc>
  800286:	83 c4 10             	add    $0x10,%esp
  800289:	89 45 d0             	mov    %eax,-0x30(%ebp)

	sys_run_env(id1);
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	ff 75 dc             	pushl  -0x24(%ebp)
  800292:	e8 ac 19 00 00       	call   801c43 <sys_run_env>
  800297:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	ff 75 d8             	pushl  -0x28(%ebp)
  8002a0:	e8 9e 19 00 00       	call   801c43 <sys_run_env>
  8002a5:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  8002a8:	83 ec 0c             	sub    $0xc,%esp
  8002ab:	ff 75 d4             	pushl  -0x2c(%ebp)
  8002ae:	e8 90 19 00 00       	call   801c43 <sys_run_env>
  8002b3:	83 c4 10             	add    $0x10,%esp

	env_sleep(15000) ;
  8002b6:	83 ec 0c             	sub    $0xc,%esp
  8002b9:	68 98 3a 00 00       	push   $0x3a98
  8002be:	e8 fe 1b 00 00       	call   801ec1 <env_sleep>
  8002c3:	83 c4 10             	add    $0x10,%esp

	//to ensure that the slave environments completed successfully
	if (gettst()!=3) panic("test failed");
  8002c6:	e8 bc 1a 00 00       	call   801d87 <gettst>
  8002cb:	83 f8 03             	cmp    $0x3,%eax
  8002ce:	74 14                	je     8002e4 <_main+0x2ac>
  8002d0:	83 ec 04             	sub    $0x4,%esp
  8002d3:	68 be 23 80 00       	push   $0x8023be
  8002d8:	6a 3d                	push   $0x3d
  8002da:	68 fc 21 80 00       	push   $0x8021fc
  8002df:	e8 da 01 00 00       	call   8004be <_panic>


	if (*z != 30)
  8002e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e7:	8b 00                	mov    (%eax),%eax
  8002e9:	83 f8 1e             	cmp    $0x1e,%eax
  8002ec:	74 14                	je     800302 <_main+0x2ca>
		panic("Error!! Please check the creation (or the getting) of shared 2variables!!\n\n\n");
  8002ee:	83 ec 04             	sub    $0x4,%esp
  8002f1:	68 cc 23 80 00       	push   $0x8023cc
  8002f6:	6a 41                	push   $0x41
  8002f8:	68 fc 21 80 00       	push   $0x8021fc
  8002fd:	e8 bc 01 00 00       	call   8004be <_panic>
	else
		cprintf("Congratulations!! Test of Shared Variables [Create & Get] [2] completed successfully!!\n\n\n");
  800302:	83 ec 0c             	sub    $0xc,%esp
  800305:	68 1c 24 80 00       	push   $0x80241c
  80030a:	e8 51 04 00 00       	call   800760 <cprintf>
  80030f:	83 c4 10             	add    $0x10,%esp


	if (sys_getparentenvid() > 0) {
  800312:	e8 07 16 00 00       	call   80191e <sys_getparentenvid>
  800317:	85 c0                	test   %eax,%eax
  800319:	7e 58                	jle    800373 <_main+0x33b>
		sys_free_env(id1);
  80031b:	83 ec 0c             	sub    $0xc,%esp
  80031e:	ff 75 dc             	pushl  -0x24(%ebp)
  800321:	e8 39 19 00 00       	call   801c5f <sys_free_env>
  800326:	83 c4 10             	add    $0x10,%esp
		sys_free_env(id2);
  800329:	83 ec 0c             	sub    $0xc,%esp
  80032c:	ff 75 d8             	pushl  -0x28(%ebp)
  80032f:	e8 2b 19 00 00       	call   801c5f <sys_free_env>
  800334:	83 c4 10             	add    $0x10,%esp
		sys_free_env(id3);
  800337:	83 ec 0c             	sub    $0xc,%esp
  80033a:	ff 75 d4             	pushl  -0x2c(%ebp)
  80033d:	e8 1d 19 00 00       	call   801c5f <sys_free_env>
  800342:	83 c4 10             	add    $0x10,%esp
		int *finishedCount = NULL;
  800345:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
		finishedCount = sget(sys_getparentenvid(), "finishedCount") ;
  80034c:	e8 cd 15 00 00       	call   80191e <sys_getparentenvid>
  800351:	83 ec 08             	sub    $0x8,%esp
  800354:	68 76 24 80 00       	push   $0x802476
  800359:	50                   	push   %eax
  80035a:	e8 57 14 00 00       	call   8017b6 <sget>
  80035f:	83 c4 10             	add    $0x10,%esp
  800362:	89 45 cc             	mov    %eax,-0x34(%ebp)
		(*finishedCount)++ ;
  800365:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800368:	8b 00                	mov    (%eax),%eax
  80036a:	8d 50 01             	lea    0x1(%eax),%edx
  80036d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800370:	89 10                	mov    %edx,(%eax)
	}
	return;
  800372:	90                   	nop
  800373:	90                   	nop
}
  800374:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800377:	c9                   	leave  
  800378:	c3                   	ret    

00800379 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800379:	55                   	push   %ebp
  80037a:	89 e5                	mov    %esp,%ebp
  80037c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80037f:	e8 81 15 00 00       	call   801905 <sys_getenvindex>
  800384:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800387:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80038a:	89 d0                	mov    %edx,%eax
  80038c:	c1 e0 03             	shl    $0x3,%eax
  80038f:	01 d0                	add    %edx,%eax
  800391:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800398:	01 c8                	add    %ecx,%eax
  80039a:	01 c0                	add    %eax,%eax
  80039c:	01 d0                	add    %edx,%eax
  80039e:	01 c0                	add    %eax,%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	89 c2                	mov    %eax,%edx
  8003a4:	c1 e2 05             	shl    $0x5,%edx
  8003a7:	29 c2                	sub    %eax,%edx
  8003a9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8003b0:	89 c2                	mov    %eax,%edx
  8003b2:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8003b8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c2:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003c8:	84 c0                	test   %al,%al
  8003ca:	74 0f                	je     8003db <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d1:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003d6:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003df:	7e 0a                	jle    8003eb <libmain+0x72>
		binaryname = argv[0];
  8003e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e4:	8b 00                	mov    (%eax),%eax
  8003e6:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003eb:	83 ec 08             	sub    $0x8,%esp
  8003ee:	ff 75 0c             	pushl  0xc(%ebp)
  8003f1:	ff 75 08             	pushl  0x8(%ebp)
  8003f4:	e8 3f fc ff ff       	call   800038 <_main>
  8003f9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003fc:	e8 9f 16 00 00       	call   801aa0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800401:	83 ec 0c             	sub    $0xc,%esp
  800404:	68 9c 24 80 00       	push   $0x80249c
  800409:	e8 52 03 00 00       	call   800760 <cprintf>
  80040e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800411:	a1 20 30 80 00       	mov    0x803020,%eax
  800416:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80041c:	a1 20 30 80 00       	mov    0x803020,%eax
  800421:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800427:	83 ec 04             	sub    $0x4,%esp
  80042a:	52                   	push   %edx
  80042b:	50                   	push   %eax
  80042c:	68 c4 24 80 00       	push   $0x8024c4
  800431:	e8 2a 03 00 00       	call   800760 <cprintf>
  800436:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800439:	a1 20 30 80 00       	mov    0x803020,%eax
  80043e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800444:	a1 20 30 80 00       	mov    0x803020,%eax
  800449:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80044f:	83 ec 04             	sub    $0x4,%esp
  800452:	52                   	push   %edx
  800453:	50                   	push   %eax
  800454:	68 ec 24 80 00       	push   $0x8024ec
  800459:	e8 02 03 00 00       	call   800760 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800461:	a1 20 30 80 00       	mov    0x803020,%eax
  800466:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80046c:	83 ec 08             	sub    $0x8,%esp
  80046f:	50                   	push   %eax
  800470:	68 2d 25 80 00       	push   $0x80252d
  800475:	e8 e6 02 00 00       	call   800760 <cprintf>
  80047a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80047d:	83 ec 0c             	sub    $0xc,%esp
  800480:	68 9c 24 80 00       	push   $0x80249c
  800485:	e8 d6 02 00 00       	call   800760 <cprintf>
  80048a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80048d:	e8 28 16 00 00       	call   801aba <sys_enable_interrupt>

	// exit gracefully
	exit();
  800492:	e8 19 00 00 00       	call   8004b0 <exit>
}
  800497:	90                   	nop
  800498:	c9                   	leave  
  800499:	c3                   	ret    

0080049a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80049a:	55                   	push   %ebp
  80049b:	89 e5                	mov    %esp,%ebp
  80049d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004a0:	83 ec 0c             	sub    $0xc,%esp
  8004a3:	6a 00                	push   $0x0
  8004a5:	e8 27 14 00 00       	call   8018d1 <sys_env_destroy>
  8004aa:	83 c4 10             	add    $0x10,%esp
}
  8004ad:	90                   	nop
  8004ae:	c9                   	leave  
  8004af:	c3                   	ret    

008004b0 <exit>:

void
exit(void)
{
  8004b0:	55                   	push   %ebp
  8004b1:	89 e5                	mov    %esp,%ebp
  8004b3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004b6:	e8 7c 14 00 00       	call   801937 <sys_env_exit>
}
  8004bb:	90                   	nop
  8004bc:	c9                   	leave  
  8004bd:	c3                   	ret    

008004be <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004be:	55                   	push   %ebp
  8004bf:	89 e5                	mov    %esp,%ebp
  8004c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004c4:	8d 45 10             	lea    0x10(%ebp),%eax
  8004c7:	83 c0 04             	add    $0x4,%eax
  8004ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004cd:	a1 18 31 80 00       	mov    0x803118,%eax
  8004d2:	85 c0                	test   %eax,%eax
  8004d4:	74 16                	je     8004ec <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004d6:	a1 18 31 80 00       	mov    0x803118,%eax
  8004db:	83 ec 08             	sub    $0x8,%esp
  8004de:	50                   	push   %eax
  8004df:	68 44 25 80 00       	push   $0x802544
  8004e4:	e8 77 02 00 00       	call   800760 <cprintf>
  8004e9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004ec:	a1 00 30 80 00       	mov    0x803000,%eax
  8004f1:	ff 75 0c             	pushl  0xc(%ebp)
  8004f4:	ff 75 08             	pushl  0x8(%ebp)
  8004f7:	50                   	push   %eax
  8004f8:	68 49 25 80 00       	push   $0x802549
  8004fd:	e8 5e 02 00 00       	call   800760 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800505:	8b 45 10             	mov    0x10(%ebp),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	ff 75 f4             	pushl  -0xc(%ebp)
  80050e:	50                   	push   %eax
  80050f:	e8 e1 01 00 00       	call   8006f5 <vcprintf>
  800514:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800517:	83 ec 08             	sub    $0x8,%esp
  80051a:	6a 00                	push   $0x0
  80051c:	68 65 25 80 00       	push   $0x802565
  800521:	e8 cf 01 00 00       	call   8006f5 <vcprintf>
  800526:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800529:	e8 82 ff ff ff       	call   8004b0 <exit>

	// should not return here
	while (1) ;
  80052e:	eb fe                	jmp    80052e <_panic+0x70>

00800530 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800530:	55                   	push   %ebp
  800531:	89 e5                	mov    %esp,%ebp
  800533:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800536:	a1 20 30 80 00       	mov    0x803020,%eax
  80053b:	8b 50 74             	mov    0x74(%eax),%edx
  80053e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800541:	39 c2                	cmp    %eax,%edx
  800543:	74 14                	je     800559 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800545:	83 ec 04             	sub    $0x4,%esp
  800548:	68 68 25 80 00       	push   $0x802568
  80054d:	6a 26                	push   $0x26
  80054f:	68 b4 25 80 00       	push   $0x8025b4
  800554:	e8 65 ff ff ff       	call   8004be <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800559:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800560:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800567:	e9 b6 00 00 00       	jmp    800622 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80056c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80056f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800576:	8b 45 08             	mov    0x8(%ebp),%eax
  800579:	01 d0                	add    %edx,%eax
  80057b:	8b 00                	mov    (%eax),%eax
  80057d:	85 c0                	test   %eax,%eax
  80057f:	75 08                	jne    800589 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800581:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800584:	e9 96 00 00 00       	jmp    80061f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800589:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800590:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800597:	eb 5d                	jmp    8005f6 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800599:	a1 20 30 80 00       	mov    0x803020,%eax
  80059e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005a4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005a7:	c1 e2 04             	shl    $0x4,%edx
  8005aa:	01 d0                	add    %edx,%eax
  8005ac:	8a 40 04             	mov    0x4(%eax),%al
  8005af:	84 c0                	test   %al,%al
  8005b1:	75 40                	jne    8005f3 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005c1:	c1 e2 04             	shl    $0x4,%edx
  8005c4:	01 d0                	add    %edx,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	01 c8                	add    %ecx,%eax
  8005e4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005e6:	39 c2                	cmp    %eax,%edx
  8005e8:	75 09                	jne    8005f3 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005ea:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005f1:	eb 12                	jmp    800605 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f3:	ff 45 e8             	incl   -0x18(%ebp)
  8005f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fb:	8b 50 74             	mov    0x74(%eax),%edx
  8005fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800601:	39 c2                	cmp    %eax,%edx
  800603:	77 94                	ja     800599 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800605:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800609:	75 14                	jne    80061f <CheckWSWithoutLastIndex+0xef>
			panic(
  80060b:	83 ec 04             	sub    $0x4,%esp
  80060e:	68 c0 25 80 00       	push   $0x8025c0
  800613:	6a 3a                	push   $0x3a
  800615:	68 b4 25 80 00       	push   $0x8025b4
  80061a:	e8 9f fe ff ff       	call   8004be <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80061f:	ff 45 f0             	incl   -0x10(%ebp)
  800622:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800625:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800628:	0f 8c 3e ff ff ff    	jl     80056c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80062e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800635:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063c:	eb 20                	jmp    80065e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80063e:	a1 20 30 80 00       	mov    0x803020,%eax
  800643:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800649:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064c:	c1 e2 04             	shl    $0x4,%edx
  80064f:	01 d0                	add    %edx,%eax
  800651:	8a 40 04             	mov    0x4(%eax),%al
  800654:	3c 01                	cmp    $0x1,%al
  800656:	75 03                	jne    80065b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800658:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80065b:	ff 45 e0             	incl   -0x20(%ebp)
  80065e:	a1 20 30 80 00       	mov    0x803020,%eax
  800663:	8b 50 74             	mov    0x74(%eax),%edx
  800666:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800669:	39 c2                	cmp    %eax,%edx
  80066b:	77 d1                	ja     80063e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80066d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800670:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800673:	74 14                	je     800689 <CheckWSWithoutLastIndex+0x159>
		panic(
  800675:	83 ec 04             	sub    $0x4,%esp
  800678:	68 14 26 80 00       	push   $0x802614
  80067d:	6a 44                	push   $0x44
  80067f:	68 b4 25 80 00       	push   $0x8025b4
  800684:	e8 35 fe ff ff       	call   8004be <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800689:	90                   	nop
  80068a:	c9                   	leave  
  80068b:	c3                   	ret    

0080068c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80068c:	55                   	push   %ebp
  80068d:	89 e5                	mov    %esp,%ebp
  80068f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800692:	8b 45 0c             	mov    0xc(%ebp),%eax
  800695:	8b 00                	mov    (%eax),%eax
  800697:	8d 48 01             	lea    0x1(%eax),%ecx
  80069a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80069d:	89 0a                	mov    %ecx,(%edx)
  80069f:	8b 55 08             	mov    0x8(%ebp),%edx
  8006a2:	88 d1                	mov    %dl,%cl
  8006a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ae:	8b 00                	mov    (%eax),%eax
  8006b0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006b5:	75 2c                	jne    8006e3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006b7:	a0 24 30 80 00       	mov    0x803024,%al
  8006bc:	0f b6 c0             	movzbl %al,%eax
  8006bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c2:	8b 12                	mov    (%edx),%edx
  8006c4:	89 d1                	mov    %edx,%ecx
  8006c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c9:	83 c2 08             	add    $0x8,%edx
  8006cc:	83 ec 04             	sub    $0x4,%esp
  8006cf:	50                   	push   %eax
  8006d0:	51                   	push   %ecx
  8006d1:	52                   	push   %edx
  8006d2:	e8 b8 11 00 00       	call   80188f <sys_cputs>
  8006d7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e6:	8b 40 04             	mov    0x4(%eax),%eax
  8006e9:	8d 50 01             	lea    0x1(%eax),%edx
  8006ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ef:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006f2:	90                   	nop
  8006f3:	c9                   	leave  
  8006f4:	c3                   	ret    

008006f5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006f5:	55                   	push   %ebp
  8006f6:	89 e5                	mov    %esp,%ebp
  8006f8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800705:	00 00 00 
	b.cnt = 0;
  800708:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80070f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800712:	ff 75 0c             	pushl  0xc(%ebp)
  800715:	ff 75 08             	pushl  0x8(%ebp)
  800718:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80071e:	50                   	push   %eax
  80071f:	68 8c 06 80 00       	push   $0x80068c
  800724:	e8 11 02 00 00       	call   80093a <vprintfmt>
  800729:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80072c:	a0 24 30 80 00       	mov    0x803024,%al
  800731:	0f b6 c0             	movzbl %al,%eax
  800734:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80073a:	83 ec 04             	sub    $0x4,%esp
  80073d:	50                   	push   %eax
  80073e:	52                   	push   %edx
  80073f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800745:	83 c0 08             	add    $0x8,%eax
  800748:	50                   	push   %eax
  800749:	e8 41 11 00 00       	call   80188f <sys_cputs>
  80074e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800751:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800758:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80075e:	c9                   	leave  
  80075f:	c3                   	ret    

00800760 <cprintf>:

int cprintf(const char *fmt, ...) {
  800760:	55                   	push   %ebp
  800761:	89 e5                	mov    %esp,%ebp
  800763:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800766:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80076d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800770:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	ff 75 f4             	pushl  -0xc(%ebp)
  80077c:	50                   	push   %eax
  80077d:	e8 73 ff ff ff       	call   8006f5 <vcprintf>
  800782:	83 c4 10             	add    $0x10,%esp
  800785:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800788:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80078b:	c9                   	leave  
  80078c:	c3                   	ret    

0080078d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80078d:	55                   	push   %ebp
  80078e:	89 e5                	mov    %esp,%ebp
  800790:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800793:	e8 08 13 00 00       	call   801aa0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800798:	8d 45 0c             	lea    0xc(%ebp),%eax
  80079b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a7:	50                   	push   %eax
  8007a8:	e8 48 ff ff ff       	call   8006f5 <vcprintf>
  8007ad:	83 c4 10             	add    $0x10,%esp
  8007b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007b3:	e8 02 13 00 00       	call   801aba <sys_enable_interrupt>
	return cnt;
  8007b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007bb:	c9                   	leave  
  8007bc:	c3                   	ret    

008007bd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007bd:	55                   	push   %ebp
  8007be:	89 e5                	mov    %esp,%ebp
  8007c0:	53                   	push   %ebx
  8007c1:	83 ec 14             	sub    $0x14,%esp
  8007c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8007d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007db:	77 55                	ja     800832 <printnum+0x75>
  8007dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007e0:	72 05                	jb     8007e7 <printnum+0x2a>
  8007e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007e5:	77 4b                	ja     800832 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007e7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007ea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8007f5:	52                   	push   %edx
  8007f6:	50                   	push   %eax
  8007f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8007fd:	e8 76 17 00 00       	call   801f78 <__udivdi3>
  800802:	83 c4 10             	add    $0x10,%esp
  800805:	83 ec 04             	sub    $0x4,%esp
  800808:	ff 75 20             	pushl  0x20(%ebp)
  80080b:	53                   	push   %ebx
  80080c:	ff 75 18             	pushl  0x18(%ebp)
  80080f:	52                   	push   %edx
  800810:	50                   	push   %eax
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	ff 75 08             	pushl  0x8(%ebp)
  800817:	e8 a1 ff ff ff       	call   8007bd <printnum>
  80081c:	83 c4 20             	add    $0x20,%esp
  80081f:	eb 1a                	jmp    80083b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	ff 75 20             	pushl  0x20(%ebp)
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	ff d0                	call   *%eax
  80082f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800832:	ff 4d 1c             	decl   0x1c(%ebp)
  800835:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800839:	7f e6                	jg     800821 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80083b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80083e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800843:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800846:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800849:	53                   	push   %ebx
  80084a:	51                   	push   %ecx
  80084b:	52                   	push   %edx
  80084c:	50                   	push   %eax
  80084d:	e8 36 18 00 00       	call   802088 <__umoddi3>
  800852:	83 c4 10             	add    $0x10,%esp
  800855:	05 74 28 80 00       	add    $0x802874,%eax
  80085a:	8a 00                	mov    (%eax),%al
  80085c:	0f be c0             	movsbl %al,%eax
  80085f:	83 ec 08             	sub    $0x8,%esp
  800862:	ff 75 0c             	pushl  0xc(%ebp)
  800865:	50                   	push   %eax
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	ff d0                	call   *%eax
  80086b:	83 c4 10             	add    $0x10,%esp
}
  80086e:	90                   	nop
  80086f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800872:	c9                   	leave  
  800873:	c3                   	ret    

00800874 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800874:	55                   	push   %ebp
  800875:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800877:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80087b:	7e 1c                	jle    800899 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	8d 50 08             	lea    0x8(%eax),%edx
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	89 10                	mov    %edx,(%eax)
  80088a:	8b 45 08             	mov    0x8(%ebp),%eax
  80088d:	8b 00                	mov    (%eax),%eax
  80088f:	83 e8 08             	sub    $0x8,%eax
  800892:	8b 50 04             	mov    0x4(%eax),%edx
  800895:	8b 00                	mov    (%eax),%eax
  800897:	eb 40                	jmp    8008d9 <getuint+0x65>
	else if (lflag)
  800899:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80089d:	74 1e                	je     8008bd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80089f:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a2:	8b 00                	mov    (%eax),%eax
  8008a4:	8d 50 04             	lea    0x4(%eax),%edx
  8008a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008aa:	89 10                	mov    %edx,(%eax)
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	8b 00                	mov    (%eax),%eax
  8008b1:	83 e8 04             	sub    $0x4,%eax
  8008b4:	8b 00                	mov    (%eax),%eax
  8008b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8008bb:	eb 1c                	jmp    8008d9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	8b 00                	mov    (%eax),%eax
  8008c2:	8d 50 04             	lea    0x4(%eax),%edx
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	89 10                	mov    %edx,(%eax)
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	83 e8 04             	sub    $0x4,%eax
  8008d2:	8b 00                	mov    (%eax),%eax
  8008d4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008d9:	5d                   	pop    %ebp
  8008da:	c3                   	ret    

008008db <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e2:	7e 1c                	jle    800900 <getint+0x25>
		return va_arg(*ap, long long);
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	8d 50 08             	lea    0x8(%eax),%edx
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	89 10                	mov    %edx,(%eax)
  8008f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f4:	8b 00                	mov    (%eax),%eax
  8008f6:	83 e8 08             	sub    $0x8,%eax
  8008f9:	8b 50 04             	mov    0x4(%eax),%edx
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	eb 38                	jmp    800938 <getint+0x5d>
	else if (lflag)
  800900:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800904:	74 1a                	je     800920 <getint+0x45>
		return va_arg(*ap, long);
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	8b 00                	mov    (%eax),%eax
  80090b:	8d 50 04             	lea    0x4(%eax),%edx
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	89 10                	mov    %edx,(%eax)
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	8b 00                	mov    (%eax),%eax
  800918:	83 e8 04             	sub    $0x4,%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	99                   	cltd   
  80091e:	eb 18                	jmp    800938 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	8b 00                	mov    (%eax),%eax
  800925:	8d 50 04             	lea    0x4(%eax),%edx
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	89 10                	mov    %edx,(%eax)
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	8b 00                	mov    (%eax),%eax
  800932:	83 e8 04             	sub    $0x4,%eax
  800935:	8b 00                	mov    (%eax),%eax
  800937:	99                   	cltd   
}
  800938:	5d                   	pop    %ebp
  800939:	c3                   	ret    

0080093a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80093a:	55                   	push   %ebp
  80093b:	89 e5                	mov    %esp,%ebp
  80093d:	56                   	push   %esi
  80093e:	53                   	push   %ebx
  80093f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800942:	eb 17                	jmp    80095b <vprintfmt+0x21>
			if (ch == '\0')
  800944:	85 db                	test   %ebx,%ebx
  800946:	0f 84 af 03 00 00    	je     800cfb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80094c:	83 ec 08             	sub    $0x8,%esp
  80094f:	ff 75 0c             	pushl  0xc(%ebp)
  800952:	53                   	push   %ebx
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	ff d0                	call   *%eax
  800958:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80095b:	8b 45 10             	mov    0x10(%ebp),%eax
  80095e:	8d 50 01             	lea    0x1(%eax),%edx
  800961:	89 55 10             	mov    %edx,0x10(%ebp)
  800964:	8a 00                	mov    (%eax),%al
  800966:	0f b6 d8             	movzbl %al,%ebx
  800969:	83 fb 25             	cmp    $0x25,%ebx
  80096c:	75 d6                	jne    800944 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80096e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800972:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800979:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800980:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800987:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80098e:	8b 45 10             	mov    0x10(%ebp),%eax
  800991:	8d 50 01             	lea    0x1(%eax),%edx
  800994:	89 55 10             	mov    %edx,0x10(%ebp)
  800997:	8a 00                	mov    (%eax),%al
  800999:	0f b6 d8             	movzbl %al,%ebx
  80099c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80099f:	83 f8 55             	cmp    $0x55,%eax
  8009a2:	0f 87 2b 03 00 00    	ja     800cd3 <vprintfmt+0x399>
  8009a8:	8b 04 85 98 28 80 00 	mov    0x802898(,%eax,4),%eax
  8009af:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009b1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009b5:	eb d7                	jmp    80098e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009b7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009bb:	eb d1                	jmp    80098e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009bd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c7:	89 d0                	mov    %edx,%eax
  8009c9:	c1 e0 02             	shl    $0x2,%eax
  8009cc:	01 d0                	add    %edx,%eax
  8009ce:	01 c0                	add    %eax,%eax
  8009d0:	01 d8                	add    %ebx,%eax
  8009d2:	83 e8 30             	sub    $0x30,%eax
  8009d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009db:	8a 00                	mov    (%eax),%al
  8009dd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009e0:	83 fb 2f             	cmp    $0x2f,%ebx
  8009e3:	7e 3e                	jle    800a23 <vprintfmt+0xe9>
  8009e5:	83 fb 39             	cmp    $0x39,%ebx
  8009e8:	7f 39                	jg     800a23 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009ea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009ed:	eb d5                	jmp    8009c4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f2:	83 c0 04             	add    $0x4,%eax
  8009f5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fb:	83 e8 04             	sub    $0x4,%eax
  8009fe:	8b 00                	mov    (%eax),%eax
  800a00:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a03:	eb 1f                	jmp    800a24 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a09:	79 83                	jns    80098e <vprintfmt+0x54>
				width = 0;
  800a0b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a12:	e9 77 ff ff ff       	jmp    80098e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a17:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a1e:	e9 6b ff ff ff       	jmp    80098e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a23:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a28:	0f 89 60 ff ff ff    	jns    80098e <vprintfmt+0x54>
				width = precision, precision = -1;
  800a2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a34:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a3b:	e9 4e ff ff ff       	jmp    80098e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a40:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a43:	e9 46 ff ff ff       	jmp    80098e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a48:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4b:	83 c0 04             	add    $0x4,%eax
  800a4e:	89 45 14             	mov    %eax,0x14(%ebp)
  800a51:	8b 45 14             	mov    0x14(%ebp),%eax
  800a54:	83 e8 04             	sub    $0x4,%eax
  800a57:	8b 00                	mov    (%eax),%eax
  800a59:	83 ec 08             	sub    $0x8,%esp
  800a5c:	ff 75 0c             	pushl  0xc(%ebp)
  800a5f:	50                   	push   %eax
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	ff d0                	call   *%eax
  800a65:	83 c4 10             	add    $0x10,%esp
			break;
  800a68:	e9 89 02 00 00       	jmp    800cf6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a70:	83 c0 04             	add    $0x4,%eax
  800a73:	89 45 14             	mov    %eax,0x14(%ebp)
  800a76:	8b 45 14             	mov    0x14(%ebp),%eax
  800a79:	83 e8 04             	sub    $0x4,%eax
  800a7c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a7e:	85 db                	test   %ebx,%ebx
  800a80:	79 02                	jns    800a84 <vprintfmt+0x14a>
				err = -err;
  800a82:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a84:	83 fb 64             	cmp    $0x64,%ebx
  800a87:	7f 0b                	jg     800a94 <vprintfmt+0x15a>
  800a89:	8b 34 9d e0 26 80 00 	mov    0x8026e0(,%ebx,4),%esi
  800a90:	85 f6                	test   %esi,%esi
  800a92:	75 19                	jne    800aad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a94:	53                   	push   %ebx
  800a95:	68 85 28 80 00       	push   $0x802885
  800a9a:	ff 75 0c             	pushl  0xc(%ebp)
  800a9d:	ff 75 08             	pushl  0x8(%ebp)
  800aa0:	e8 5e 02 00 00       	call   800d03 <printfmt>
  800aa5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800aa8:	e9 49 02 00 00       	jmp    800cf6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800aad:	56                   	push   %esi
  800aae:	68 8e 28 80 00       	push   $0x80288e
  800ab3:	ff 75 0c             	pushl  0xc(%ebp)
  800ab6:	ff 75 08             	pushl  0x8(%ebp)
  800ab9:	e8 45 02 00 00       	call   800d03 <printfmt>
  800abe:	83 c4 10             	add    $0x10,%esp
			break;
  800ac1:	e9 30 02 00 00       	jmp    800cf6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ac6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac9:	83 c0 04             	add    $0x4,%eax
  800acc:	89 45 14             	mov    %eax,0x14(%ebp)
  800acf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad2:	83 e8 04             	sub    $0x4,%eax
  800ad5:	8b 30                	mov    (%eax),%esi
  800ad7:	85 f6                	test   %esi,%esi
  800ad9:	75 05                	jne    800ae0 <vprintfmt+0x1a6>
				p = "(null)";
  800adb:	be 91 28 80 00       	mov    $0x802891,%esi
			if (width > 0 && padc != '-')
  800ae0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ae4:	7e 6d                	jle    800b53 <vprintfmt+0x219>
  800ae6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800aea:	74 67                	je     800b53 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	50                   	push   %eax
  800af3:	56                   	push   %esi
  800af4:	e8 0c 03 00 00       	call   800e05 <strnlen>
  800af9:	83 c4 10             	add    $0x10,%esp
  800afc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800aff:	eb 16                	jmp    800b17 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b01:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	50                   	push   %eax
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	ff d0                	call   *%eax
  800b11:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b14:	ff 4d e4             	decl   -0x1c(%ebp)
  800b17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b1b:	7f e4                	jg     800b01 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b1d:	eb 34                	jmp    800b53 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b1f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b23:	74 1c                	je     800b41 <vprintfmt+0x207>
  800b25:	83 fb 1f             	cmp    $0x1f,%ebx
  800b28:	7e 05                	jle    800b2f <vprintfmt+0x1f5>
  800b2a:	83 fb 7e             	cmp    $0x7e,%ebx
  800b2d:	7e 12                	jle    800b41 <vprintfmt+0x207>
					putch('?', putdat);
  800b2f:	83 ec 08             	sub    $0x8,%esp
  800b32:	ff 75 0c             	pushl  0xc(%ebp)
  800b35:	6a 3f                	push   $0x3f
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	ff d0                	call   *%eax
  800b3c:	83 c4 10             	add    $0x10,%esp
  800b3f:	eb 0f                	jmp    800b50 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	53                   	push   %ebx
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	ff d0                	call   *%eax
  800b4d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b50:	ff 4d e4             	decl   -0x1c(%ebp)
  800b53:	89 f0                	mov    %esi,%eax
  800b55:	8d 70 01             	lea    0x1(%eax),%esi
  800b58:	8a 00                	mov    (%eax),%al
  800b5a:	0f be d8             	movsbl %al,%ebx
  800b5d:	85 db                	test   %ebx,%ebx
  800b5f:	74 24                	je     800b85 <vprintfmt+0x24b>
  800b61:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b65:	78 b8                	js     800b1f <vprintfmt+0x1e5>
  800b67:	ff 4d e0             	decl   -0x20(%ebp)
  800b6a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b6e:	79 af                	jns    800b1f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b70:	eb 13                	jmp    800b85 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b72:	83 ec 08             	sub    $0x8,%esp
  800b75:	ff 75 0c             	pushl  0xc(%ebp)
  800b78:	6a 20                	push   $0x20
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	ff d0                	call   *%eax
  800b7f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b82:	ff 4d e4             	decl   -0x1c(%ebp)
  800b85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b89:	7f e7                	jg     800b72 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b8b:	e9 66 01 00 00       	jmp    800cf6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b90:	83 ec 08             	sub    $0x8,%esp
  800b93:	ff 75 e8             	pushl  -0x18(%ebp)
  800b96:	8d 45 14             	lea    0x14(%ebp),%eax
  800b99:	50                   	push   %eax
  800b9a:	e8 3c fd ff ff       	call   8008db <getint>
  800b9f:	83 c4 10             	add    $0x10,%esp
  800ba2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bae:	85 d2                	test   %edx,%edx
  800bb0:	79 23                	jns    800bd5 <vprintfmt+0x29b>
				putch('-', putdat);
  800bb2:	83 ec 08             	sub    $0x8,%esp
  800bb5:	ff 75 0c             	pushl  0xc(%ebp)
  800bb8:	6a 2d                	push   $0x2d
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	ff d0                	call   *%eax
  800bbf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc8:	f7 d8                	neg    %eax
  800bca:	83 d2 00             	adc    $0x0,%edx
  800bcd:	f7 da                	neg    %edx
  800bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bd5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bdc:	e9 bc 00 00 00       	jmp    800c9d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800be1:	83 ec 08             	sub    $0x8,%esp
  800be4:	ff 75 e8             	pushl  -0x18(%ebp)
  800be7:	8d 45 14             	lea    0x14(%ebp),%eax
  800bea:	50                   	push   %eax
  800beb:	e8 84 fc ff ff       	call   800874 <getuint>
  800bf0:	83 c4 10             	add    $0x10,%esp
  800bf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bf9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c00:	e9 98 00 00 00       	jmp    800c9d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c05:	83 ec 08             	sub    $0x8,%esp
  800c08:	ff 75 0c             	pushl  0xc(%ebp)
  800c0b:	6a 58                	push   $0x58
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	ff d0                	call   *%eax
  800c12:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c15:	83 ec 08             	sub    $0x8,%esp
  800c18:	ff 75 0c             	pushl  0xc(%ebp)
  800c1b:	6a 58                	push   $0x58
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	ff d0                	call   *%eax
  800c22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c25:	83 ec 08             	sub    $0x8,%esp
  800c28:	ff 75 0c             	pushl  0xc(%ebp)
  800c2b:	6a 58                	push   $0x58
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	ff d0                	call   *%eax
  800c32:	83 c4 10             	add    $0x10,%esp
			break;
  800c35:	e9 bc 00 00 00       	jmp    800cf6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c3a:	83 ec 08             	sub    $0x8,%esp
  800c3d:	ff 75 0c             	pushl  0xc(%ebp)
  800c40:	6a 30                	push   $0x30
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	ff d0                	call   *%eax
  800c47:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 0c             	pushl  0xc(%ebp)
  800c50:	6a 78                	push   $0x78
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5d:	83 c0 04             	add    $0x4,%eax
  800c60:	89 45 14             	mov    %eax,0x14(%ebp)
  800c63:	8b 45 14             	mov    0x14(%ebp),%eax
  800c66:	83 e8 04             	sub    $0x4,%eax
  800c69:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c7c:	eb 1f                	jmp    800c9d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c7e:	83 ec 08             	sub    $0x8,%esp
  800c81:	ff 75 e8             	pushl  -0x18(%ebp)
  800c84:	8d 45 14             	lea    0x14(%ebp),%eax
  800c87:	50                   	push   %eax
  800c88:	e8 e7 fb ff ff       	call   800874 <getuint>
  800c8d:	83 c4 10             	add    $0x10,%esp
  800c90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c93:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c96:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c9d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ca1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ca4:	83 ec 04             	sub    $0x4,%esp
  800ca7:	52                   	push   %edx
  800ca8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cab:	50                   	push   %eax
  800cac:	ff 75 f4             	pushl  -0xc(%ebp)
  800caf:	ff 75 f0             	pushl  -0x10(%ebp)
  800cb2:	ff 75 0c             	pushl  0xc(%ebp)
  800cb5:	ff 75 08             	pushl  0x8(%ebp)
  800cb8:	e8 00 fb ff ff       	call   8007bd <printnum>
  800cbd:	83 c4 20             	add    $0x20,%esp
			break;
  800cc0:	eb 34                	jmp    800cf6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cc2:	83 ec 08             	sub    $0x8,%esp
  800cc5:	ff 75 0c             	pushl  0xc(%ebp)
  800cc8:	53                   	push   %ebx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	ff d0                	call   *%eax
  800cce:	83 c4 10             	add    $0x10,%esp
			break;
  800cd1:	eb 23                	jmp    800cf6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cd3:	83 ec 08             	sub    $0x8,%esp
  800cd6:	ff 75 0c             	pushl  0xc(%ebp)
  800cd9:	6a 25                	push   $0x25
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	ff d0                	call   *%eax
  800ce0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ce3:	ff 4d 10             	decl   0x10(%ebp)
  800ce6:	eb 03                	jmp    800ceb <vprintfmt+0x3b1>
  800ce8:	ff 4d 10             	decl   0x10(%ebp)
  800ceb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cee:	48                   	dec    %eax
  800cef:	8a 00                	mov    (%eax),%al
  800cf1:	3c 25                	cmp    $0x25,%al
  800cf3:	75 f3                	jne    800ce8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cf5:	90                   	nop
		}
	}
  800cf6:	e9 47 fc ff ff       	jmp    800942 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cfb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cfc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cff:	5b                   	pop    %ebx
  800d00:	5e                   	pop    %esi
  800d01:	5d                   	pop    %ebp
  800d02:	c3                   	ret    

00800d03 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
  800d06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d09:	8d 45 10             	lea    0x10(%ebp),%eax
  800d0c:	83 c0 04             	add    $0x4,%eax
  800d0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d12:	8b 45 10             	mov    0x10(%ebp),%eax
  800d15:	ff 75 f4             	pushl  -0xc(%ebp)
  800d18:	50                   	push   %eax
  800d19:	ff 75 0c             	pushl  0xc(%ebp)
  800d1c:	ff 75 08             	pushl  0x8(%ebp)
  800d1f:	e8 16 fc ff ff       	call   80093a <vprintfmt>
  800d24:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d27:	90                   	nop
  800d28:	c9                   	leave  
  800d29:	c3                   	ret    

00800d2a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d2a:	55                   	push   %ebp
  800d2b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d30:	8b 40 08             	mov    0x8(%eax),%eax
  800d33:	8d 50 01             	lea    0x1(%eax),%edx
  800d36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d39:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3f:	8b 10                	mov    (%eax),%edx
  800d41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d44:	8b 40 04             	mov    0x4(%eax),%eax
  800d47:	39 c2                	cmp    %eax,%edx
  800d49:	73 12                	jae    800d5d <sprintputch+0x33>
		*b->buf++ = ch;
  800d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4e:	8b 00                	mov    (%eax),%eax
  800d50:	8d 48 01             	lea    0x1(%eax),%ecx
  800d53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d56:	89 0a                	mov    %ecx,(%edx)
  800d58:	8b 55 08             	mov    0x8(%ebp),%edx
  800d5b:	88 10                	mov    %dl,(%eax)
}
  800d5d:	90                   	nop
  800d5e:	5d                   	pop    %ebp
  800d5f:	c3                   	ret    

00800d60 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d60:	55                   	push   %ebp
  800d61:	89 e5                	mov    %esp,%ebp
  800d63:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	01 d0                	add    %edx,%eax
  800d77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d81:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d85:	74 06                	je     800d8d <vsnprintf+0x2d>
  800d87:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d8b:	7f 07                	jg     800d94 <vsnprintf+0x34>
		return -E_INVAL;
  800d8d:	b8 03 00 00 00       	mov    $0x3,%eax
  800d92:	eb 20                	jmp    800db4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d94:	ff 75 14             	pushl  0x14(%ebp)
  800d97:	ff 75 10             	pushl  0x10(%ebp)
  800d9a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d9d:	50                   	push   %eax
  800d9e:	68 2a 0d 80 00       	push   $0x800d2a
  800da3:	e8 92 fb ff ff       	call   80093a <vprintfmt>
  800da8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800db4:	c9                   	leave  
  800db5:	c3                   	ret    

00800db6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800db6:	55                   	push   %ebp
  800db7:	89 e5                	mov    %esp,%ebp
  800db9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dbc:	8d 45 10             	lea    0x10(%ebp),%eax
  800dbf:	83 c0 04             	add    $0x4,%eax
  800dc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc8:	ff 75 f4             	pushl  -0xc(%ebp)
  800dcb:	50                   	push   %eax
  800dcc:	ff 75 0c             	pushl  0xc(%ebp)
  800dcf:	ff 75 08             	pushl  0x8(%ebp)
  800dd2:	e8 89 ff ff ff       	call   800d60 <vsnprintf>
  800dd7:	83 c4 10             	add    $0x10,%esp
  800dda:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800de0:	c9                   	leave  
  800de1:	c3                   	ret    

00800de2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800de2:	55                   	push   %ebp
  800de3:	89 e5                	mov    %esp,%ebp
  800de5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800de8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800def:	eb 06                	jmp    800df7 <strlen+0x15>
		n++;
  800df1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800df4:	ff 45 08             	incl   0x8(%ebp)
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	84 c0                	test   %al,%al
  800dfe:	75 f1                	jne    800df1 <strlen+0xf>
		n++;
	return n;
  800e00:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e03:	c9                   	leave  
  800e04:	c3                   	ret    

00800e05 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e05:	55                   	push   %ebp
  800e06:	89 e5                	mov    %esp,%ebp
  800e08:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e12:	eb 09                	jmp    800e1d <strnlen+0x18>
		n++;
  800e14:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e17:	ff 45 08             	incl   0x8(%ebp)
  800e1a:	ff 4d 0c             	decl   0xc(%ebp)
  800e1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e21:	74 09                	je     800e2c <strnlen+0x27>
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	8a 00                	mov    (%eax),%al
  800e28:	84 c0                	test   %al,%al
  800e2a:	75 e8                	jne    800e14 <strnlen+0xf>
		n++;
	return n;
  800e2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e2f:	c9                   	leave  
  800e30:	c3                   	ret    

00800e31 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e31:	55                   	push   %ebp
  800e32:	89 e5                	mov    %esp,%ebp
  800e34:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e3d:	90                   	nop
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8d 50 01             	lea    0x1(%eax),%edx
  800e44:	89 55 08             	mov    %edx,0x8(%ebp)
  800e47:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e4a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e4d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e50:	8a 12                	mov    (%edx),%dl
  800e52:	88 10                	mov    %dl,(%eax)
  800e54:	8a 00                	mov    (%eax),%al
  800e56:	84 c0                	test   %al,%al
  800e58:	75 e4                	jne    800e3e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e5d:	c9                   	leave  
  800e5e:	c3                   	ret    

00800e5f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e5f:	55                   	push   %ebp
  800e60:	89 e5                	mov    %esp,%ebp
  800e62:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e72:	eb 1f                	jmp    800e93 <strncpy+0x34>
		*dst++ = *src;
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8d 50 01             	lea    0x1(%eax),%edx
  800e7a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e80:	8a 12                	mov    (%edx),%dl
  800e82:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	8a 00                	mov    (%eax),%al
  800e89:	84 c0                	test   %al,%al
  800e8b:	74 03                	je     800e90 <strncpy+0x31>
			src++;
  800e8d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e90:	ff 45 fc             	incl   -0x4(%ebp)
  800e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e96:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e99:	72 d9                	jb     800e74 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e9e:	c9                   	leave  
  800e9f:	c3                   	ret    

00800ea0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800eac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb0:	74 30                	je     800ee2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eb2:	eb 16                	jmp    800eca <strlcpy+0x2a>
			*dst++ = *src++;
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	8d 50 01             	lea    0x1(%eax),%edx
  800eba:	89 55 08             	mov    %edx,0x8(%ebp)
  800ebd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ec0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ec3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ec6:	8a 12                	mov    (%edx),%dl
  800ec8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800eca:	ff 4d 10             	decl   0x10(%ebp)
  800ecd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed1:	74 09                	je     800edc <strlcpy+0x3c>
  800ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed6:	8a 00                	mov    (%eax),%al
  800ed8:	84 c0                	test   %al,%al
  800eda:	75 d8                	jne    800eb4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ee2:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee8:	29 c2                	sub    %eax,%edx
  800eea:	89 d0                	mov    %edx,%eax
}
  800eec:	c9                   	leave  
  800eed:	c3                   	ret    

00800eee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800eee:	55                   	push   %ebp
  800eef:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ef1:	eb 06                	jmp    800ef9 <strcmp+0xb>
		p++, q++;
  800ef3:	ff 45 08             	incl   0x8(%ebp)
  800ef6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	84 c0                	test   %al,%al
  800f00:	74 0e                	je     800f10 <strcmp+0x22>
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	8a 10                	mov    (%eax),%dl
  800f07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	38 c2                	cmp    %al,%dl
  800f0e:	74 e3                	je     800ef3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	0f b6 d0             	movzbl %al,%edx
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	0f b6 c0             	movzbl %al,%eax
  800f20:	29 c2                	sub    %eax,%edx
  800f22:	89 d0                	mov    %edx,%eax
}
  800f24:	5d                   	pop    %ebp
  800f25:	c3                   	ret    

00800f26 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f26:	55                   	push   %ebp
  800f27:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f29:	eb 09                	jmp    800f34 <strncmp+0xe>
		n--, p++, q++;
  800f2b:	ff 4d 10             	decl   0x10(%ebp)
  800f2e:	ff 45 08             	incl   0x8(%ebp)
  800f31:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f38:	74 17                	je     800f51 <strncmp+0x2b>
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	84 c0                	test   %al,%al
  800f41:	74 0e                	je     800f51 <strncmp+0x2b>
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	8a 10                	mov    (%eax),%dl
  800f48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4b:	8a 00                	mov    (%eax),%al
  800f4d:	38 c2                	cmp    %al,%dl
  800f4f:	74 da                	je     800f2b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f55:	75 07                	jne    800f5e <strncmp+0x38>
		return 0;
  800f57:	b8 00 00 00 00       	mov    $0x0,%eax
  800f5c:	eb 14                	jmp    800f72 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	8a 00                	mov    (%eax),%al
  800f63:	0f b6 d0             	movzbl %al,%edx
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	0f b6 c0             	movzbl %al,%eax
  800f6e:	29 c2                	sub    %eax,%edx
  800f70:	89 d0                	mov    %edx,%eax
}
  800f72:	5d                   	pop    %ebp
  800f73:	c3                   	ret    

00800f74 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f74:	55                   	push   %ebp
  800f75:	89 e5                	mov    %esp,%ebp
  800f77:	83 ec 04             	sub    $0x4,%esp
  800f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f80:	eb 12                	jmp    800f94 <strchr+0x20>
		if (*s == c)
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f8a:	75 05                	jne    800f91 <strchr+0x1d>
			return (char *) s;
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	eb 11                	jmp    800fa2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f91:	ff 45 08             	incl   0x8(%ebp)
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	84 c0                	test   %al,%al
  800f9b:	75 e5                	jne    800f82 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fa2:	c9                   	leave  
  800fa3:	c3                   	ret    

00800fa4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fa4:	55                   	push   %ebp
  800fa5:	89 e5                	mov    %esp,%ebp
  800fa7:	83 ec 04             	sub    $0x4,%esp
  800faa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fb0:	eb 0d                	jmp    800fbf <strfind+0x1b>
		if (*s == c)
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	8a 00                	mov    (%eax),%al
  800fb7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fba:	74 0e                	je     800fca <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fbc:	ff 45 08             	incl   0x8(%ebp)
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	8a 00                	mov    (%eax),%al
  800fc4:	84 c0                	test   %al,%al
  800fc6:	75 ea                	jne    800fb2 <strfind+0xe>
  800fc8:	eb 01                	jmp    800fcb <strfind+0x27>
		if (*s == c)
			break;
  800fca:	90                   	nop
	return (char *) s;
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fce:	c9                   	leave  
  800fcf:	c3                   	ret    

00800fd0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fd0:	55                   	push   %ebp
  800fd1:	89 e5                	mov    %esp,%ebp
  800fd3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fe2:	eb 0e                	jmp    800ff2 <memset+0x22>
		*p++ = c;
  800fe4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe7:	8d 50 01             	lea    0x1(%eax),%edx
  800fea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fed:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ff2:	ff 4d f8             	decl   -0x8(%ebp)
  800ff5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ff9:	79 e9                	jns    800fe4 <memset+0x14>
		*p++ = c;

	return v;
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ffe:	c9                   	leave  
  800fff:	c3                   	ret    

00801000 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801000:	55                   	push   %ebp
  801001:	89 e5                	mov    %esp,%ebp
  801003:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801006:	8b 45 0c             	mov    0xc(%ebp),%eax
  801009:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801012:	eb 16                	jmp    80102a <memcpy+0x2a>
		*d++ = *s++;
  801014:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801017:	8d 50 01             	lea    0x1(%eax),%edx
  80101a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80101d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801020:	8d 4a 01             	lea    0x1(%edx),%ecx
  801023:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801026:	8a 12                	mov    (%edx),%dl
  801028:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80102a:	8b 45 10             	mov    0x10(%ebp),%eax
  80102d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801030:	89 55 10             	mov    %edx,0x10(%ebp)
  801033:	85 c0                	test   %eax,%eax
  801035:	75 dd                	jne    801014 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801042:	8b 45 0c             	mov    0xc(%ebp),%eax
  801045:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
  80104b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80104e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801051:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801054:	73 50                	jae    8010a6 <memmove+0x6a>
  801056:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801059:	8b 45 10             	mov    0x10(%ebp),%eax
  80105c:	01 d0                	add    %edx,%eax
  80105e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801061:	76 43                	jbe    8010a6 <memmove+0x6a>
		s += n;
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801069:	8b 45 10             	mov    0x10(%ebp),%eax
  80106c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80106f:	eb 10                	jmp    801081 <memmove+0x45>
			*--d = *--s;
  801071:	ff 4d f8             	decl   -0x8(%ebp)
  801074:	ff 4d fc             	decl   -0x4(%ebp)
  801077:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80107a:	8a 10                	mov    (%eax),%dl
  80107c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801081:	8b 45 10             	mov    0x10(%ebp),%eax
  801084:	8d 50 ff             	lea    -0x1(%eax),%edx
  801087:	89 55 10             	mov    %edx,0x10(%ebp)
  80108a:	85 c0                	test   %eax,%eax
  80108c:	75 e3                	jne    801071 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80108e:	eb 23                	jmp    8010b3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801090:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801093:	8d 50 01             	lea    0x1(%eax),%edx
  801096:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801099:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80109c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a2:	8a 12                	mov    (%edx),%dl
  8010a4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8010af:	85 c0                	test   %eax,%eax
  8010b1:	75 dd                	jne    801090 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b6:	c9                   	leave  
  8010b7:	c3                   	ret    

008010b8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
  8010bb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010ca:	eb 2a                	jmp    8010f6 <memcmp+0x3e>
		if (*s1 != *s2)
  8010cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cf:	8a 10                	mov    (%eax),%dl
  8010d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d4:	8a 00                	mov    (%eax),%al
  8010d6:	38 c2                	cmp    %al,%dl
  8010d8:	74 16                	je     8010f0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	0f b6 d0             	movzbl %al,%edx
  8010e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	0f b6 c0             	movzbl %al,%eax
  8010ea:	29 c2                	sub    %eax,%edx
  8010ec:	89 d0                	mov    %edx,%eax
  8010ee:	eb 18                	jmp    801108 <memcmp+0x50>
		s1++, s2++;
  8010f0:	ff 45 fc             	incl   -0x4(%ebp)
  8010f3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010fc:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ff:	85 c0                	test   %eax,%eax
  801101:	75 c9                	jne    8010cc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801103:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801108:	c9                   	leave  
  801109:	c3                   	ret    

0080110a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80110a:	55                   	push   %ebp
  80110b:	89 e5                	mov    %esp,%ebp
  80110d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801110:	8b 55 08             	mov    0x8(%ebp),%edx
  801113:	8b 45 10             	mov    0x10(%ebp),%eax
  801116:	01 d0                	add    %edx,%eax
  801118:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80111b:	eb 15                	jmp    801132 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	0f b6 d0             	movzbl %al,%edx
  801125:	8b 45 0c             	mov    0xc(%ebp),%eax
  801128:	0f b6 c0             	movzbl %al,%eax
  80112b:	39 c2                	cmp    %eax,%edx
  80112d:	74 0d                	je     80113c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80112f:	ff 45 08             	incl   0x8(%ebp)
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801138:	72 e3                	jb     80111d <memfind+0x13>
  80113a:	eb 01                	jmp    80113d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80113c:	90                   	nop
	return (void *) s;
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801140:	c9                   	leave  
  801141:	c3                   	ret    

00801142 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801142:	55                   	push   %ebp
  801143:	89 e5                	mov    %esp,%ebp
  801145:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801148:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80114f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801156:	eb 03                	jmp    80115b <strtol+0x19>
		s++;
  801158:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	3c 20                	cmp    $0x20,%al
  801162:	74 f4                	je     801158 <strtol+0x16>
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	3c 09                	cmp    $0x9,%al
  80116b:	74 eb                	je     801158 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	3c 2b                	cmp    $0x2b,%al
  801174:	75 05                	jne    80117b <strtol+0x39>
		s++;
  801176:	ff 45 08             	incl   0x8(%ebp)
  801179:	eb 13                	jmp    80118e <strtol+0x4c>
	else if (*s == '-')
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	8a 00                	mov    (%eax),%al
  801180:	3c 2d                	cmp    $0x2d,%al
  801182:	75 0a                	jne    80118e <strtol+0x4c>
		s++, neg = 1;
  801184:	ff 45 08             	incl   0x8(%ebp)
  801187:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80118e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801192:	74 06                	je     80119a <strtol+0x58>
  801194:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801198:	75 20                	jne    8011ba <strtol+0x78>
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	3c 30                	cmp    $0x30,%al
  8011a1:	75 17                	jne    8011ba <strtol+0x78>
  8011a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a6:	40                   	inc    %eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	3c 78                	cmp    $0x78,%al
  8011ab:	75 0d                	jne    8011ba <strtol+0x78>
		s += 2, base = 16;
  8011ad:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011b1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011b8:	eb 28                	jmp    8011e2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011be:	75 15                	jne    8011d5 <strtol+0x93>
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 30                	cmp    $0x30,%al
  8011c7:	75 0c                	jne    8011d5 <strtol+0x93>
		s++, base = 8;
  8011c9:	ff 45 08             	incl   0x8(%ebp)
  8011cc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011d3:	eb 0d                	jmp    8011e2 <strtol+0xa0>
	else if (base == 0)
  8011d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d9:	75 07                	jne    8011e2 <strtol+0xa0>
		base = 10;
  8011db:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3c 2f                	cmp    $0x2f,%al
  8011e9:	7e 19                	jle    801204 <strtol+0xc2>
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3c 39                	cmp    $0x39,%al
  8011f2:	7f 10                	jg     801204 <strtol+0xc2>
			dig = *s - '0';
  8011f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f7:	8a 00                	mov    (%eax),%al
  8011f9:	0f be c0             	movsbl %al,%eax
  8011fc:	83 e8 30             	sub    $0x30,%eax
  8011ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801202:	eb 42                	jmp    801246 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
  801207:	8a 00                	mov    (%eax),%al
  801209:	3c 60                	cmp    $0x60,%al
  80120b:	7e 19                	jle    801226 <strtol+0xe4>
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	3c 7a                	cmp    $0x7a,%al
  801214:	7f 10                	jg     801226 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	0f be c0             	movsbl %al,%eax
  80121e:	83 e8 57             	sub    $0x57,%eax
  801221:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801224:	eb 20                	jmp    801246 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801226:	8b 45 08             	mov    0x8(%ebp),%eax
  801229:	8a 00                	mov    (%eax),%al
  80122b:	3c 40                	cmp    $0x40,%al
  80122d:	7e 39                	jle    801268 <strtol+0x126>
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	8a 00                	mov    (%eax),%al
  801234:	3c 5a                	cmp    $0x5a,%al
  801236:	7f 30                	jg     801268 <strtol+0x126>
			dig = *s - 'A' + 10;
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	0f be c0             	movsbl %al,%eax
  801240:	83 e8 37             	sub    $0x37,%eax
  801243:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801246:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801249:	3b 45 10             	cmp    0x10(%ebp),%eax
  80124c:	7d 19                	jge    801267 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80124e:	ff 45 08             	incl   0x8(%ebp)
  801251:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801254:	0f af 45 10          	imul   0x10(%ebp),%eax
  801258:	89 c2                	mov    %eax,%edx
  80125a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80125d:	01 d0                	add    %edx,%eax
  80125f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801262:	e9 7b ff ff ff       	jmp    8011e2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801267:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801268:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80126c:	74 08                	je     801276 <strtol+0x134>
		*endptr = (char *) s;
  80126e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801271:	8b 55 08             	mov    0x8(%ebp),%edx
  801274:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801276:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80127a:	74 07                	je     801283 <strtol+0x141>
  80127c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127f:	f7 d8                	neg    %eax
  801281:	eb 03                	jmp    801286 <strtol+0x144>
  801283:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <ltostr>:

void
ltostr(long value, char *str)
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
  80128b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80128e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801295:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80129c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012a0:	79 13                	jns    8012b5 <ltostr+0x2d>
	{
		neg = 1;
  8012a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ac:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012af:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012b2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012bd:	99                   	cltd   
  8012be:	f7 f9                	idiv   %ecx
  8012c0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c6:	8d 50 01             	lea    0x1(%eax),%edx
  8012c9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012cc:	89 c2                	mov    %eax,%edx
  8012ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d1:	01 d0                	add    %edx,%eax
  8012d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d6:	83 c2 30             	add    $0x30,%edx
  8012d9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012db:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012de:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012e3:	f7 e9                	imul   %ecx
  8012e5:	c1 fa 02             	sar    $0x2,%edx
  8012e8:	89 c8                	mov    %ecx,%eax
  8012ea:	c1 f8 1f             	sar    $0x1f,%eax
  8012ed:	29 c2                	sub    %eax,%edx
  8012ef:	89 d0                	mov    %edx,%eax
  8012f1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012f7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012fc:	f7 e9                	imul   %ecx
  8012fe:	c1 fa 02             	sar    $0x2,%edx
  801301:	89 c8                	mov    %ecx,%eax
  801303:	c1 f8 1f             	sar    $0x1f,%eax
  801306:	29 c2                	sub    %eax,%edx
  801308:	89 d0                	mov    %edx,%eax
  80130a:	c1 e0 02             	shl    $0x2,%eax
  80130d:	01 d0                	add    %edx,%eax
  80130f:	01 c0                	add    %eax,%eax
  801311:	29 c1                	sub    %eax,%ecx
  801313:	89 ca                	mov    %ecx,%edx
  801315:	85 d2                	test   %edx,%edx
  801317:	75 9c                	jne    8012b5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801319:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801320:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801323:	48                   	dec    %eax
  801324:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801327:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80132b:	74 3d                	je     80136a <ltostr+0xe2>
		start = 1 ;
  80132d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801334:	eb 34                	jmp    80136a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801336:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801339:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133c:	01 d0                	add    %edx,%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801343:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801346:	8b 45 0c             	mov    0xc(%ebp),%eax
  801349:	01 c2                	add    %eax,%edx
  80134b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80134e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801351:	01 c8                	add    %ecx,%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801357:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80135a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135d:	01 c2                	add    %eax,%edx
  80135f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801362:	88 02                	mov    %al,(%edx)
		start++ ;
  801364:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801367:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80136a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80136d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801370:	7c c4                	jl     801336 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801372:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801375:	8b 45 0c             	mov    0xc(%ebp),%eax
  801378:	01 d0                	add    %edx,%eax
  80137a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80137d:	90                   	nop
  80137e:	c9                   	leave  
  80137f:	c3                   	ret    

00801380 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
  801383:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801386:	ff 75 08             	pushl  0x8(%ebp)
  801389:	e8 54 fa ff ff       	call   800de2 <strlen>
  80138e:	83 c4 04             	add    $0x4,%esp
  801391:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801394:	ff 75 0c             	pushl  0xc(%ebp)
  801397:	e8 46 fa ff ff       	call   800de2 <strlen>
  80139c:	83 c4 04             	add    $0x4,%esp
  80139f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013b0:	eb 17                	jmp    8013c9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b8:	01 c2                	add    %eax,%edx
  8013ba:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	01 c8                	add    %ecx,%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013c6:	ff 45 fc             	incl   -0x4(%ebp)
  8013c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013cf:	7c e1                	jl     8013b2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013df:	eb 1f                	jmp    801400 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e4:	8d 50 01             	lea    0x1(%eax),%edx
  8013e7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013ea:	89 c2                	mov    %eax,%edx
  8013ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ef:	01 c2                	add    %eax,%edx
  8013f1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f7:	01 c8                	add    %ecx,%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013fd:	ff 45 f8             	incl   -0x8(%ebp)
  801400:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801403:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801406:	7c d9                	jl     8013e1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801408:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80140b:	8b 45 10             	mov    0x10(%ebp),%eax
  80140e:	01 d0                	add    %edx,%eax
  801410:	c6 00 00             	movb   $0x0,(%eax)
}
  801413:	90                   	nop
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801419:	8b 45 14             	mov    0x14(%ebp),%eax
  80141c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801422:	8b 45 14             	mov    0x14(%ebp),%eax
  801425:	8b 00                	mov    (%eax),%eax
  801427:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80142e:	8b 45 10             	mov    0x10(%ebp),%eax
  801431:	01 d0                	add    %edx,%eax
  801433:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801439:	eb 0c                	jmp    801447 <strsplit+0x31>
			*string++ = 0;
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	8d 50 01             	lea    0x1(%eax),%edx
  801441:	89 55 08             	mov    %edx,0x8(%ebp)
  801444:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	84 c0                	test   %al,%al
  80144e:	74 18                	je     801468 <strsplit+0x52>
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	0f be c0             	movsbl %al,%eax
  801458:	50                   	push   %eax
  801459:	ff 75 0c             	pushl  0xc(%ebp)
  80145c:	e8 13 fb ff ff       	call   800f74 <strchr>
  801461:	83 c4 08             	add    $0x8,%esp
  801464:	85 c0                	test   %eax,%eax
  801466:	75 d3                	jne    80143b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	84 c0                	test   %al,%al
  80146f:	74 5a                	je     8014cb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801471:	8b 45 14             	mov    0x14(%ebp),%eax
  801474:	8b 00                	mov    (%eax),%eax
  801476:	83 f8 0f             	cmp    $0xf,%eax
  801479:	75 07                	jne    801482 <strsplit+0x6c>
		{
			return 0;
  80147b:	b8 00 00 00 00       	mov    $0x0,%eax
  801480:	eb 66                	jmp    8014e8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801482:	8b 45 14             	mov    0x14(%ebp),%eax
  801485:	8b 00                	mov    (%eax),%eax
  801487:	8d 48 01             	lea    0x1(%eax),%ecx
  80148a:	8b 55 14             	mov    0x14(%ebp),%edx
  80148d:	89 0a                	mov    %ecx,(%edx)
  80148f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801496:	8b 45 10             	mov    0x10(%ebp),%eax
  801499:	01 c2                	add    %eax,%edx
  80149b:	8b 45 08             	mov    0x8(%ebp),%eax
  80149e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014a0:	eb 03                	jmp    8014a5 <strsplit+0x8f>
			string++;
  8014a2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	8a 00                	mov    (%eax),%al
  8014aa:	84 c0                	test   %al,%al
  8014ac:	74 8b                	je     801439 <strsplit+0x23>
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b1:	8a 00                	mov    (%eax),%al
  8014b3:	0f be c0             	movsbl %al,%eax
  8014b6:	50                   	push   %eax
  8014b7:	ff 75 0c             	pushl  0xc(%ebp)
  8014ba:	e8 b5 fa ff ff       	call   800f74 <strchr>
  8014bf:	83 c4 08             	add    $0x8,%esp
  8014c2:	85 c0                	test   %eax,%eax
  8014c4:	74 dc                	je     8014a2 <strsplit+0x8c>
			string++;
	}
  8014c6:	e9 6e ff ff ff       	jmp    801439 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014cb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8014cf:	8b 00                	mov    (%eax),%eax
  8014d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014db:	01 d0                	add    %edx,%eax
  8014dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	c1 e8 0c             	shr    $0xc,%eax
  8014f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	25 ff 0f 00 00       	and    $0xfff,%eax
  801501:	85 c0                	test   %eax,%eax
  801503:	74 03                	je     801508 <malloc+0x1e>
			num++;
  801505:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801508:	a1 04 30 80 00       	mov    0x803004,%eax
  80150d:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801512:	75 73                	jne    801587 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801514:	83 ec 08             	sub    $0x8,%esp
  801517:	ff 75 08             	pushl  0x8(%ebp)
  80151a:	68 00 00 00 80       	push   $0x80000000
  80151f:	e8 13 05 00 00       	call   801a37 <sys_allocateMem>
  801524:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801527:	a1 04 30 80 00       	mov    0x803004,%eax
  80152c:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801532:	c1 e0 0c             	shl    $0xc,%eax
  801535:	89 c2                	mov    %eax,%edx
  801537:	a1 04 30 80 00       	mov    0x803004,%eax
  80153c:	01 d0                	add    %edx,%eax
  80153e:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801543:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801548:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154b:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801552:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801557:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80155d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801564:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801569:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801570:	01 00 00 00 
			sizeofarray++;
  801574:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801579:	40                   	inc    %eax
  80157a:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80157f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801582:	e9 71 01 00 00       	jmp    8016f8 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801587:	a1 28 30 80 00       	mov    0x803028,%eax
  80158c:	85 c0                	test   %eax,%eax
  80158e:	75 71                	jne    801601 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801590:	a1 04 30 80 00       	mov    0x803004,%eax
  801595:	83 ec 08             	sub    $0x8,%esp
  801598:	ff 75 08             	pushl  0x8(%ebp)
  80159b:	50                   	push   %eax
  80159c:	e8 96 04 00 00       	call   801a37 <sys_allocateMem>
  8015a1:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8015a4:	a1 04 30 80 00       	mov    0x803004,%eax
  8015a9:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8015ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015af:	c1 e0 0c             	shl    $0xc,%eax
  8015b2:	89 c2                	mov    %eax,%edx
  8015b4:	a1 04 30 80 00       	mov    0x803004,%eax
  8015b9:	01 d0                	add    %edx,%eax
  8015bb:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  8015c0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015c8:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8015cf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015d4:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8015d7:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8015de:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015e3:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8015ea:	01 00 00 00 
				sizeofarray++;
  8015ee:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015f3:	40                   	inc    %eax
  8015f4:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8015f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015fc:	e9 f7 00 00 00       	jmp    8016f8 <malloc+0x20e>
			}
			else{
				int count=0;
  801601:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801608:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80160f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801616:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80161d:	eb 7c                	jmp    80169b <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  80161f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801626:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80162d:	eb 1a                	jmp    801649 <malloc+0x15f>
					{
						if(addresses[j]==i)
  80162f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801632:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801639:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80163c:	75 08                	jne    801646 <malloc+0x15c>
						{
							index=j;
  80163e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801641:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801644:	eb 0d                	jmp    801653 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801646:	ff 45 dc             	incl   -0x24(%ebp)
  801649:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80164e:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801651:	7c dc                	jl     80162f <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801653:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801657:	75 05                	jne    80165e <malloc+0x174>
					{
						count++;
  801659:	ff 45 f0             	incl   -0x10(%ebp)
  80165c:	eb 36                	jmp    801694 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  80165e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801661:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801668:	85 c0                	test   %eax,%eax
  80166a:	75 05                	jne    801671 <malloc+0x187>
						{
							count++;
  80166c:	ff 45 f0             	incl   -0x10(%ebp)
  80166f:	eb 23                	jmp    801694 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801671:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801674:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801677:	7d 14                	jge    80168d <malloc+0x1a3>
  801679:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80167c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80167f:	7c 0c                	jl     80168d <malloc+0x1a3>
							{
								min=count;
  801681:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801684:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801687:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80168a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80168d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801694:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80169b:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8016a2:	0f 86 77 ff ff ff    	jbe    80161f <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8016a8:	83 ec 08             	sub    $0x8,%esp
  8016ab:	ff 75 08             	pushl  0x8(%ebp)
  8016ae:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016b1:	e8 81 03 00 00       	call   801a37 <sys_allocateMem>
  8016b6:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8016b9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016c1:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8016c8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016cd:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8016d3:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8016da:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016df:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8016e6:	01 00 00 00 
				sizeofarray++;
  8016ea:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016ef:	40                   	inc    %eax
  8016f0:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  8016f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8016f8:	c9                   	leave  
  8016f9:	c3                   	ret    

008016fa <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8016fa:	55                   	push   %ebp
  8016fb:	89 e5                	mov    %esp,%ebp
  8016fd:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  801706:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  80170d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801714:	eb 30                	jmp    801746 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801716:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801719:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801720:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801723:	75 1e                	jne    801743 <free+0x49>
  801725:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801728:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80172f:	83 f8 01             	cmp    $0x1,%eax
  801732:	75 0f                	jne    801743 <free+0x49>
    		is_found=1;
  801734:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  80173b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80173e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801741:	eb 0d                	jmp    801750 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801743:	ff 45 ec             	incl   -0x14(%ebp)
  801746:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80174b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  80174e:	7c c6                	jl     801716 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801750:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801754:	75 3a                	jne    801790 <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  801756:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801759:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801760:	c1 e0 0c             	shl    $0xc,%eax
  801763:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801766:	83 ec 08             	sub    $0x8,%esp
  801769:	ff 75 e4             	pushl  -0x1c(%ebp)
  80176c:	ff 75 e8             	pushl  -0x18(%ebp)
  80176f:	e8 a7 02 00 00       	call   801a1b <sys_freeMem>
  801774:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801777:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80177a:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801781:	00 00 00 00 
    	changes++;
  801785:	a1 28 30 80 00       	mov    0x803028,%eax
  80178a:	40                   	inc    %eax
  80178b:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  801790:	90                   	nop
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
  801796:	83 ec 18             	sub    $0x18,%esp
  801799:	8b 45 10             	mov    0x10(%ebp),%eax
  80179c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80179f:	83 ec 04             	sub    $0x4,%esp
  8017a2:	68 f0 29 80 00       	push   $0x8029f0
  8017a7:	68 9f 00 00 00       	push   $0x9f
  8017ac:	68 13 2a 80 00       	push   $0x802a13
  8017b1:	e8 08 ed ff ff       	call   8004be <_panic>

008017b6 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
  8017b9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017bc:	83 ec 04             	sub    $0x4,%esp
  8017bf:	68 f0 29 80 00       	push   $0x8029f0
  8017c4:	68 a5 00 00 00       	push   $0xa5
  8017c9:	68 13 2a 80 00       	push   $0x802a13
  8017ce:	e8 eb ec ff ff       	call   8004be <_panic>

008017d3 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
  8017d6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017d9:	83 ec 04             	sub    $0x4,%esp
  8017dc:	68 f0 29 80 00       	push   $0x8029f0
  8017e1:	68 ab 00 00 00       	push   $0xab
  8017e6:	68 13 2a 80 00       	push   $0x802a13
  8017eb:	e8 ce ec ff ff       	call   8004be <_panic>

008017f0 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
  8017f3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017f6:	83 ec 04             	sub    $0x4,%esp
  8017f9:	68 f0 29 80 00       	push   $0x8029f0
  8017fe:	68 b0 00 00 00       	push   $0xb0
  801803:	68 13 2a 80 00       	push   $0x802a13
  801808:	e8 b1 ec ff ff       	call   8004be <_panic>

0080180d <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
  801810:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801813:	83 ec 04             	sub    $0x4,%esp
  801816:	68 f0 29 80 00       	push   $0x8029f0
  80181b:	68 b6 00 00 00       	push   $0xb6
  801820:	68 13 2a 80 00       	push   $0x802a13
  801825:	e8 94 ec ff ff       	call   8004be <_panic>

0080182a <shrink>:
}
void shrink(uint32 newSize)
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
  80182d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801830:	83 ec 04             	sub    $0x4,%esp
  801833:	68 f0 29 80 00       	push   $0x8029f0
  801838:	68 ba 00 00 00       	push   $0xba
  80183d:	68 13 2a 80 00       	push   $0x802a13
  801842:	e8 77 ec ff ff       	call   8004be <_panic>

00801847 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
  80184a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80184d:	83 ec 04             	sub    $0x4,%esp
  801850:	68 f0 29 80 00       	push   $0x8029f0
  801855:	68 bf 00 00 00       	push   $0xbf
  80185a:	68 13 2a 80 00       	push   $0x802a13
  80185f:	e8 5a ec ff ff       	call   8004be <_panic>

00801864 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	57                   	push   %edi
  801868:	56                   	push   %esi
  801869:	53                   	push   %ebx
  80186a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80186d:	8b 45 08             	mov    0x8(%ebp),%eax
  801870:	8b 55 0c             	mov    0xc(%ebp),%edx
  801873:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801876:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801879:	8b 7d 18             	mov    0x18(%ebp),%edi
  80187c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80187f:	cd 30                	int    $0x30
  801881:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801884:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801887:	83 c4 10             	add    $0x10,%esp
  80188a:	5b                   	pop    %ebx
  80188b:	5e                   	pop    %esi
  80188c:	5f                   	pop    %edi
  80188d:	5d                   	pop    %ebp
  80188e:	c3                   	ret    

0080188f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
  801892:	83 ec 04             	sub    $0x4,%esp
  801895:	8b 45 10             	mov    0x10(%ebp),%eax
  801898:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80189b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80189f:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	52                   	push   %edx
  8018a7:	ff 75 0c             	pushl  0xc(%ebp)
  8018aa:	50                   	push   %eax
  8018ab:	6a 00                	push   $0x0
  8018ad:	e8 b2 ff ff ff       	call   801864 <syscall>
  8018b2:	83 c4 18             	add    $0x18,%esp
}
  8018b5:	90                   	nop
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <sys_cgetc>:

int
sys_cgetc(void)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 01                	push   $0x1
  8018c7:	e8 98 ff ff ff       	call   801864 <syscall>
  8018cc:	83 c4 18             	add    $0x18,%esp
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	50                   	push   %eax
  8018e0:	6a 05                	push   $0x5
  8018e2:	e8 7d ff ff ff       	call   801864 <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
}
  8018ea:	c9                   	leave  
  8018eb:	c3                   	ret    

008018ec <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018ec:	55                   	push   %ebp
  8018ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 02                	push   $0x2
  8018fb:	e8 64 ff ff ff       	call   801864 <syscall>
  801900:	83 c4 18             	add    $0x18,%esp
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 03                	push   $0x3
  801914:	e8 4b ff ff ff       	call   801864 <syscall>
  801919:	83 c4 18             	add    $0x18,%esp
}
  80191c:	c9                   	leave  
  80191d:	c3                   	ret    

0080191e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 04                	push   $0x4
  80192d:	e8 32 ff ff ff       	call   801864 <syscall>
  801932:	83 c4 18             	add    $0x18,%esp
}
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <sys_env_exit>:


void sys_env_exit(void)
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 06                	push   $0x6
  801946:	e8 19 ff ff ff       	call   801864 <syscall>
  80194b:	83 c4 18             	add    $0x18,%esp
}
  80194e:	90                   	nop
  80194f:	c9                   	leave  
  801950:	c3                   	ret    

00801951 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801951:	55                   	push   %ebp
  801952:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801954:	8b 55 0c             	mov    0xc(%ebp),%edx
  801957:	8b 45 08             	mov    0x8(%ebp),%eax
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	52                   	push   %edx
  801961:	50                   	push   %eax
  801962:	6a 07                	push   $0x7
  801964:	e8 fb fe ff ff       	call   801864 <syscall>
  801969:	83 c4 18             	add    $0x18,%esp
}
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
  801971:	56                   	push   %esi
  801972:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801973:	8b 75 18             	mov    0x18(%ebp),%esi
  801976:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801979:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80197c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197f:	8b 45 08             	mov    0x8(%ebp),%eax
  801982:	56                   	push   %esi
  801983:	53                   	push   %ebx
  801984:	51                   	push   %ecx
  801985:	52                   	push   %edx
  801986:	50                   	push   %eax
  801987:	6a 08                	push   $0x8
  801989:	e8 d6 fe ff ff       	call   801864 <syscall>
  80198e:	83 c4 18             	add    $0x18,%esp
}
  801991:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801994:	5b                   	pop    %ebx
  801995:	5e                   	pop    %esi
  801996:	5d                   	pop    %ebp
  801997:	c3                   	ret    

00801998 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80199b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80199e:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	52                   	push   %edx
  8019a8:	50                   	push   %eax
  8019a9:	6a 09                	push   $0x9
  8019ab:	e8 b4 fe ff ff       	call   801864 <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	ff 75 0c             	pushl  0xc(%ebp)
  8019c1:	ff 75 08             	pushl  0x8(%ebp)
  8019c4:	6a 0a                	push   $0xa
  8019c6:	e8 99 fe ff ff       	call   801864 <syscall>
  8019cb:	83 c4 18             	add    $0x18,%esp
}
  8019ce:	c9                   	leave  
  8019cf:	c3                   	ret    

008019d0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 0b                	push   $0xb
  8019df:	e8 80 fe ff ff       	call   801864 <syscall>
  8019e4:	83 c4 18             	add    $0x18,%esp
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 0c                	push   $0xc
  8019f8:	e8 67 fe ff ff       	call   801864 <syscall>
  8019fd:	83 c4 18             	add    $0x18,%esp
}
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 0d                	push   $0xd
  801a11:	e8 4e fe ff ff       	call   801864 <syscall>
  801a16:	83 c4 18             	add    $0x18,%esp
}
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	ff 75 0c             	pushl  0xc(%ebp)
  801a27:	ff 75 08             	pushl  0x8(%ebp)
  801a2a:	6a 11                	push   $0x11
  801a2c:	e8 33 fe ff ff       	call   801864 <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
	return;
  801a34:	90                   	nop
}
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	ff 75 0c             	pushl  0xc(%ebp)
  801a43:	ff 75 08             	pushl  0x8(%ebp)
  801a46:	6a 12                	push   $0x12
  801a48:	e8 17 fe ff ff       	call   801864 <syscall>
  801a4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a50:	90                   	nop
}
  801a51:	c9                   	leave  
  801a52:	c3                   	ret    

00801a53 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 0e                	push   $0xe
  801a62:	e8 fd fd ff ff       	call   801864 <syscall>
  801a67:	83 c4 18             	add    $0x18,%esp
}
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	ff 75 08             	pushl  0x8(%ebp)
  801a7a:	6a 0f                	push   $0xf
  801a7c:	e8 e3 fd ff ff       	call   801864 <syscall>
  801a81:	83 c4 18             	add    $0x18,%esp
}
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 10                	push   $0x10
  801a95:	e8 ca fd ff ff       	call   801864 <syscall>
  801a9a:	83 c4 18             	add    $0x18,%esp
}
  801a9d:	90                   	nop
  801a9e:	c9                   	leave  
  801a9f:	c3                   	ret    

00801aa0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801aa0:	55                   	push   %ebp
  801aa1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 14                	push   $0x14
  801aaf:	e8 b0 fd ff ff       	call   801864 <syscall>
  801ab4:	83 c4 18             	add    $0x18,%esp
}
  801ab7:	90                   	nop
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 15                	push   $0x15
  801ac9:	e8 96 fd ff ff       	call   801864 <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
}
  801ad1:	90                   	nop
  801ad2:	c9                   	leave  
  801ad3:	c3                   	ret    

00801ad4 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ad4:	55                   	push   %ebp
  801ad5:	89 e5                	mov    %esp,%ebp
  801ad7:	83 ec 04             	sub    $0x4,%esp
  801ada:	8b 45 08             	mov    0x8(%ebp),%eax
  801add:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ae0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	50                   	push   %eax
  801aed:	6a 16                	push   $0x16
  801aef:	e8 70 fd ff ff       	call   801864 <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
}
  801af7:	90                   	nop
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 17                	push   $0x17
  801b09:	e8 56 fd ff ff       	call   801864 <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
}
  801b11:	90                   	nop
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b17:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	ff 75 0c             	pushl  0xc(%ebp)
  801b23:	50                   	push   %eax
  801b24:	6a 18                	push   $0x18
  801b26:	e8 39 fd ff ff       	call   801864 <syscall>
  801b2b:	83 c4 18             	add    $0x18,%esp
}
  801b2e:	c9                   	leave  
  801b2f:	c3                   	ret    

00801b30 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b30:	55                   	push   %ebp
  801b31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	52                   	push   %edx
  801b40:	50                   	push   %eax
  801b41:	6a 1b                	push   $0x1b
  801b43:	e8 1c fd ff ff       	call   801864 <syscall>
  801b48:	83 c4 18             	add    $0x18,%esp
}
  801b4b:	c9                   	leave  
  801b4c:	c3                   	ret    

00801b4d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b53:	8b 45 08             	mov    0x8(%ebp),%eax
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	52                   	push   %edx
  801b5d:	50                   	push   %eax
  801b5e:	6a 19                	push   $0x19
  801b60:	e8 ff fc ff ff       	call   801864 <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
}
  801b68:	90                   	nop
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b71:	8b 45 08             	mov    0x8(%ebp),%eax
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	52                   	push   %edx
  801b7b:	50                   	push   %eax
  801b7c:	6a 1a                	push   $0x1a
  801b7e:	e8 e1 fc ff ff       	call   801864 <syscall>
  801b83:	83 c4 18             	add    $0x18,%esp
}
  801b86:	90                   	nop
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
  801b8c:	83 ec 04             	sub    $0x4,%esp
  801b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  801b92:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b95:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b98:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9f:	6a 00                	push   $0x0
  801ba1:	51                   	push   %ecx
  801ba2:	52                   	push   %edx
  801ba3:	ff 75 0c             	pushl  0xc(%ebp)
  801ba6:	50                   	push   %eax
  801ba7:	6a 1c                	push   $0x1c
  801ba9:	e8 b6 fc ff ff       	call   801864 <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	52                   	push   %edx
  801bc3:	50                   	push   %eax
  801bc4:	6a 1d                	push   $0x1d
  801bc6:	e8 99 fc ff ff       	call   801864 <syscall>
  801bcb:	83 c4 18             	add    $0x18,%esp
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801bd3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	51                   	push   %ecx
  801be1:	52                   	push   %edx
  801be2:	50                   	push   %eax
  801be3:	6a 1e                	push   $0x1e
  801be5:	e8 7a fc ff ff       	call   801864 <syscall>
  801bea:	83 c4 18             	add    $0x18,%esp
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bf2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	52                   	push   %edx
  801bff:	50                   	push   %eax
  801c00:	6a 1f                	push   $0x1f
  801c02:	e8 5d fc ff ff       	call   801864 <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 20                	push   $0x20
  801c1b:	e8 44 fc ff ff       	call   801864 <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c28:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2b:	6a 00                	push   $0x0
  801c2d:	ff 75 14             	pushl  0x14(%ebp)
  801c30:	ff 75 10             	pushl  0x10(%ebp)
  801c33:	ff 75 0c             	pushl  0xc(%ebp)
  801c36:	50                   	push   %eax
  801c37:	6a 21                	push   $0x21
  801c39:	e8 26 fc ff ff       	call   801864 <syscall>
  801c3e:	83 c4 18             	add    $0x18,%esp
}
  801c41:	c9                   	leave  
  801c42:	c3                   	ret    

00801c43 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c43:	55                   	push   %ebp
  801c44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c46:	8b 45 08             	mov    0x8(%ebp),%eax
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	50                   	push   %eax
  801c52:	6a 22                	push   $0x22
  801c54:	e8 0b fc ff ff       	call   801864 <syscall>
  801c59:	83 c4 18             	add    $0x18,%esp
}
  801c5c:	90                   	nop
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	50                   	push   %eax
  801c6e:	6a 23                	push   $0x23
  801c70:	e8 ef fb ff ff       	call   801864 <syscall>
  801c75:	83 c4 18             	add    $0x18,%esp
}
  801c78:	90                   	nop
  801c79:	c9                   	leave  
  801c7a:	c3                   	ret    

00801c7b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c7b:	55                   	push   %ebp
  801c7c:	89 e5                	mov    %esp,%ebp
  801c7e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c81:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c84:	8d 50 04             	lea    0x4(%eax),%edx
  801c87:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	52                   	push   %edx
  801c91:	50                   	push   %eax
  801c92:	6a 24                	push   $0x24
  801c94:	e8 cb fb ff ff       	call   801864 <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
	return result;
  801c9c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ca2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ca5:	89 01                	mov    %eax,(%ecx)
  801ca7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801caa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cad:	c9                   	leave  
  801cae:	c2 04 00             	ret    $0x4

00801cb1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	ff 75 10             	pushl  0x10(%ebp)
  801cbb:	ff 75 0c             	pushl  0xc(%ebp)
  801cbe:	ff 75 08             	pushl  0x8(%ebp)
  801cc1:	6a 13                	push   $0x13
  801cc3:	e8 9c fb ff ff       	call   801864 <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
	return ;
  801ccb:	90                   	nop
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_rcr2>:
uint32 sys_rcr2()
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 25                	push   $0x25
  801cdd:	e8 82 fb ff ff       	call   801864 <syscall>
  801ce2:	83 c4 18             	add    $0x18,%esp
}
  801ce5:	c9                   	leave  
  801ce6:	c3                   	ret    

00801ce7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ce7:	55                   	push   %ebp
  801ce8:	89 e5                	mov    %esp,%ebp
  801cea:	83 ec 04             	sub    $0x4,%esp
  801ced:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cf3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	50                   	push   %eax
  801d00:	6a 26                	push   $0x26
  801d02:	e8 5d fb ff ff       	call   801864 <syscall>
  801d07:	83 c4 18             	add    $0x18,%esp
	return ;
  801d0a:	90                   	nop
}
  801d0b:	c9                   	leave  
  801d0c:	c3                   	ret    

00801d0d <rsttst>:
void rsttst()
{
  801d0d:	55                   	push   %ebp
  801d0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 28                	push   $0x28
  801d1c:	e8 43 fb ff ff       	call   801864 <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
	return ;
  801d24:	90                   	nop
}
  801d25:	c9                   	leave  
  801d26:	c3                   	ret    

00801d27 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d27:	55                   	push   %ebp
  801d28:	89 e5                	mov    %esp,%ebp
  801d2a:	83 ec 04             	sub    $0x4,%esp
  801d2d:	8b 45 14             	mov    0x14(%ebp),%eax
  801d30:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d33:	8b 55 18             	mov    0x18(%ebp),%edx
  801d36:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d3a:	52                   	push   %edx
  801d3b:	50                   	push   %eax
  801d3c:	ff 75 10             	pushl  0x10(%ebp)
  801d3f:	ff 75 0c             	pushl  0xc(%ebp)
  801d42:	ff 75 08             	pushl  0x8(%ebp)
  801d45:	6a 27                	push   $0x27
  801d47:	e8 18 fb ff ff       	call   801864 <syscall>
  801d4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d4f:	90                   	nop
}
  801d50:	c9                   	leave  
  801d51:	c3                   	ret    

00801d52 <chktst>:
void chktst(uint32 n)
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	ff 75 08             	pushl  0x8(%ebp)
  801d60:	6a 29                	push   $0x29
  801d62:	e8 fd fa ff ff       	call   801864 <syscall>
  801d67:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6a:	90                   	nop
}
  801d6b:	c9                   	leave  
  801d6c:	c3                   	ret    

00801d6d <inctst>:

void inctst()
{
  801d6d:	55                   	push   %ebp
  801d6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 2a                	push   $0x2a
  801d7c:	e8 e3 fa ff ff       	call   801864 <syscall>
  801d81:	83 c4 18             	add    $0x18,%esp
	return ;
  801d84:	90                   	nop
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <gettst>:
uint32 gettst()
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 2b                	push   $0x2b
  801d96:	e8 c9 fa ff ff       	call   801864 <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
}
  801d9e:	c9                   	leave  
  801d9f:	c3                   	ret    

00801da0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801da0:	55                   	push   %ebp
  801da1:	89 e5                	mov    %esp,%ebp
  801da3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 2c                	push   $0x2c
  801db2:	e8 ad fa ff ff       	call   801864 <syscall>
  801db7:	83 c4 18             	add    $0x18,%esp
  801dba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801dbd:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801dc1:	75 07                	jne    801dca <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801dc3:	b8 01 00 00 00       	mov    $0x1,%eax
  801dc8:	eb 05                	jmp    801dcf <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801dca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
  801dd4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 2c                	push   $0x2c
  801de3:	e8 7c fa ff ff       	call   801864 <syscall>
  801de8:	83 c4 18             	add    $0x18,%esp
  801deb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801dee:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801df2:	75 07                	jne    801dfb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801df4:	b8 01 00 00 00       	mov    $0x1,%eax
  801df9:	eb 05                	jmp    801e00 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801dfb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e00:	c9                   	leave  
  801e01:	c3                   	ret    

00801e02 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e02:	55                   	push   %ebp
  801e03:	89 e5                	mov    %esp,%ebp
  801e05:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 2c                	push   $0x2c
  801e14:	e8 4b fa ff ff       	call   801864 <syscall>
  801e19:	83 c4 18             	add    $0x18,%esp
  801e1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e1f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e23:	75 07                	jne    801e2c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e25:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2a:	eb 05                	jmp    801e31 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
  801e36:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 2c                	push   $0x2c
  801e45:	e8 1a fa ff ff       	call   801864 <syscall>
  801e4a:	83 c4 18             	add    $0x18,%esp
  801e4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e50:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e54:	75 07                	jne    801e5d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e56:	b8 01 00 00 00       	mov    $0x1,%eax
  801e5b:	eb 05                	jmp    801e62 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e62:	c9                   	leave  
  801e63:	c3                   	ret    

00801e64 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e64:	55                   	push   %ebp
  801e65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	ff 75 08             	pushl  0x8(%ebp)
  801e72:	6a 2d                	push   $0x2d
  801e74:	e8 eb f9 ff ff       	call   801864 <syscall>
  801e79:	83 c4 18             	add    $0x18,%esp
	return ;
  801e7c:	90                   	nop
}
  801e7d:	c9                   	leave  
  801e7e:	c3                   	ret    

00801e7f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e7f:	55                   	push   %ebp
  801e80:	89 e5                	mov    %esp,%ebp
  801e82:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e83:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e86:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8f:	6a 00                	push   $0x0
  801e91:	53                   	push   %ebx
  801e92:	51                   	push   %ecx
  801e93:	52                   	push   %edx
  801e94:	50                   	push   %eax
  801e95:	6a 2e                	push   $0x2e
  801e97:	e8 c8 f9 ff ff       	call   801864 <syscall>
  801e9c:	83 c4 18             	add    $0x18,%esp
}
  801e9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ea2:	c9                   	leave  
  801ea3:	c3                   	ret    

00801ea4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ea4:	55                   	push   %ebp
  801ea5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ea7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	52                   	push   %edx
  801eb4:	50                   	push   %eax
  801eb5:	6a 2f                	push   $0x2f
  801eb7:	e8 a8 f9 ff ff       	call   801864 <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
  801ec4:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801ec7:	8b 55 08             	mov    0x8(%ebp),%edx
  801eca:	89 d0                	mov    %edx,%eax
  801ecc:	c1 e0 02             	shl    $0x2,%eax
  801ecf:	01 d0                	add    %edx,%eax
  801ed1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ed8:	01 d0                	add    %edx,%eax
  801eda:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ee1:	01 d0                	add    %edx,%eax
  801ee3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801eea:	01 d0                	add    %edx,%eax
  801eec:	c1 e0 04             	shl    $0x4,%eax
  801eef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801ef2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801ef9:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801efc:	83 ec 0c             	sub    $0xc,%esp
  801eff:	50                   	push   %eax
  801f00:	e8 76 fd ff ff       	call   801c7b <sys_get_virtual_time>
  801f05:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801f08:	eb 41                	jmp    801f4b <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801f0a:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801f0d:	83 ec 0c             	sub    $0xc,%esp
  801f10:	50                   	push   %eax
  801f11:	e8 65 fd ff ff       	call   801c7b <sys_get_virtual_time>
  801f16:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801f19:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801f1c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f1f:	29 c2                	sub    %eax,%edx
  801f21:	89 d0                	mov    %edx,%eax
  801f23:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801f26:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801f29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f2c:	89 d1                	mov    %edx,%ecx
  801f2e:	29 c1                	sub    %eax,%ecx
  801f30:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801f33:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f36:	39 c2                	cmp    %eax,%edx
  801f38:	0f 97 c0             	seta   %al
  801f3b:	0f b6 c0             	movzbl %al,%eax
  801f3e:	29 c1                	sub    %eax,%ecx
  801f40:	89 c8                	mov    %ecx,%eax
  801f42:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801f45:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801f48:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f4e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801f51:	72 b7                	jb     801f0a <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801f53:	90                   	nop
  801f54:	c9                   	leave  
  801f55:	c3                   	ret    

00801f56 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801f56:	55                   	push   %ebp
  801f57:	89 e5                	mov    %esp,%ebp
  801f59:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801f5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801f63:	eb 03                	jmp    801f68 <busy_wait+0x12>
  801f65:	ff 45 fc             	incl   -0x4(%ebp)
  801f68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f6b:	3b 45 08             	cmp    0x8(%ebp),%eax
  801f6e:	72 f5                	jb     801f65 <busy_wait+0xf>
	return i;
  801f70:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f73:	c9                   	leave  
  801f74:	c3                   	ret    
  801f75:	66 90                	xchg   %ax,%ax
  801f77:	90                   	nop

00801f78 <__udivdi3>:
  801f78:	55                   	push   %ebp
  801f79:	57                   	push   %edi
  801f7a:	56                   	push   %esi
  801f7b:	53                   	push   %ebx
  801f7c:	83 ec 1c             	sub    $0x1c,%esp
  801f7f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f83:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f87:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f8b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f8f:	89 ca                	mov    %ecx,%edx
  801f91:	89 f8                	mov    %edi,%eax
  801f93:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f97:	85 f6                	test   %esi,%esi
  801f99:	75 2d                	jne    801fc8 <__udivdi3+0x50>
  801f9b:	39 cf                	cmp    %ecx,%edi
  801f9d:	77 65                	ja     802004 <__udivdi3+0x8c>
  801f9f:	89 fd                	mov    %edi,%ebp
  801fa1:	85 ff                	test   %edi,%edi
  801fa3:	75 0b                	jne    801fb0 <__udivdi3+0x38>
  801fa5:	b8 01 00 00 00       	mov    $0x1,%eax
  801faa:	31 d2                	xor    %edx,%edx
  801fac:	f7 f7                	div    %edi
  801fae:	89 c5                	mov    %eax,%ebp
  801fb0:	31 d2                	xor    %edx,%edx
  801fb2:	89 c8                	mov    %ecx,%eax
  801fb4:	f7 f5                	div    %ebp
  801fb6:	89 c1                	mov    %eax,%ecx
  801fb8:	89 d8                	mov    %ebx,%eax
  801fba:	f7 f5                	div    %ebp
  801fbc:	89 cf                	mov    %ecx,%edi
  801fbe:	89 fa                	mov    %edi,%edx
  801fc0:	83 c4 1c             	add    $0x1c,%esp
  801fc3:	5b                   	pop    %ebx
  801fc4:	5e                   	pop    %esi
  801fc5:	5f                   	pop    %edi
  801fc6:	5d                   	pop    %ebp
  801fc7:	c3                   	ret    
  801fc8:	39 ce                	cmp    %ecx,%esi
  801fca:	77 28                	ja     801ff4 <__udivdi3+0x7c>
  801fcc:	0f bd fe             	bsr    %esi,%edi
  801fcf:	83 f7 1f             	xor    $0x1f,%edi
  801fd2:	75 40                	jne    802014 <__udivdi3+0x9c>
  801fd4:	39 ce                	cmp    %ecx,%esi
  801fd6:	72 0a                	jb     801fe2 <__udivdi3+0x6a>
  801fd8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fdc:	0f 87 9e 00 00 00    	ja     802080 <__udivdi3+0x108>
  801fe2:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe7:	89 fa                	mov    %edi,%edx
  801fe9:	83 c4 1c             	add    $0x1c,%esp
  801fec:	5b                   	pop    %ebx
  801fed:	5e                   	pop    %esi
  801fee:	5f                   	pop    %edi
  801fef:	5d                   	pop    %ebp
  801ff0:	c3                   	ret    
  801ff1:	8d 76 00             	lea    0x0(%esi),%esi
  801ff4:	31 ff                	xor    %edi,%edi
  801ff6:	31 c0                	xor    %eax,%eax
  801ff8:	89 fa                	mov    %edi,%edx
  801ffa:	83 c4 1c             	add    $0x1c,%esp
  801ffd:	5b                   	pop    %ebx
  801ffe:	5e                   	pop    %esi
  801fff:	5f                   	pop    %edi
  802000:	5d                   	pop    %ebp
  802001:	c3                   	ret    
  802002:	66 90                	xchg   %ax,%ax
  802004:	89 d8                	mov    %ebx,%eax
  802006:	f7 f7                	div    %edi
  802008:	31 ff                	xor    %edi,%edi
  80200a:	89 fa                	mov    %edi,%edx
  80200c:	83 c4 1c             	add    $0x1c,%esp
  80200f:	5b                   	pop    %ebx
  802010:	5e                   	pop    %esi
  802011:	5f                   	pop    %edi
  802012:	5d                   	pop    %ebp
  802013:	c3                   	ret    
  802014:	bd 20 00 00 00       	mov    $0x20,%ebp
  802019:	89 eb                	mov    %ebp,%ebx
  80201b:	29 fb                	sub    %edi,%ebx
  80201d:	89 f9                	mov    %edi,%ecx
  80201f:	d3 e6                	shl    %cl,%esi
  802021:	89 c5                	mov    %eax,%ebp
  802023:	88 d9                	mov    %bl,%cl
  802025:	d3 ed                	shr    %cl,%ebp
  802027:	89 e9                	mov    %ebp,%ecx
  802029:	09 f1                	or     %esi,%ecx
  80202b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80202f:	89 f9                	mov    %edi,%ecx
  802031:	d3 e0                	shl    %cl,%eax
  802033:	89 c5                	mov    %eax,%ebp
  802035:	89 d6                	mov    %edx,%esi
  802037:	88 d9                	mov    %bl,%cl
  802039:	d3 ee                	shr    %cl,%esi
  80203b:	89 f9                	mov    %edi,%ecx
  80203d:	d3 e2                	shl    %cl,%edx
  80203f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802043:	88 d9                	mov    %bl,%cl
  802045:	d3 e8                	shr    %cl,%eax
  802047:	09 c2                	or     %eax,%edx
  802049:	89 d0                	mov    %edx,%eax
  80204b:	89 f2                	mov    %esi,%edx
  80204d:	f7 74 24 0c          	divl   0xc(%esp)
  802051:	89 d6                	mov    %edx,%esi
  802053:	89 c3                	mov    %eax,%ebx
  802055:	f7 e5                	mul    %ebp
  802057:	39 d6                	cmp    %edx,%esi
  802059:	72 19                	jb     802074 <__udivdi3+0xfc>
  80205b:	74 0b                	je     802068 <__udivdi3+0xf0>
  80205d:	89 d8                	mov    %ebx,%eax
  80205f:	31 ff                	xor    %edi,%edi
  802061:	e9 58 ff ff ff       	jmp    801fbe <__udivdi3+0x46>
  802066:	66 90                	xchg   %ax,%ax
  802068:	8b 54 24 08          	mov    0x8(%esp),%edx
  80206c:	89 f9                	mov    %edi,%ecx
  80206e:	d3 e2                	shl    %cl,%edx
  802070:	39 c2                	cmp    %eax,%edx
  802072:	73 e9                	jae    80205d <__udivdi3+0xe5>
  802074:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802077:	31 ff                	xor    %edi,%edi
  802079:	e9 40 ff ff ff       	jmp    801fbe <__udivdi3+0x46>
  80207e:	66 90                	xchg   %ax,%ax
  802080:	31 c0                	xor    %eax,%eax
  802082:	e9 37 ff ff ff       	jmp    801fbe <__udivdi3+0x46>
  802087:	90                   	nop

00802088 <__umoddi3>:
  802088:	55                   	push   %ebp
  802089:	57                   	push   %edi
  80208a:	56                   	push   %esi
  80208b:	53                   	push   %ebx
  80208c:	83 ec 1c             	sub    $0x1c,%esp
  80208f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802093:	8b 74 24 34          	mov    0x34(%esp),%esi
  802097:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80209b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80209f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020a3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020a7:	89 f3                	mov    %esi,%ebx
  8020a9:	89 fa                	mov    %edi,%edx
  8020ab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020af:	89 34 24             	mov    %esi,(%esp)
  8020b2:	85 c0                	test   %eax,%eax
  8020b4:	75 1a                	jne    8020d0 <__umoddi3+0x48>
  8020b6:	39 f7                	cmp    %esi,%edi
  8020b8:	0f 86 a2 00 00 00    	jbe    802160 <__umoddi3+0xd8>
  8020be:	89 c8                	mov    %ecx,%eax
  8020c0:	89 f2                	mov    %esi,%edx
  8020c2:	f7 f7                	div    %edi
  8020c4:	89 d0                	mov    %edx,%eax
  8020c6:	31 d2                	xor    %edx,%edx
  8020c8:	83 c4 1c             	add    $0x1c,%esp
  8020cb:	5b                   	pop    %ebx
  8020cc:	5e                   	pop    %esi
  8020cd:	5f                   	pop    %edi
  8020ce:	5d                   	pop    %ebp
  8020cf:	c3                   	ret    
  8020d0:	39 f0                	cmp    %esi,%eax
  8020d2:	0f 87 ac 00 00 00    	ja     802184 <__umoddi3+0xfc>
  8020d8:	0f bd e8             	bsr    %eax,%ebp
  8020db:	83 f5 1f             	xor    $0x1f,%ebp
  8020de:	0f 84 ac 00 00 00    	je     802190 <__umoddi3+0x108>
  8020e4:	bf 20 00 00 00       	mov    $0x20,%edi
  8020e9:	29 ef                	sub    %ebp,%edi
  8020eb:	89 fe                	mov    %edi,%esi
  8020ed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020f1:	89 e9                	mov    %ebp,%ecx
  8020f3:	d3 e0                	shl    %cl,%eax
  8020f5:	89 d7                	mov    %edx,%edi
  8020f7:	89 f1                	mov    %esi,%ecx
  8020f9:	d3 ef                	shr    %cl,%edi
  8020fb:	09 c7                	or     %eax,%edi
  8020fd:	89 e9                	mov    %ebp,%ecx
  8020ff:	d3 e2                	shl    %cl,%edx
  802101:	89 14 24             	mov    %edx,(%esp)
  802104:	89 d8                	mov    %ebx,%eax
  802106:	d3 e0                	shl    %cl,%eax
  802108:	89 c2                	mov    %eax,%edx
  80210a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80210e:	d3 e0                	shl    %cl,%eax
  802110:	89 44 24 04          	mov    %eax,0x4(%esp)
  802114:	8b 44 24 08          	mov    0x8(%esp),%eax
  802118:	89 f1                	mov    %esi,%ecx
  80211a:	d3 e8                	shr    %cl,%eax
  80211c:	09 d0                	or     %edx,%eax
  80211e:	d3 eb                	shr    %cl,%ebx
  802120:	89 da                	mov    %ebx,%edx
  802122:	f7 f7                	div    %edi
  802124:	89 d3                	mov    %edx,%ebx
  802126:	f7 24 24             	mull   (%esp)
  802129:	89 c6                	mov    %eax,%esi
  80212b:	89 d1                	mov    %edx,%ecx
  80212d:	39 d3                	cmp    %edx,%ebx
  80212f:	0f 82 87 00 00 00    	jb     8021bc <__umoddi3+0x134>
  802135:	0f 84 91 00 00 00    	je     8021cc <__umoddi3+0x144>
  80213b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80213f:	29 f2                	sub    %esi,%edx
  802141:	19 cb                	sbb    %ecx,%ebx
  802143:	89 d8                	mov    %ebx,%eax
  802145:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802149:	d3 e0                	shl    %cl,%eax
  80214b:	89 e9                	mov    %ebp,%ecx
  80214d:	d3 ea                	shr    %cl,%edx
  80214f:	09 d0                	or     %edx,%eax
  802151:	89 e9                	mov    %ebp,%ecx
  802153:	d3 eb                	shr    %cl,%ebx
  802155:	89 da                	mov    %ebx,%edx
  802157:	83 c4 1c             	add    $0x1c,%esp
  80215a:	5b                   	pop    %ebx
  80215b:	5e                   	pop    %esi
  80215c:	5f                   	pop    %edi
  80215d:	5d                   	pop    %ebp
  80215e:	c3                   	ret    
  80215f:	90                   	nop
  802160:	89 fd                	mov    %edi,%ebp
  802162:	85 ff                	test   %edi,%edi
  802164:	75 0b                	jne    802171 <__umoddi3+0xe9>
  802166:	b8 01 00 00 00       	mov    $0x1,%eax
  80216b:	31 d2                	xor    %edx,%edx
  80216d:	f7 f7                	div    %edi
  80216f:	89 c5                	mov    %eax,%ebp
  802171:	89 f0                	mov    %esi,%eax
  802173:	31 d2                	xor    %edx,%edx
  802175:	f7 f5                	div    %ebp
  802177:	89 c8                	mov    %ecx,%eax
  802179:	f7 f5                	div    %ebp
  80217b:	89 d0                	mov    %edx,%eax
  80217d:	e9 44 ff ff ff       	jmp    8020c6 <__umoddi3+0x3e>
  802182:	66 90                	xchg   %ax,%ax
  802184:	89 c8                	mov    %ecx,%eax
  802186:	89 f2                	mov    %esi,%edx
  802188:	83 c4 1c             	add    $0x1c,%esp
  80218b:	5b                   	pop    %ebx
  80218c:	5e                   	pop    %esi
  80218d:	5f                   	pop    %edi
  80218e:	5d                   	pop    %ebp
  80218f:	c3                   	ret    
  802190:	3b 04 24             	cmp    (%esp),%eax
  802193:	72 06                	jb     80219b <__umoddi3+0x113>
  802195:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802199:	77 0f                	ja     8021aa <__umoddi3+0x122>
  80219b:	89 f2                	mov    %esi,%edx
  80219d:	29 f9                	sub    %edi,%ecx
  80219f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021a3:	89 14 24             	mov    %edx,(%esp)
  8021a6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021aa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021ae:	8b 14 24             	mov    (%esp),%edx
  8021b1:	83 c4 1c             	add    $0x1c,%esp
  8021b4:	5b                   	pop    %ebx
  8021b5:	5e                   	pop    %esi
  8021b6:	5f                   	pop    %edi
  8021b7:	5d                   	pop    %ebp
  8021b8:	c3                   	ret    
  8021b9:	8d 76 00             	lea    0x0(%esi),%esi
  8021bc:	2b 04 24             	sub    (%esp),%eax
  8021bf:	19 fa                	sbb    %edi,%edx
  8021c1:	89 d1                	mov    %edx,%ecx
  8021c3:	89 c6                	mov    %eax,%esi
  8021c5:	e9 71 ff ff ff       	jmp    80213b <__umoddi3+0xb3>
  8021ca:	66 90                	xchg   %ax,%ax
  8021cc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021d0:	72 ea                	jb     8021bc <__umoddi3+0x134>
  8021d2:	89 d9                	mov    %ebx,%ecx
  8021d4:	e9 62 ff ff ff       	jmp    80213b <__umoddi3+0xb3>
