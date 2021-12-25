
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
  800087:	68 a0 22 80 00       	push   $0x8022a0
  80008c:	6a 13                	push   $0x13
  80008e:	68 bc 22 80 00       	push   $0x8022bc
  800093:	e8 26 04 00 00       	call   8004be <_panic>
	}
	uint32 *x, *y, *z ;

	//x: Readonly
	int freeFrames = sys_calculate_free_frames() ;
  800098:	e8 eb 19 00 00       	call   801a88 <sys_calculate_free_frames>
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	x = smalloc("x", 4, 0);
  8000a0:	83 ec 04             	sub    $0x4,%esp
  8000a3:	6a 00                	push   $0x0
  8000a5:	6a 04                	push   $0x4
  8000a7:	68 da 22 80 00       	push   $0x8022da
  8000ac:	e8 9a 17 00 00       	call   80184b <smalloc>
  8000b1:	83 c4 10             	add    $0x10,%esp
  8000b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
	if (x != (uint32*)USER_HEAP_START) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000b7:	81 7d e8 00 00 00 80 	cmpl   $0x80000000,-0x18(%ebp)
  8000be:	74 14                	je     8000d4 <_main+0x9c>
  8000c0:	83 ec 04             	sub    $0x4,%esp
  8000c3:	68 dc 22 80 00       	push   $0x8022dc
  8000c8:	6a 1a                	push   $0x1a
  8000ca:	68 bc 22 80 00       	push   $0x8022bc
  8000cf:	e8 ea 03 00 00       	call   8004be <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage %d %d %d", freeFrames, sys_calculate_free_frames(), freeFrames - sys_calculate_free_frames());
  8000d4:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000d7:	e8 ac 19 00 00       	call   801a88 <sys_calculate_free_frames>
  8000dc:	29 c3                	sub    %eax,%ebx
  8000de:	89 d8                	mov    %ebx,%eax
  8000e0:	83 f8 04             	cmp    $0x4,%eax
  8000e3:	74 28                	je     80010d <_main+0xd5>
  8000e5:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000e8:	e8 9b 19 00 00       	call   801a88 <sys_calculate_free_frames>
  8000ed:	29 c3                	sub    %eax,%ebx
  8000ef:	e8 94 19 00 00       	call   801a88 <sys_calculate_free_frames>
  8000f4:	83 ec 08             	sub    $0x8,%esp
  8000f7:	53                   	push   %ebx
  8000f8:	50                   	push   %eax
  8000f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000fc:	68 40 23 80 00       	push   $0x802340
  800101:	6a 1b                	push   $0x1b
  800103:	68 bc 22 80 00       	push   $0x8022bc
  800108:	e8 b1 03 00 00       	call   8004be <_panic>

	//y: Readonly
	freeFrames = sys_calculate_free_frames() ;
  80010d:	e8 76 19 00 00       	call   801a88 <sys_calculate_free_frames>
  800112:	89 45 ec             	mov    %eax,-0x14(%ebp)
	y = smalloc("y", 4, 0);
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	6a 00                	push   $0x0
  80011a:	6a 04                	push   $0x4
  80011c:	68 d1 23 80 00       	push   $0x8023d1
  800121:	e8 25 17 00 00       	call   80184b <smalloc>
  800126:	83 c4 10             	add    $0x10,%esp
  800129:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (y != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  80012c:	81 7d e4 00 10 00 80 	cmpl   $0x80001000,-0x1c(%ebp)
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 dc 22 80 00       	push   $0x8022dc
  80013d:	6a 20                	push   $0x20
  80013f:	68 bc 22 80 00       	push   $0x8022bc
  800144:	e8 75 03 00 00       	call   8004be <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage %d %d %d", freeFrames, sys_calculate_free_frames(), freeFrames - sys_calculate_free_frames());
  800149:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80014c:	e8 37 19 00 00       	call   801a88 <sys_calculate_free_frames>
  800151:	29 c3                	sub    %eax,%ebx
  800153:	89 d8                	mov    %ebx,%eax
  800155:	83 f8 03             	cmp    $0x3,%eax
  800158:	74 28                	je     800182 <_main+0x14a>
  80015a:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80015d:	e8 26 19 00 00       	call   801a88 <sys_calculate_free_frames>
  800162:	29 c3                	sub    %eax,%ebx
  800164:	e8 1f 19 00 00       	call   801a88 <sys_calculate_free_frames>
  800169:	83 ec 08             	sub    $0x8,%esp
  80016c:	53                   	push   %ebx
  80016d:	50                   	push   %eax
  80016e:	ff 75 ec             	pushl  -0x14(%ebp)
  800171:	68 40 23 80 00       	push   $0x802340
  800176:	6a 21                	push   $0x21
  800178:	68 bc 22 80 00       	push   $0x8022bc
  80017d:	e8 3c 03 00 00       	call   8004be <_panic>

	//z: Writable
	freeFrames = sys_calculate_free_frames() ;
  800182:	e8 01 19 00 00       	call   801a88 <sys_calculate_free_frames>
  800187:	89 45 ec             	mov    %eax,-0x14(%ebp)
	z = smalloc("z", 4, 1);
  80018a:	83 ec 04             	sub    $0x4,%esp
  80018d:	6a 01                	push   $0x1
  80018f:	6a 04                	push   $0x4
  800191:	68 d3 23 80 00       	push   $0x8023d3
  800196:	e8 b0 16 00 00       	call   80184b <smalloc>
  80019b:	83 c4 10             	add    $0x10,%esp
  80019e:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 2 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8001a1:	81 7d e0 00 20 00 80 	cmpl   $0x80002000,-0x20(%ebp)
  8001a8:	74 14                	je     8001be <_main+0x186>
  8001aa:	83 ec 04             	sub    $0x4,%esp
  8001ad:	68 dc 22 80 00       	push   $0x8022dc
  8001b2:	6a 26                	push   $0x26
  8001b4:	68 bc 22 80 00       	push   $0x8022bc
  8001b9:	e8 00 03 00 00       	call   8004be <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8001be:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8001c1:	e8 c2 18 00 00       	call   801a88 <sys_calculate_free_frames>
  8001c6:	29 c3                	sub    %eax,%ebx
  8001c8:	89 d8                	mov    %ebx,%eax
  8001ca:	83 f8 03             	cmp    $0x3,%eax
  8001cd:	74 14                	je     8001e3 <_main+0x1ab>
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	68 d8 23 80 00       	push   $0x8023d8
  8001d7:	6a 27                	push   $0x27
  8001d9:	68 bc 22 80 00       	push   $0x8022bc
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
  80020e:	68 60 24 80 00       	push   $0x802460
  800213:	e8 c5 1a 00 00       	call   801cdd <sys_create_env>
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
  800237:	68 60 24 80 00       	push   $0x802460
  80023c:	e8 9c 1a 00 00       	call   801cdd <sys_create_env>
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
  800260:	68 60 24 80 00       	push   $0x802460
  800265:	e8 73 1a 00 00       	call   801cdd <sys_create_env>
  80026a:	83 c4 10             	add    $0x10,%esp
  80026d:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//to check that the slave environments completed successfully
	rsttst();
  800270:	e8 50 1b 00 00       	call   801dc5 <rsttst>

	int* finish_children = smalloc("finish_children", sizeof(int), 1);
  800275:	83 ec 04             	sub    $0x4,%esp
  800278:	6a 01                	push   $0x1
  80027a:	6a 04                	push   $0x4
  80027c:	68 6e 24 80 00       	push   $0x80246e
  800281:	e8 c5 15 00 00       	call   80184b <smalloc>
  800286:	83 c4 10             	add    $0x10,%esp
  800289:	89 45 d0             	mov    %eax,-0x30(%ebp)

	sys_run_env(id1);
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	ff 75 dc             	pushl  -0x24(%ebp)
  800292:	e8 64 1a 00 00       	call   801cfb <sys_run_env>
  800297:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	ff 75 d8             	pushl  -0x28(%ebp)
  8002a0:	e8 56 1a 00 00       	call   801cfb <sys_run_env>
  8002a5:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  8002a8:	83 ec 0c             	sub    $0xc,%esp
  8002ab:	ff 75 d4             	pushl  -0x2c(%ebp)
  8002ae:	e8 48 1a 00 00       	call   801cfb <sys_run_env>
  8002b3:	83 c4 10             	add    $0x10,%esp

	env_sleep(15000) ;
  8002b6:	83 ec 0c             	sub    $0xc,%esp
  8002b9:	68 98 3a 00 00       	push   $0x3a98
  8002be:	e8 b6 1c 00 00       	call   801f79 <env_sleep>
  8002c3:	83 c4 10             	add    $0x10,%esp

	//to ensure that the slave environments completed successfully
	if (gettst()!=3) panic("test failed");
  8002c6:	e8 74 1b 00 00       	call   801e3f <gettst>
  8002cb:	83 f8 03             	cmp    $0x3,%eax
  8002ce:	74 14                	je     8002e4 <_main+0x2ac>
  8002d0:	83 ec 04             	sub    $0x4,%esp
  8002d3:	68 7e 24 80 00       	push   $0x80247e
  8002d8:	6a 3d                	push   $0x3d
  8002da:	68 bc 22 80 00       	push   $0x8022bc
  8002df:	e8 da 01 00 00       	call   8004be <_panic>


	if (*z != 30)
  8002e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e7:	8b 00                	mov    (%eax),%eax
  8002e9:	83 f8 1e             	cmp    $0x1e,%eax
  8002ec:	74 14                	je     800302 <_main+0x2ca>
		panic("Error!! Please check the creation (or the getting) of shared 2variables!!\n\n\n");
  8002ee:	83 ec 04             	sub    $0x4,%esp
  8002f1:	68 8c 24 80 00       	push   $0x80248c
  8002f6:	6a 41                	push   $0x41
  8002f8:	68 bc 22 80 00       	push   $0x8022bc
  8002fd:	e8 bc 01 00 00       	call   8004be <_panic>
	else
		cprintf("Congratulations!! Test of Shared Variables [Create & Get] [2] completed successfully!!\n\n\n");
  800302:	83 ec 0c             	sub    $0xc,%esp
  800305:	68 dc 24 80 00       	push   $0x8024dc
  80030a:	e8 51 04 00 00       	call   800760 <cprintf>
  80030f:	83 c4 10             	add    $0x10,%esp


	if (sys_getparentenvid() > 0) {
  800312:	e8 bf 16 00 00       	call   8019d6 <sys_getparentenvid>
  800317:	85 c0                	test   %eax,%eax
  800319:	7e 58                	jle    800373 <_main+0x33b>
		sys_free_env(id1);
  80031b:	83 ec 0c             	sub    $0xc,%esp
  80031e:	ff 75 dc             	pushl  -0x24(%ebp)
  800321:	e8 f1 19 00 00       	call   801d17 <sys_free_env>
  800326:	83 c4 10             	add    $0x10,%esp
		sys_free_env(id2);
  800329:	83 ec 0c             	sub    $0xc,%esp
  80032c:	ff 75 d8             	pushl  -0x28(%ebp)
  80032f:	e8 e3 19 00 00       	call   801d17 <sys_free_env>
  800334:	83 c4 10             	add    $0x10,%esp
		sys_free_env(id3);
  800337:	83 ec 0c             	sub    $0xc,%esp
  80033a:	ff 75 d4             	pushl  -0x2c(%ebp)
  80033d:	e8 d5 19 00 00       	call   801d17 <sys_free_env>
  800342:	83 c4 10             	add    $0x10,%esp
		int *finishedCount = NULL;
  800345:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
		finishedCount = sget(sys_getparentenvid(), "finishedCount") ;
  80034c:	e8 85 16 00 00       	call   8019d6 <sys_getparentenvid>
  800351:	83 ec 08             	sub    $0x8,%esp
  800354:	68 36 25 80 00       	push   $0x802536
  800359:	50                   	push   %eax
  80035a:	e8 0f 15 00 00       	call   80186e <sget>
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
  80037f:	e8 39 16 00 00       	call   8019bd <sys_getenvindex>
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
  8003fc:	e8 57 17 00 00       	call   801b58 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800401:	83 ec 0c             	sub    $0xc,%esp
  800404:	68 5c 25 80 00       	push   $0x80255c
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
  80042c:	68 84 25 80 00       	push   $0x802584
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
  800454:	68 ac 25 80 00       	push   $0x8025ac
  800459:	e8 02 03 00 00       	call   800760 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800461:	a1 20 30 80 00       	mov    0x803020,%eax
  800466:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80046c:	83 ec 08             	sub    $0x8,%esp
  80046f:	50                   	push   %eax
  800470:	68 ed 25 80 00       	push   $0x8025ed
  800475:	e8 e6 02 00 00       	call   800760 <cprintf>
  80047a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80047d:	83 ec 0c             	sub    $0xc,%esp
  800480:	68 5c 25 80 00       	push   $0x80255c
  800485:	e8 d6 02 00 00       	call   800760 <cprintf>
  80048a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80048d:	e8 e0 16 00 00       	call   801b72 <sys_enable_interrupt>

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
  8004a5:	e8 df 14 00 00       	call   801989 <sys_env_destroy>
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
  8004b6:	e8 34 15 00 00       	call   8019ef <sys_env_exit>
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
  8004df:	68 04 26 80 00       	push   $0x802604
  8004e4:	e8 77 02 00 00       	call   800760 <cprintf>
  8004e9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004ec:	a1 00 30 80 00       	mov    0x803000,%eax
  8004f1:	ff 75 0c             	pushl  0xc(%ebp)
  8004f4:	ff 75 08             	pushl  0x8(%ebp)
  8004f7:	50                   	push   %eax
  8004f8:	68 09 26 80 00       	push   $0x802609
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
  80051c:	68 25 26 80 00       	push   $0x802625
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
  800548:	68 28 26 80 00       	push   $0x802628
  80054d:	6a 26                	push   $0x26
  80054f:	68 74 26 80 00       	push   $0x802674
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
  80060e:	68 80 26 80 00       	push   $0x802680
  800613:	6a 3a                	push   $0x3a
  800615:	68 74 26 80 00       	push   $0x802674
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
  800678:	68 d4 26 80 00       	push   $0x8026d4
  80067d:	6a 44                	push   $0x44
  80067f:	68 74 26 80 00       	push   $0x802674
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
  8006d2:	e8 70 12 00 00       	call   801947 <sys_cputs>
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
  800749:	e8 f9 11 00 00       	call   801947 <sys_cputs>
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
  800793:	e8 c0 13 00 00       	call   801b58 <sys_disable_interrupt>
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
  8007b3:	e8 ba 13 00 00       	call   801b72 <sys_enable_interrupt>
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
  8007fd:	e8 2e 18 00 00       	call   802030 <__udivdi3>
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
  80084d:	e8 ee 18 00 00       	call   802140 <__umoddi3>
  800852:	83 c4 10             	add    $0x10,%esp
  800855:	05 34 29 80 00       	add    $0x802934,%eax
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
  8009a8:	8b 04 85 58 29 80 00 	mov    0x802958(,%eax,4),%eax
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
  800a89:	8b 34 9d a0 27 80 00 	mov    0x8027a0(,%ebx,4),%esi
  800a90:	85 f6                	test   %esi,%esi
  800a92:	75 19                	jne    800aad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a94:	53                   	push   %ebx
  800a95:	68 45 29 80 00       	push   $0x802945
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
  800aae:	68 4e 29 80 00       	push   $0x80294e
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
  800adb:	be 51 29 80 00       	mov    $0x802951,%esi
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
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  8014f0:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  8014f7:	76 0a                	jbe    801503 <malloc+0x19>
		return NULL;
  8014f9:	b8 00 00 00 00       	mov    $0x0,%eax
  8014fe:	e9 ad 02 00 00       	jmp    8017b0 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	c1 e8 0c             	shr    $0xc,%eax
  801509:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  80150c:	8b 45 08             	mov    0x8(%ebp),%eax
  80150f:	25 ff 0f 00 00       	and    $0xfff,%eax
  801514:	85 c0                	test   %eax,%eax
  801516:	74 03                	je     80151b <malloc+0x31>
		num++;
  801518:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  80151b:	a1 28 30 80 00       	mov    0x803028,%eax
  801520:	85 c0                	test   %eax,%eax
  801522:	75 71                	jne    801595 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801524:	a1 04 30 80 00       	mov    0x803004,%eax
  801529:	83 ec 08             	sub    $0x8,%esp
  80152c:	ff 75 08             	pushl  0x8(%ebp)
  80152f:	50                   	push   %eax
  801530:	e8 ba 05 00 00       	call   801aef <sys_allocateMem>
  801535:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801538:	a1 04 30 80 00       	mov    0x803004,%eax
  80153d:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801540:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801543:	c1 e0 0c             	shl    $0xc,%eax
  801546:	89 c2                	mov    %eax,%edx
  801548:	a1 04 30 80 00       	mov    0x803004,%eax
  80154d:	01 d0                	add    %edx,%eax
  80154f:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801554:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801559:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80155c:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801563:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801568:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80156b:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801572:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801577:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  80157e:	01 00 00 00 
		sizeofarray++;
  801582:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801587:	40                   	inc    %eax
  801588:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  80158d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801590:	e9 1b 02 00 00       	jmp    8017b0 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801595:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  80159c:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8015a3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  8015aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8015b1:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8015b8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8015bf:	eb 72                	jmp    801633 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8015c1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8015c4:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8015cb:	85 c0                	test   %eax,%eax
  8015cd:	75 12                	jne    8015e1 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8015cf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8015d2:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8015d9:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  8015dc:	ff 45 dc             	incl   -0x24(%ebp)
  8015df:	eb 4f                	jmp    801630 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  8015e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8015e7:	7d 39                	jge    801622 <malloc+0x138>
  8015e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ef:	7c 31                	jl     801622 <malloc+0x138>
					{
						min=count;
  8015f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  8015f7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8015fa:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801601:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801604:	c1 e2 0c             	shl    $0xc,%edx
  801607:	29 d0                	sub    %edx,%eax
  801609:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  80160c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80160f:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801615:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  80161c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80161f:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801622:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801629:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801630:	ff 45 d4             	incl   -0x2c(%ebp)
  801633:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801638:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  80163b:	7c 84                	jl     8015c1 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  80163d:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801641:	0f 85 e3 00 00 00    	jne    80172a <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801647:	83 ec 08             	sub    $0x8,%esp
  80164a:	ff 75 08             	pushl  0x8(%ebp)
  80164d:	ff 75 e0             	pushl  -0x20(%ebp)
  801650:	e8 9a 04 00 00       	call   801aef <sys_allocateMem>
  801655:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801658:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80165d:	40                   	inc    %eax
  80165e:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  801663:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801668:	48                   	dec    %eax
  801669:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80166c:	eb 42                	jmp    8016b0 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  80166e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801671:	48                   	dec    %eax
  801672:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801679:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80167c:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801683:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801686:	48                   	dec    %eax
  801687:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  80168e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801691:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801698:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80169b:	48                   	dec    %eax
  80169c:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  8016a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8016a6:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  8016ad:	ff 4d d0             	decl   -0x30(%ebp)
  8016b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8016b3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8016b6:	7f b6                	jg     80166e <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8016b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8016bb:	40                   	inc    %eax
  8016bc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8016bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8016c2:	01 ca                	add    %ecx,%edx
  8016c4:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8016cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8016ce:	8d 50 01             	lea    0x1(%eax),%edx
  8016d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8016d4:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8016db:	2b 45 f4             	sub    -0xc(%ebp),%eax
  8016de:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  8016e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8016e8:	40                   	inc    %eax
  8016e9:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  8016f0:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  8016f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8016f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016fa:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801701:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801704:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801707:	eb 11                	jmp    80171a <malloc+0x230>
				{
					changed[index] = 1;
  801709:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80170c:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801713:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801717:	ff 45 cc             	incl   -0x34(%ebp)
  80171a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80171d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801720:	7c e7                	jl     801709 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801722:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801725:	e9 86 00 00 00       	jmp    8017b0 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  80172a:	a1 04 30 80 00       	mov    0x803004,%eax
  80172f:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801734:	29 c2                	sub    %eax,%edx
  801736:	89 d0                	mov    %edx,%eax
  801738:	3b 45 08             	cmp    0x8(%ebp),%eax
  80173b:	73 07                	jae    801744 <malloc+0x25a>
						return NULL;
  80173d:	b8 00 00 00 00       	mov    $0x0,%eax
  801742:	eb 6c                	jmp    8017b0 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801744:	a1 04 30 80 00       	mov    0x803004,%eax
  801749:	83 ec 08             	sub    $0x8,%esp
  80174c:	ff 75 08             	pushl  0x8(%ebp)
  80174f:	50                   	push   %eax
  801750:	e8 9a 03 00 00       	call   801aef <sys_allocateMem>
  801755:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801758:	a1 04 30 80 00       	mov    0x803004,%eax
  80175d:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801760:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801763:	c1 e0 0c             	shl    $0xc,%eax
  801766:	89 c2                	mov    %eax,%edx
  801768:	a1 04 30 80 00       	mov    0x803004,%eax
  80176d:	01 d0                	add    %edx,%eax
  80176f:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801774:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801779:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80177c:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801783:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801788:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80178b:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801792:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801797:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  80179e:	01 00 00 00 
					sizeofarray++;
  8017a2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017a7:	40                   	inc    %eax
  8017a8:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  8017ad:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
  8017b5:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8017b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8017be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8017c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8017cc:	eb 30                	jmp    8017fe <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8017ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017d1:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8017d8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8017db:	75 1e                	jne    8017fb <free+0x49>
  8017dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017e0:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8017e7:	83 f8 01             	cmp    $0x1,%eax
  8017ea:	75 0f                	jne    8017fb <free+0x49>
			is_found = 1;
  8017ec:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8017f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8017f9:	eb 0d                	jmp    801808 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8017fb:	ff 45 ec             	incl   -0x14(%ebp)
  8017fe:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801803:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801806:	7c c6                	jl     8017ce <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801808:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  80180c:	75 3a                	jne    801848 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  80180e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801811:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801818:	c1 e0 0c             	shl    $0xc,%eax
  80181b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  80181e:	83 ec 08             	sub    $0x8,%esp
  801821:	ff 75 e4             	pushl  -0x1c(%ebp)
  801824:	ff 75 e8             	pushl  -0x18(%ebp)
  801827:	e8 a7 02 00 00       	call   801ad3 <sys_freeMem>
  80182c:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  80182f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801832:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801839:	00 00 00 00 
		changes++;
  80183d:	a1 28 30 80 00       	mov    0x803028,%eax
  801842:	40                   	inc    %eax
  801843:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801848:	90                   	nop
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
  80184e:	83 ec 18             	sub    $0x18,%esp
  801851:	8b 45 10             	mov    0x10(%ebp),%eax
  801854:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801857:	83 ec 04             	sub    $0x4,%esp
  80185a:	68 b0 2a 80 00       	push   $0x802ab0
  80185f:	68 b6 00 00 00       	push   $0xb6
  801864:	68 d3 2a 80 00       	push   $0x802ad3
  801869:	e8 50 ec ff ff       	call   8004be <_panic>

0080186e <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
  801871:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801874:	83 ec 04             	sub    $0x4,%esp
  801877:	68 b0 2a 80 00       	push   $0x802ab0
  80187c:	68 bb 00 00 00       	push   $0xbb
  801881:	68 d3 2a 80 00       	push   $0x802ad3
  801886:	e8 33 ec ff ff       	call   8004be <_panic>

0080188b <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
  80188e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801891:	83 ec 04             	sub    $0x4,%esp
  801894:	68 b0 2a 80 00       	push   $0x802ab0
  801899:	68 c0 00 00 00       	push   $0xc0
  80189e:	68 d3 2a 80 00       	push   $0x802ad3
  8018a3:	e8 16 ec ff ff       	call   8004be <_panic>

008018a8 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8018a8:	55                   	push   %ebp
  8018a9:	89 e5                	mov    %esp,%ebp
  8018ab:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018ae:	83 ec 04             	sub    $0x4,%esp
  8018b1:	68 b0 2a 80 00       	push   $0x802ab0
  8018b6:	68 c4 00 00 00       	push   $0xc4
  8018bb:	68 d3 2a 80 00       	push   $0x802ad3
  8018c0:	e8 f9 eb ff ff       	call   8004be <_panic>

008018c5 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
  8018c8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018cb:	83 ec 04             	sub    $0x4,%esp
  8018ce:	68 b0 2a 80 00       	push   $0x802ab0
  8018d3:	68 c9 00 00 00       	push   $0xc9
  8018d8:	68 d3 2a 80 00       	push   $0x802ad3
  8018dd:	e8 dc eb ff ff       	call   8004be <_panic>

008018e2 <shrink>:
}
void shrink(uint32 newSize) {
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
  8018e5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018e8:	83 ec 04             	sub    $0x4,%esp
  8018eb:	68 b0 2a 80 00       	push   $0x802ab0
  8018f0:	68 cc 00 00 00       	push   $0xcc
  8018f5:	68 d3 2a 80 00       	push   $0x802ad3
  8018fa:	e8 bf eb ff ff       	call   8004be <_panic>

008018ff <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8018ff:	55                   	push   %ebp
  801900:	89 e5                	mov    %esp,%ebp
  801902:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801905:	83 ec 04             	sub    $0x4,%esp
  801908:	68 b0 2a 80 00       	push   $0x802ab0
  80190d:	68 d0 00 00 00       	push   $0xd0
  801912:	68 d3 2a 80 00       	push   $0x802ad3
  801917:	e8 a2 eb ff ff       	call   8004be <_panic>

0080191c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
  80191f:	57                   	push   %edi
  801920:	56                   	push   %esi
  801921:	53                   	push   %ebx
  801922:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80192e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801931:	8b 7d 18             	mov    0x18(%ebp),%edi
  801934:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801937:	cd 30                	int    $0x30
  801939:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80193c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80193f:	83 c4 10             	add    $0x10,%esp
  801942:	5b                   	pop    %ebx
  801943:	5e                   	pop    %esi
  801944:	5f                   	pop    %edi
  801945:	5d                   	pop    %ebp
  801946:	c3                   	ret    

00801947 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801947:	55                   	push   %ebp
  801948:	89 e5                	mov    %esp,%ebp
  80194a:	83 ec 04             	sub    $0x4,%esp
  80194d:	8b 45 10             	mov    0x10(%ebp),%eax
  801950:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801953:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801957:	8b 45 08             	mov    0x8(%ebp),%eax
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	52                   	push   %edx
  80195f:	ff 75 0c             	pushl  0xc(%ebp)
  801962:	50                   	push   %eax
  801963:	6a 00                	push   $0x0
  801965:	e8 b2 ff ff ff       	call   80191c <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	90                   	nop
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_cgetc>:

int
sys_cgetc(void)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 01                	push   $0x1
  80197f:	e8 98 ff ff ff       	call   80191c <syscall>
  801984:	83 c4 18             	add    $0x18,%esp
}
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80198c:	8b 45 08             	mov    0x8(%ebp),%eax
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	50                   	push   %eax
  801998:	6a 05                	push   $0x5
  80199a:	e8 7d ff ff ff       	call   80191c <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 02                	push   $0x2
  8019b3:	e8 64 ff ff ff       	call   80191c <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 03                	push   $0x3
  8019cc:	e8 4b ff ff ff       	call   80191c <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 04                	push   $0x4
  8019e5:	e8 32 ff ff ff       	call   80191c <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
}
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <sys_env_exit>:


void sys_env_exit(void)
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 06                	push   $0x6
  8019fe:	e8 19 ff ff ff       	call   80191c <syscall>
  801a03:	83 c4 18             	add    $0x18,%esp
}
  801a06:	90                   	nop
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	52                   	push   %edx
  801a19:	50                   	push   %eax
  801a1a:	6a 07                	push   $0x7
  801a1c:	e8 fb fe ff ff       	call   80191c <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
  801a29:	56                   	push   %esi
  801a2a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a2b:	8b 75 18             	mov    0x18(%ebp),%esi
  801a2e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a31:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a37:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3a:	56                   	push   %esi
  801a3b:	53                   	push   %ebx
  801a3c:	51                   	push   %ecx
  801a3d:	52                   	push   %edx
  801a3e:	50                   	push   %eax
  801a3f:	6a 08                	push   $0x8
  801a41:	e8 d6 fe ff ff       	call   80191c <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a4c:	5b                   	pop    %ebx
  801a4d:	5e                   	pop    %esi
  801a4e:	5d                   	pop    %ebp
  801a4f:	c3                   	ret    

00801a50 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a56:	8b 45 08             	mov    0x8(%ebp),%eax
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	52                   	push   %edx
  801a60:	50                   	push   %eax
  801a61:	6a 09                	push   $0x9
  801a63:	e8 b4 fe ff ff       	call   80191c <syscall>
  801a68:	83 c4 18             	add    $0x18,%esp
}
  801a6b:	c9                   	leave  
  801a6c:	c3                   	ret    

00801a6d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	ff 75 0c             	pushl  0xc(%ebp)
  801a79:	ff 75 08             	pushl  0x8(%ebp)
  801a7c:	6a 0a                	push   $0xa
  801a7e:	e8 99 fe ff ff       	call   80191c <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 0b                	push   $0xb
  801a97:	e8 80 fe ff ff       	call   80191c <syscall>
  801a9c:	83 c4 18             	add    $0x18,%esp
}
  801a9f:	c9                   	leave  
  801aa0:	c3                   	ret    

00801aa1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801aa1:	55                   	push   %ebp
  801aa2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 0c                	push   $0xc
  801ab0:	e8 67 fe ff ff       	call   80191c <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
}
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 0d                	push   $0xd
  801ac9:	e8 4e fe ff ff       	call   80191c <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	ff 75 0c             	pushl  0xc(%ebp)
  801adf:	ff 75 08             	pushl  0x8(%ebp)
  801ae2:	6a 11                	push   $0x11
  801ae4:	e8 33 fe ff ff       	call   80191c <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
	return;
  801aec:	90                   	nop
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	ff 75 0c             	pushl  0xc(%ebp)
  801afb:	ff 75 08             	pushl  0x8(%ebp)
  801afe:	6a 12                	push   $0x12
  801b00:	e8 17 fe ff ff       	call   80191c <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
	return ;
  801b08:	90                   	nop
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 0e                	push   $0xe
  801b1a:	e8 fd fd ff ff       	call   80191c <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
}
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	ff 75 08             	pushl  0x8(%ebp)
  801b32:	6a 0f                	push   $0xf
  801b34:	e8 e3 fd ff ff       	call   80191c <syscall>
  801b39:	83 c4 18             	add    $0x18,%esp
}
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    

00801b3e <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 10                	push   $0x10
  801b4d:	e8 ca fd ff ff       	call   80191c <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
}
  801b55:	90                   	nop
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 14                	push   $0x14
  801b67:	e8 b0 fd ff ff       	call   80191c <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
}
  801b6f:	90                   	nop
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 15                	push   $0x15
  801b81:	e8 96 fd ff ff       	call   80191c <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	90                   	nop
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <sys_cputc>:


void
sys_cputc(const char c)
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
  801b8f:	83 ec 04             	sub    $0x4,%esp
  801b92:	8b 45 08             	mov    0x8(%ebp),%eax
  801b95:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	50                   	push   %eax
  801ba5:	6a 16                	push   $0x16
  801ba7:	e8 70 fd ff ff       	call   80191c <syscall>
  801bac:	83 c4 18             	add    $0x18,%esp
}
  801baf:	90                   	nop
  801bb0:	c9                   	leave  
  801bb1:	c3                   	ret    

00801bb2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801bb2:	55                   	push   %ebp
  801bb3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 17                	push   $0x17
  801bc1:	e8 56 fd ff ff       	call   80191c <syscall>
  801bc6:	83 c4 18             	add    $0x18,%esp
}
  801bc9:	90                   	nop
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	ff 75 0c             	pushl  0xc(%ebp)
  801bdb:	50                   	push   %eax
  801bdc:	6a 18                	push   $0x18
  801bde:	e8 39 fd ff ff       	call   80191c <syscall>
  801be3:	83 c4 18             	add    $0x18,%esp
}
  801be6:	c9                   	leave  
  801be7:	c3                   	ret    

00801be8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801be8:	55                   	push   %ebp
  801be9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801beb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bee:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	52                   	push   %edx
  801bf8:	50                   	push   %eax
  801bf9:	6a 1b                	push   $0x1b
  801bfb:	e8 1c fd ff ff       	call   80191c <syscall>
  801c00:	83 c4 18             	add    $0x18,%esp
}
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	52                   	push   %edx
  801c15:	50                   	push   %eax
  801c16:	6a 19                	push   $0x19
  801c18:	e8 ff fc ff ff       	call   80191c <syscall>
  801c1d:	83 c4 18             	add    $0x18,%esp
}
  801c20:	90                   	nop
  801c21:	c9                   	leave  
  801c22:	c3                   	ret    

00801c23 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c29:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	52                   	push   %edx
  801c33:	50                   	push   %eax
  801c34:	6a 1a                	push   $0x1a
  801c36:	e8 e1 fc ff ff       	call   80191c <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
}
  801c3e:	90                   	nop
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
  801c44:	83 ec 04             	sub    $0x4,%esp
  801c47:	8b 45 10             	mov    0x10(%ebp),%eax
  801c4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c4d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c50:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c54:	8b 45 08             	mov    0x8(%ebp),%eax
  801c57:	6a 00                	push   $0x0
  801c59:	51                   	push   %ecx
  801c5a:	52                   	push   %edx
  801c5b:	ff 75 0c             	pushl  0xc(%ebp)
  801c5e:	50                   	push   %eax
  801c5f:	6a 1c                	push   $0x1c
  801c61:	e8 b6 fc ff ff       	call   80191c <syscall>
  801c66:	83 c4 18             	add    $0x18,%esp
}
  801c69:	c9                   	leave  
  801c6a:	c3                   	ret    

00801c6b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c6b:	55                   	push   %ebp
  801c6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c71:	8b 45 08             	mov    0x8(%ebp),%eax
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	52                   	push   %edx
  801c7b:	50                   	push   %eax
  801c7c:	6a 1d                	push   $0x1d
  801c7e:	e8 99 fc ff ff       	call   80191c <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
}
  801c86:	c9                   	leave  
  801c87:	c3                   	ret    

00801c88 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	51                   	push   %ecx
  801c99:	52                   	push   %edx
  801c9a:	50                   	push   %eax
  801c9b:	6a 1e                	push   $0x1e
  801c9d:	e8 7a fc ff ff       	call   80191c <syscall>
  801ca2:	83 c4 18             	add    $0x18,%esp
}
  801ca5:	c9                   	leave  
  801ca6:	c3                   	ret    

00801ca7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ca7:	55                   	push   %ebp
  801ca8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801caa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cad:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	52                   	push   %edx
  801cb7:	50                   	push   %eax
  801cb8:	6a 1f                	push   $0x1f
  801cba:	e8 5d fc ff ff       	call   80191c <syscall>
  801cbf:	83 c4 18             	add    $0x18,%esp
}
  801cc2:	c9                   	leave  
  801cc3:	c3                   	ret    

00801cc4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801cc4:	55                   	push   %ebp
  801cc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 20                	push   $0x20
  801cd3:	e8 44 fc ff ff       	call   80191c <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce3:	6a 00                	push   $0x0
  801ce5:	ff 75 14             	pushl  0x14(%ebp)
  801ce8:	ff 75 10             	pushl  0x10(%ebp)
  801ceb:	ff 75 0c             	pushl  0xc(%ebp)
  801cee:	50                   	push   %eax
  801cef:	6a 21                	push   $0x21
  801cf1:	e8 26 fc ff ff       	call   80191c <syscall>
  801cf6:	83 c4 18             	add    $0x18,%esp
}
  801cf9:	c9                   	leave  
  801cfa:	c3                   	ret    

00801cfb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	50                   	push   %eax
  801d0a:	6a 22                	push   $0x22
  801d0c:	e8 0b fc ff ff       	call   80191c <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
}
  801d14:	90                   	nop
  801d15:	c9                   	leave  
  801d16:	c3                   	ret    

00801d17 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	50                   	push   %eax
  801d26:	6a 23                	push   $0x23
  801d28:	e8 ef fb ff ff       	call   80191c <syscall>
  801d2d:	83 c4 18             	add    $0x18,%esp
}
  801d30:	90                   	nop
  801d31:	c9                   	leave  
  801d32:	c3                   	ret    

00801d33 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
  801d36:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d39:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d3c:	8d 50 04             	lea    0x4(%eax),%edx
  801d3f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	52                   	push   %edx
  801d49:	50                   	push   %eax
  801d4a:	6a 24                	push   $0x24
  801d4c:	e8 cb fb ff ff       	call   80191c <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
	return result;
  801d54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d5d:	89 01                	mov    %eax,(%ecx)
  801d5f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d62:	8b 45 08             	mov    0x8(%ebp),%eax
  801d65:	c9                   	leave  
  801d66:	c2 04 00             	ret    $0x4

00801d69 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	ff 75 10             	pushl  0x10(%ebp)
  801d73:	ff 75 0c             	pushl  0xc(%ebp)
  801d76:	ff 75 08             	pushl  0x8(%ebp)
  801d79:	6a 13                	push   $0x13
  801d7b:	e8 9c fb ff ff       	call   80191c <syscall>
  801d80:	83 c4 18             	add    $0x18,%esp
	return ;
  801d83:	90                   	nop
}
  801d84:	c9                   	leave  
  801d85:	c3                   	ret    

00801d86 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d86:	55                   	push   %ebp
  801d87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 25                	push   $0x25
  801d95:	e8 82 fb ff ff       	call   80191c <syscall>
  801d9a:	83 c4 18             	add    $0x18,%esp
}
  801d9d:	c9                   	leave  
  801d9e:	c3                   	ret    

00801d9f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d9f:	55                   	push   %ebp
  801da0:	89 e5                	mov    %esp,%ebp
  801da2:	83 ec 04             	sub    $0x4,%esp
  801da5:	8b 45 08             	mov    0x8(%ebp),%eax
  801da8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801dab:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	50                   	push   %eax
  801db8:	6a 26                	push   $0x26
  801dba:	e8 5d fb ff ff       	call   80191c <syscall>
  801dbf:	83 c4 18             	add    $0x18,%esp
	return ;
  801dc2:	90                   	nop
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <rsttst>:
void rsttst()
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 28                	push   $0x28
  801dd4:	e8 43 fb ff ff       	call   80191c <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
	return ;
  801ddc:	90                   	nop
}
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    

00801ddf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
  801de2:	83 ec 04             	sub    $0x4,%esp
  801de5:	8b 45 14             	mov    0x14(%ebp),%eax
  801de8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801deb:	8b 55 18             	mov    0x18(%ebp),%edx
  801dee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801df2:	52                   	push   %edx
  801df3:	50                   	push   %eax
  801df4:	ff 75 10             	pushl  0x10(%ebp)
  801df7:	ff 75 0c             	pushl  0xc(%ebp)
  801dfa:	ff 75 08             	pushl  0x8(%ebp)
  801dfd:	6a 27                	push   $0x27
  801dff:	e8 18 fb ff ff       	call   80191c <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
	return ;
  801e07:	90                   	nop
}
  801e08:	c9                   	leave  
  801e09:	c3                   	ret    

00801e0a <chktst>:
void chktst(uint32 n)
{
  801e0a:	55                   	push   %ebp
  801e0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	ff 75 08             	pushl  0x8(%ebp)
  801e18:	6a 29                	push   $0x29
  801e1a:	e8 fd fa ff ff       	call   80191c <syscall>
  801e1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e22:	90                   	nop
}
  801e23:	c9                   	leave  
  801e24:	c3                   	ret    

00801e25 <inctst>:

void inctst()
{
  801e25:	55                   	push   %ebp
  801e26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 2a                	push   $0x2a
  801e34:	e8 e3 fa ff ff       	call   80191c <syscall>
  801e39:	83 c4 18             	add    $0x18,%esp
	return ;
  801e3c:	90                   	nop
}
  801e3d:	c9                   	leave  
  801e3e:	c3                   	ret    

00801e3f <gettst>:
uint32 gettst()
{
  801e3f:	55                   	push   %ebp
  801e40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 2b                	push   $0x2b
  801e4e:	e8 c9 fa ff ff       	call   80191c <syscall>
  801e53:	83 c4 18             	add    $0x18,%esp
}
  801e56:	c9                   	leave  
  801e57:	c3                   	ret    

00801e58 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e58:	55                   	push   %ebp
  801e59:	89 e5                	mov    %esp,%ebp
  801e5b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 2c                	push   $0x2c
  801e6a:	e8 ad fa ff ff       	call   80191c <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
  801e72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e75:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e79:	75 07                	jne    801e82 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e7b:	b8 01 00 00 00       	mov    $0x1,%eax
  801e80:	eb 05                	jmp    801e87 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e82:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
  801e8c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 2c                	push   $0x2c
  801e9b:	e8 7c fa ff ff       	call   80191c <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
  801ea3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ea6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801eaa:	75 07                	jne    801eb3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801eac:	b8 01 00 00 00       	mov    $0x1,%eax
  801eb1:	eb 05                	jmp    801eb8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801eb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801eb8:	c9                   	leave  
  801eb9:	c3                   	ret    

00801eba <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801eba:	55                   	push   %ebp
  801ebb:	89 e5                	mov    %esp,%ebp
  801ebd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 2c                	push   $0x2c
  801ecc:	e8 4b fa ff ff       	call   80191c <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
  801ed4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ed7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801edb:	75 07                	jne    801ee4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801edd:	b8 01 00 00 00       	mov    $0x1,%eax
  801ee2:	eb 05                	jmp    801ee9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ee4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ee9:	c9                   	leave  
  801eea:	c3                   	ret    

00801eeb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801eeb:	55                   	push   %ebp
  801eec:	89 e5                	mov    %esp,%ebp
  801eee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 2c                	push   $0x2c
  801efd:	e8 1a fa ff ff       	call   80191c <syscall>
  801f02:	83 c4 18             	add    $0x18,%esp
  801f05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f08:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f0c:	75 07                	jne    801f15 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801f13:	eb 05                	jmp    801f1a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f15:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f1a:	c9                   	leave  
  801f1b:	c3                   	ret    

00801f1c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f1c:	55                   	push   %ebp
  801f1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	ff 75 08             	pushl  0x8(%ebp)
  801f2a:	6a 2d                	push   $0x2d
  801f2c:	e8 eb f9 ff ff       	call   80191c <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
	return ;
  801f34:	90                   	nop
}
  801f35:	c9                   	leave  
  801f36:	c3                   	ret    

00801f37 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f37:	55                   	push   %ebp
  801f38:	89 e5                	mov    %esp,%ebp
  801f3a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f3b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f3e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f44:	8b 45 08             	mov    0x8(%ebp),%eax
  801f47:	6a 00                	push   $0x0
  801f49:	53                   	push   %ebx
  801f4a:	51                   	push   %ecx
  801f4b:	52                   	push   %edx
  801f4c:	50                   	push   %eax
  801f4d:	6a 2e                	push   $0x2e
  801f4f:	e8 c8 f9 ff ff       	call   80191c <syscall>
  801f54:	83 c4 18             	add    $0x18,%esp
}
  801f57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f5a:	c9                   	leave  
  801f5b:	c3                   	ret    

00801f5c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801f5c:	55                   	push   %ebp
  801f5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801f5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f62:	8b 45 08             	mov    0x8(%ebp),%eax
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	52                   	push   %edx
  801f6c:	50                   	push   %eax
  801f6d:	6a 2f                	push   $0x2f
  801f6f:	e8 a8 f9 ff ff       	call   80191c <syscall>
  801f74:	83 c4 18             	add    $0x18,%esp
}
  801f77:	c9                   	leave  
  801f78:	c3                   	ret    

00801f79 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801f79:	55                   	push   %ebp
  801f7a:	89 e5                	mov    %esp,%ebp
  801f7c:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801f7f:	8b 55 08             	mov    0x8(%ebp),%edx
  801f82:	89 d0                	mov    %edx,%eax
  801f84:	c1 e0 02             	shl    $0x2,%eax
  801f87:	01 d0                	add    %edx,%eax
  801f89:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f90:	01 d0                	add    %edx,%eax
  801f92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f99:	01 d0                	add    %edx,%eax
  801f9b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801fa2:	01 d0                	add    %edx,%eax
  801fa4:	c1 e0 04             	shl    $0x4,%eax
  801fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801faa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801fb1:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801fb4:	83 ec 0c             	sub    $0xc,%esp
  801fb7:	50                   	push   %eax
  801fb8:	e8 76 fd ff ff       	call   801d33 <sys_get_virtual_time>
  801fbd:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801fc0:	eb 41                	jmp    802003 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801fc2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801fc5:	83 ec 0c             	sub    $0xc,%esp
  801fc8:	50                   	push   %eax
  801fc9:	e8 65 fd ff ff       	call   801d33 <sys_get_virtual_time>
  801fce:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801fd1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801fd4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801fd7:	29 c2                	sub    %eax,%edx
  801fd9:	89 d0                	mov    %edx,%eax
  801fdb:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801fde:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801fe1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fe4:	89 d1                	mov    %edx,%ecx
  801fe6:	29 c1                	sub    %eax,%ecx
  801fe8:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801feb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801fee:	39 c2                	cmp    %eax,%edx
  801ff0:	0f 97 c0             	seta   %al
  801ff3:	0f b6 c0             	movzbl %al,%eax
  801ff6:	29 c1                	sub    %eax,%ecx
  801ff8:	89 c8                	mov    %ecx,%eax
  801ffa:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801ffd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802000:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  802003:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802006:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802009:	72 b7                	jb     801fc2 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80200b:	90                   	nop
  80200c:	c9                   	leave  
  80200d:	c3                   	ret    

0080200e <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80200e:	55                   	push   %ebp
  80200f:	89 e5                	mov    %esp,%ebp
  802011:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802014:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80201b:	eb 03                	jmp    802020 <busy_wait+0x12>
  80201d:	ff 45 fc             	incl   -0x4(%ebp)
  802020:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802023:	3b 45 08             	cmp    0x8(%ebp),%eax
  802026:	72 f5                	jb     80201d <busy_wait+0xf>
	return i;
  802028:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80202b:	c9                   	leave  
  80202c:	c3                   	ret    
  80202d:	66 90                	xchg   %ax,%ax
  80202f:	90                   	nop

00802030 <__udivdi3>:
  802030:	55                   	push   %ebp
  802031:	57                   	push   %edi
  802032:	56                   	push   %esi
  802033:	53                   	push   %ebx
  802034:	83 ec 1c             	sub    $0x1c,%esp
  802037:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80203b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80203f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802043:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802047:	89 ca                	mov    %ecx,%edx
  802049:	89 f8                	mov    %edi,%eax
  80204b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80204f:	85 f6                	test   %esi,%esi
  802051:	75 2d                	jne    802080 <__udivdi3+0x50>
  802053:	39 cf                	cmp    %ecx,%edi
  802055:	77 65                	ja     8020bc <__udivdi3+0x8c>
  802057:	89 fd                	mov    %edi,%ebp
  802059:	85 ff                	test   %edi,%edi
  80205b:	75 0b                	jne    802068 <__udivdi3+0x38>
  80205d:	b8 01 00 00 00       	mov    $0x1,%eax
  802062:	31 d2                	xor    %edx,%edx
  802064:	f7 f7                	div    %edi
  802066:	89 c5                	mov    %eax,%ebp
  802068:	31 d2                	xor    %edx,%edx
  80206a:	89 c8                	mov    %ecx,%eax
  80206c:	f7 f5                	div    %ebp
  80206e:	89 c1                	mov    %eax,%ecx
  802070:	89 d8                	mov    %ebx,%eax
  802072:	f7 f5                	div    %ebp
  802074:	89 cf                	mov    %ecx,%edi
  802076:	89 fa                	mov    %edi,%edx
  802078:	83 c4 1c             	add    $0x1c,%esp
  80207b:	5b                   	pop    %ebx
  80207c:	5e                   	pop    %esi
  80207d:	5f                   	pop    %edi
  80207e:	5d                   	pop    %ebp
  80207f:	c3                   	ret    
  802080:	39 ce                	cmp    %ecx,%esi
  802082:	77 28                	ja     8020ac <__udivdi3+0x7c>
  802084:	0f bd fe             	bsr    %esi,%edi
  802087:	83 f7 1f             	xor    $0x1f,%edi
  80208a:	75 40                	jne    8020cc <__udivdi3+0x9c>
  80208c:	39 ce                	cmp    %ecx,%esi
  80208e:	72 0a                	jb     80209a <__udivdi3+0x6a>
  802090:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802094:	0f 87 9e 00 00 00    	ja     802138 <__udivdi3+0x108>
  80209a:	b8 01 00 00 00       	mov    $0x1,%eax
  80209f:	89 fa                	mov    %edi,%edx
  8020a1:	83 c4 1c             	add    $0x1c,%esp
  8020a4:	5b                   	pop    %ebx
  8020a5:	5e                   	pop    %esi
  8020a6:	5f                   	pop    %edi
  8020a7:	5d                   	pop    %ebp
  8020a8:	c3                   	ret    
  8020a9:	8d 76 00             	lea    0x0(%esi),%esi
  8020ac:	31 ff                	xor    %edi,%edi
  8020ae:	31 c0                	xor    %eax,%eax
  8020b0:	89 fa                	mov    %edi,%edx
  8020b2:	83 c4 1c             	add    $0x1c,%esp
  8020b5:	5b                   	pop    %ebx
  8020b6:	5e                   	pop    %esi
  8020b7:	5f                   	pop    %edi
  8020b8:	5d                   	pop    %ebp
  8020b9:	c3                   	ret    
  8020ba:	66 90                	xchg   %ax,%ax
  8020bc:	89 d8                	mov    %ebx,%eax
  8020be:	f7 f7                	div    %edi
  8020c0:	31 ff                	xor    %edi,%edi
  8020c2:	89 fa                	mov    %edi,%edx
  8020c4:	83 c4 1c             	add    $0x1c,%esp
  8020c7:	5b                   	pop    %ebx
  8020c8:	5e                   	pop    %esi
  8020c9:	5f                   	pop    %edi
  8020ca:	5d                   	pop    %ebp
  8020cb:	c3                   	ret    
  8020cc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020d1:	89 eb                	mov    %ebp,%ebx
  8020d3:	29 fb                	sub    %edi,%ebx
  8020d5:	89 f9                	mov    %edi,%ecx
  8020d7:	d3 e6                	shl    %cl,%esi
  8020d9:	89 c5                	mov    %eax,%ebp
  8020db:	88 d9                	mov    %bl,%cl
  8020dd:	d3 ed                	shr    %cl,%ebp
  8020df:	89 e9                	mov    %ebp,%ecx
  8020e1:	09 f1                	or     %esi,%ecx
  8020e3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020e7:	89 f9                	mov    %edi,%ecx
  8020e9:	d3 e0                	shl    %cl,%eax
  8020eb:	89 c5                	mov    %eax,%ebp
  8020ed:	89 d6                	mov    %edx,%esi
  8020ef:	88 d9                	mov    %bl,%cl
  8020f1:	d3 ee                	shr    %cl,%esi
  8020f3:	89 f9                	mov    %edi,%ecx
  8020f5:	d3 e2                	shl    %cl,%edx
  8020f7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020fb:	88 d9                	mov    %bl,%cl
  8020fd:	d3 e8                	shr    %cl,%eax
  8020ff:	09 c2                	or     %eax,%edx
  802101:	89 d0                	mov    %edx,%eax
  802103:	89 f2                	mov    %esi,%edx
  802105:	f7 74 24 0c          	divl   0xc(%esp)
  802109:	89 d6                	mov    %edx,%esi
  80210b:	89 c3                	mov    %eax,%ebx
  80210d:	f7 e5                	mul    %ebp
  80210f:	39 d6                	cmp    %edx,%esi
  802111:	72 19                	jb     80212c <__udivdi3+0xfc>
  802113:	74 0b                	je     802120 <__udivdi3+0xf0>
  802115:	89 d8                	mov    %ebx,%eax
  802117:	31 ff                	xor    %edi,%edi
  802119:	e9 58 ff ff ff       	jmp    802076 <__udivdi3+0x46>
  80211e:	66 90                	xchg   %ax,%ax
  802120:	8b 54 24 08          	mov    0x8(%esp),%edx
  802124:	89 f9                	mov    %edi,%ecx
  802126:	d3 e2                	shl    %cl,%edx
  802128:	39 c2                	cmp    %eax,%edx
  80212a:	73 e9                	jae    802115 <__udivdi3+0xe5>
  80212c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80212f:	31 ff                	xor    %edi,%edi
  802131:	e9 40 ff ff ff       	jmp    802076 <__udivdi3+0x46>
  802136:	66 90                	xchg   %ax,%ax
  802138:	31 c0                	xor    %eax,%eax
  80213a:	e9 37 ff ff ff       	jmp    802076 <__udivdi3+0x46>
  80213f:	90                   	nop

00802140 <__umoddi3>:
  802140:	55                   	push   %ebp
  802141:	57                   	push   %edi
  802142:	56                   	push   %esi
  802143:	53                   	push   %ebx
  802144:	83 ec 1c             	sub    $0x1c,%esp
  802147:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80214b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80214f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802153:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802157:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80215b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80215f:	89 f3                	mov    %esi,%ebx
  802161:	89 fa                	mov    %edi,%edx
  802163:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802167:	89 34 24             	mov    %esi,(%esp)
  80216a:	85 c0                	test   %eax,%eax
  80216c:	75 1a                	jne    802188 <__umoddi3+0x48>
  80216e:	39 f7                	cmp    %esi,%edi
  802170:	0f 86 a2 00 00 00    	jbe    802218 <__umoddi3+0xd8>
  802176:	89 c8                	mov    %ecx,%eax
  802178:	89 f2                	mov    %esi,%edx
  80217a:	f7 f7                	div    %edi
  80217c:	89 d0                	mov    %edx,%eax
  80217e:	31 d2                	xor    %edx,%edx
  802180:	83 c4 1c             	add    $0x1c,%esp
  802183:	5b                   	pop    %ebx
  802184:	5e                   	pop    %esi
  802185:	5f                   	pop    %edi
  802186:	5d                   	pop    %ebp
  802187:	c3                   	ret    
  802188:	39 f0                	cmp    %esi,%eax
  80218a:	0f 87 ac 00 00 00    	ja     80223c <__umoddi3+0xfc>
  802190:	0f bd e8             	bsr    %eax,%ebp
  802193:	83 f5 1f             	xor    $0x1f,%ebp
  802196:	0f 84 ac 00 00 00    	je     802248 <__umoddi3+0x108>
  80219c:	bf 20 00 00 00       	mov    $0x20,%edi
  8021a1:	29 ef                	sub    %ebp,%edi
  8021a3:	89 fe                	mov    %edi,%esi
  8021a5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021a9:	89 e9                	mov    %ebp,%ecx
  8021ab:	d3 e0                	shl    %cl,%eax
  8021ad:	89 d7                	mov    %edx,%edi
  8021af:	89 f1                	mov    %esi,%ecx
  8021b1:	d3 ef                	shr    %cl,%edi
  8021b3:	09 c7                	or     %eax,%edi
  8021b5:	89 e9                	mov    %ebp,%ecx
  8021b7:	d3 e2                	shl    %cl,%edx
  8021b9:	89 14 24             	mov    %edx,(%esp)
  8021bc:	89 d8                	mov    %ebx,%eax
  8021be:	d3 e0                	shl    %cl,%eax
  8021c0:	89 c2                	mov    %eax,%edx
  8021c2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021c6:	d3 e0                	shl    %cl,%eax
  8021c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021cc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021d0:	89 f1                	mov    %esi,%ecx
  8021d2:	d3 e8                	shr    %cl,%eax
  8021d4:	09 d0                	or     %edx,%eax
  8021d6:	d3 eb                	shr    %cl,%ebx
  8021d8:	89 da                	mov    %ebx,%edx
  8021da:	f7 f7                	div    %edi
  8021dc:	89 d3                	mov    %edx,%ebx
  8021de:	f7 24 24             	mull   (%esp)
  8021e1:	89 c6                	mov    %eax,%esi
  8021e3:	89 d1                	mov    %edx,%ecx
  8021e5:	39 d3                	cmp    %edx,%ebx
  8021e7:	0f 82 87 00 00 00    	jb     802274 <__umoddi3+0x134>
  8021ed:	0f 84 91 00 00 00    	je     802284 <__umoddi3+0x144>
  8021f3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021f7:	29 f2                	sub    %esi,%edx
  8021f9:	19 cb                	sbb    %ecx,%ebx
  8021fb:	89 d8                	mov    %ebx,%eax
  8021fd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802201:	d3 e0                	shl    %cl,%eax
  802203:	89 e9                	mov    %ebp,%ecx
  802205:	d3 ea                	shr    %cl,%edx
  802207:	09 d0                	or     %edx,%eax
  802209:	89 e9                	mov    %ebp,%ecx
  80220b:	d3 eb                	shr    %cl,%ebx
  80220d:	89 da                	mov    %ebx,%edx
  80220f:	83 c4 1c             	add    $0x1c,%esp
  802212:	5b                   	pop    %ebx
  802213:	5e                   	pop    %esi
  802214:	5f                   	pop    %edi
  802215:	5d                   	pop    %ebp
  802216:	c3                   	ret    
  802217:	90                   	nop
  802218:	89 fd                	mov    %edi,%ebp
  80221a:	85 ff                	test   %edi,%edi
  80221c:	75 0b                	jne    802229 <__umoddi3+0xe9>
  80221e:	b8 01 00 00 00       	mov    $0x1,%eax
  802223:	31 d2                	xor    %edx,%edx
  802225:	f7 f7                	div    %edi
  802227:	89 c5                	mov    %eax,%ebp
  802229:	89 f0                	mov    %esi,%eax
  80222b:	31 d2                	xor    %edx,%edx
  80222d:	f7 f5                	div    %ebp
  80222f:	89 c8                	mov    %ecx,%eax
  802231:	f7 f5                	div    %ebp
  802233:	89 d0                	mov    %edx,%eax
  802235:	e9 44 ff ff ff       	jmp    80217e <__umoddi3+0x3e>
  80223a:	66 90                	xchg   %ax,%ax
  80223c:	89 c8                	mov    %ecx,%eax
  80223e:	89 f2                	mov    %esi,%edx
  802240:	83 c4 1c             	add    $0x1c,%esp
  802243:	5b                   	pop    %ebx
  802244:	5e                   	pop    %esi
  802245:	5f                   	pop    %edi
  802246:	5d                   	pop    %ebp
  802247:	c3                   	ret    
  802248:	3b 04 24             	cmp    (%esp),%eax
  80224b:	72 06                	jb     802253 <__umoddi3+0x113>
  80224d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802251:	77 0f                	ja     802262 <__umoddi3+0x122>
  802253:	89 f2                	mov    %esi,%edx
  802255:	29 f9                	sub    %edi,%ecx
  802257:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80225b:	89 14 24             	mov    %edx,(%esp)
  80225e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802262:	8b 44 24 04          	mov    0x4(%esp),%eax
  802266:	8b 14 24             	mov    (%esp),%edx
  802269:	83 c4 1c             	add    $0x1c,%esp
  80226c:	5b                   	pop    %ebx
  80226d:	5e                   	pop    %esi
  80226e:	5f                   	pop    %edi
  80226f:	5d                   	pop    %ebp
  802270:	c3                   	ret    
  802271:	8d 76 00             	lea    0x0(%esi),%esi
  802274:	2b 04 24             	sub    (%esp),%eax
  802277:	19 fa                	sbb    %edi,%edx
  802279:	89 d1                	mov    %edx,%ecx
  80227b:	89 c6                	mov    %eax,%esi
  80227d:	e9 71 ff ff ff       	jmp    8021f3 <__umoddi3+0xb3>
  802282:	66 90                	xchg   %ax,%ax
  802284:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802288:	72 ea                	jb     802274 <__umoddi3+0x134>
  80228a:	89 d9                	mov    %ebx,%ecx
  80228c:	e9 62 ff ff ff       	jmp    8021f3 <__umoddi3+0xb3>
