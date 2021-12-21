
obj/user/tst_sharing_1:     file format elf32-i386


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
  800031:	e8 fd 02 00 00       	call   800333 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the creation of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
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
  800087:	68 e0 20 80 00       	push   $0x8020e0
  80008c:	6a 12                	push   $0x12
  80008e:	68 fc 20 80 00       	push   $0x8020fc
  800093:	e8 e0 03 00 00       	call   800478 <_panic>
	}

	uint32 *x, *y, *z ;
	cprintf("STEP A: checking the creation of shared variables... \n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 14 21 80 00       	push   $0x802114
  8000a0:	e8 75 06 00 00       	call   80071a <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000a8:	e8 dd 18 00 00       	call   80198a <sys_calculate_free_frames>
  8000ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000b0:	83 ec 04             	sub    $0x4,%esp
  8000b3:	6a 01                	push   $0x1
  8000b5:	68 00 10 00 00       	push   $0x1000
  8000ba:	68 4b 21 80 00       	push   $0x80214b
  8000bf:	e8 89 16 00 00       	call   80174d <smalloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000ca:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000d1:	74 14                	je     8000e7 <_main+0xaf>
  8000d3:	83 ec 04             	sub    $0x4,%esp
  8000d6:	68 50 21 80 00       	push   $0x802150
  8000db:	6a 1a                	push   $0x1a
  8000dd:	68 fc 20 80 00       	push   $0x8020fc
  8000e2:	e8 91 03 00 00       	call   800478 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8000e7:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000ea:	e8 9b 18 00 00       	call   80198a <sys_calculate_free_frames>
  8000ef:	29 c3                	sub    %eax,%ebx
  8000f1:	89 d8                	mov    %ebx,%eax
  8000f3:	83 f8 04             	cmp    $0x4,%eax
  8000f6:	74 14                	je     80010c <_main+0xd4>
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	68 bc 21 80 00       	push   $0x8021bc
  800100:	6a 1b                	push   $0x1b
  800102:	68 fc 20 80 00       	push   $0x8020fc
  800107:	e8 6c 03 00 00       	call   800478 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80010c:	e8 79 18 00 00       	call   80198a <sys_calculate_free_frames>
  800111:	89 45 e8             	mov    %eax,-0x18(%ebp)
		z = smalloc("z", PAGE_SIZE + 4, 1);
  800114:	83 ec 04             	sub    $0x4,%esp
  800117:	6a 01                	push   $0x1
  800119:	68 04 10 00 00       	push   $0x1004
  80011e:	68 3a 22 80 00       	push   $0x80223a
  800123:	e8 25 16 00 00       	call   80174d <smalloc>
  800128:	83 c4 10             	add    $0x10,%esp
  80012b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if (z != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  80012e:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  800135:	74 14                	je     80014b <_main+0x113>
  800137:	83 ec 04             	sub    $0x4,%esp
  80013a:	68 50 21 80 00       	push   $0x802150
  80013f:	6a 1f                	push   $0x1f
  800141:	68 fc 20 80 00       	push   $0x8020fc
  800146:	e8 2d 03 00 00       	call   800478 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  2+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80014b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  80014e:	e8 37 18 00 00       	call   80198a <sys_calculate_free_frames>
  800153:	29 c3                	sub    %eax,%ebx
  800155:	89 d8                	mov    %ebx,%eax
  800157:	83 f8 04             	cmp    $0x4,%eax
  80015a:	74 14                	je     800170 <_main+0x138>
  80015c:	83 ec 04             	sub    $0x4,%esp
  80015f:	68 bc 21 80 00       	push   $0x8021bc
  800164:	6a 20                	push   $0x20
  800166:	68 fc 20 80 00       	push   $0x8020fc
  80016b:	e8 08 03 00 00       	call   800478 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800170:	e8 15 18 00 00       	call   80198a <sys_calculate_free_frames>
  800175:	89 45 e8             	mov    %eax,-0x18(%ebp)
		y = smalloc("y", 4, 1);
  800178:	83 ec 04             	sub    $0x4,%esp
  80017b:	6a 01                	push   $0x1
  80017d:	6a 04                	push   $0x4
  80017f:	68 3c 22 80 00       	push   $0x80223c
  800184:	e8 c4 15 00 00       	call   80174d <smalloc>
  800189:	83 c4 10             	add    $0x10,%esp
  80018c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (y != (uint32*)(USER_HEAP_START + 3 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  80018f:	81 7d dc 00 30 00 80 	cmpl   $0x80003000,-0x24(%ebp)
  800196:	74 14                	je     8001ac <_main+0x174>
  800198:	83 ec 04             	sub    $0x4,%esp
  80019b:	68 50 21 80 00       	push   $0x802150
  8001a0:	6a 24                	push   $0x24
  8001a2:	68 fc 20 80 00       	push   $0x8020fc
  8001a7:	e8 cc 02 00 00       	call   800478 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8001ac:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8001af:	e8 d6 17 00 00       	call   80198a <sys_calculate_free_frames>
  8001b4:	29 c3                	sub    %eax,%ebx
  8001b6:	89 d8                	mov    %ebx,%eax
  8001b8:	83 f8 03             	cmp    $0x3,%eax
  8001bb:	74 14                	je     8001d1 <_main+0x199>
  8001bd:	83 ec 04             	sub    $0x4,%esp
  8001c0:	68 bc 21 80 00       	push   $0x8021bc
  8001c5:	6a 25                	push   $0x25
  8001c7:	68 fc 20 80 00       	push   $0x8020fc
  8001cc:	e8 a7 02 00 00       	call   800478 <_panic>
	}
	cprintf("Step A is completed successfully!!\n\n\n");
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	68 40 22 80 00       	push   $0x802240
  8001d9:	e8 3c 05 00 00       	call   80071a <cprintf>
  8001de:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking reading & writing... \n");
  8001e1:	83 ec 0c             	sub    $0xc,%esp
  8001e4:	68 68 22 80 00       	push   $0x802268
  8001e9:	e8 2c 05 00 00       	call   80071a <cprintf>
  8001ee:	83 c4 10             	add    $0x10,%esp
	{
		int i=0;
  8001f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<PAGE_SIZE/4;i++)
  8001f8:	eb 2d                	jmp    800227 <_main+0x1ef>
		{
			x[i] = -1;
  8001fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800207:	01 d0                	add    %edx,%eax
  800209:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			y[i] = -1;
  80020f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800212:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800219:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80021c:	01 d0                	add    %edx,%eax
  80021e:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)


	cprintf("STEP B: checking reading & writing... \n");
	{
		int i=0;
		for(;i<PAGE_SIZE/4;i++)
  800224:	ff 45 ec             	incl   -0x14(%ebp)
  800227:	81 7d ec ff 03 00 00 	cmpl   $0x3ff,-0x14(%ebp)
  80022e:	7e ca                	jle    8001fa <_main+0x1c2>
		{
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
  800230:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<2*PAGE_SIZE/4;i++)
  800237:	eb 18                	jmp    800251 <_main+0x219>
		{
			z[i] = -1;
  800239:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80023c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800243:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800246:	01 d0                	add    %edx,%eax
  800248:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
		for(;i<2*PAGE_SIZE/4;i++)
  80024e:	ff 45 ec             	incl   -0x14(%ebp)
  800251:	81 7d ec ff 07 00 00 	cmpl   $0x7ff,-0x14(%ebp)
  800258:	7e df                	jle    800239 <_main+0x201>
		{
			z[i] = -1;
		}

		if( x[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  80025a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025d:	8b 00                	mov    (%eax),%eax
  80025f:	83 f8 ff             	cmp    $0xffffffff,%eax
  800262:	74 14                	je     800278 <_main+0x240>
  800264:	83 ec 04             	sub    $0x4,%esp
  800267:	68 90 22 80 00       	push   $0x802290
  80026c:	6a 39                	push   $0x39
  80026e:	68 fc 20 80 00       	push   $0x8020fc
  800273:	e8 00 02 00 00       	call   800478 <_panic>
		if( x[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  800278:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80027b:	05 fc 0f 00 00       	add    $0xffc,%eax
  800280:	8b 00                	mov    (%eax),%eax
  800282:	83 f8 ff             	cmp    $0xffffffff,%eax
  800285:	74 14                	je     80029b <_main+0x263>
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	68 90 22 80 00       	push   $0x802290
  80028f:	6a 3a                	push   $0x3a
  800291:	68 fc 20 80 00       	push   $0x8020fc
  800296:	e8 dd 01 00 00       	call   800478 <_panic>

		if( y[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  80029b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80029e:	8b 00                	mov    (%eax),%eax
  8002a0:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002a3:	74 14                	je     8002b9 <_main+0x281>
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	68 90 22 80 00       	push   $0x802290
  8002ad:	6a 3c                	push   $0x3c
  8002af:	68 fc 20 80 00       	push   $0x8020fc
  8002b4:	e8 bf 01 00 00       	call   800478 <_panic>
		if( y[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002bc:	05 fc 0f 00 00       	add    $0xffc,%eax
  8002c1:	8b 00                	mov    (%eax),%eax
  8002c3:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002c6:	74 14                	je     8002dc <_main+0x2a4>
  8002c8:	83 ec 04             	sub    $0x4,%esp
  8002cb:	68 90 22 80 00       	push   $0x802290
  8002d0:	6a 3d                	push   $0x3d
  8002d2:	68 fc 20 80 00       	push   $0x8020fc
  8002d7:	e8 9c 01 00 00       	call   800478 <_panic>

		if( z[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  8002dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002df:	8b 00                	mov    (%eax),%eax
  8002e1:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 90 22 80 00       	push   $0x802290
  8002ee:	6a 3f                	push   $0x3f
  8002f0:	68 fc 20 80 00       	push   $0x8020fc
  8002f5:	e8 7e 01 00 00       	call   800478 <_panic>
		if( z[2*PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002fd:	05 fc 1f 00 00       	add    $0x1ffc,%eax
  800302:	8b 00                	mov    (%eax),%eax
  800304:	83 f8 ff             	cmp    $0xffffffff,%eax
  800307:	74 14                	je     80031d <_main+0x2e5>
  800309:	83 ec 04             	sub    $0x4,%esp
  80030c:	68 90 22 80 00       	push   $0x802290
  800311:	6a 40                	push   $0x40
  800313:	68 fc 20 80 00       	push   $0x8020fc
  800318:	e8 5b 01 00 00       	call   800478 <_panic>
	}

	cprintf("Congratulations!! Test of Shared Variables [Create] [1] completed successfully!!\n\n\n");
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	68 bc 22 80 00       	push   $0x8022bc
  800325:	e8 f0 03 00 00       	call   80071a <cprintf>
  80032a:	83 c4 10             	add    $0x10,%esp

	return;
  80032d:	90                   	nop
}
  80032e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800331:	c9                   	leave  
  800332:	c3                   	ret    

00800333 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800333:	55                   	push   %ebp
  800334:	89 e5                	mov    %esp,%ebp
  800336:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800339:	e8 81 15 00 00       	call   8018bf <sys_getenvindex>
  80033e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800341:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800344:	89 d0                	mov    %edx,%eax
  800346:	c1 e0 03             	shl    $0x3,%eax
  800349:	01 d0                	add    %edx,%eax
  80034b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800352:	01 c8                	add    %ecx,%eax
  800354:	01 c0                	add    %eax,%eax
  800356:	01 d0                	add    %edx,%eax
  800358:	01 c0                	add    %eax,%eax
  80035a:	01 d0                	add    %edx,%eax
  80035c:	89 c2                	mov    %eax,%edx
  80035e:	c1 e2 05             	shl    $0x5,%edx
  800361:	29 c2                	sub    %eax,%edx
  800363:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80036a:	89 c2                	mov    %eax,%edx
  80036c:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800372:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800377:	a1 20 30 80 00       	mov    0x803020,%eax
  80037c:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800382:	84 c0                	test   %al,%al
  800384:	74 0f                	je     800395 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800386:	a1 20 30 80 00       	mov    0x803020,%eax
  80038b:	05 40 3c 01 00       	add    $0x13c40,%eax
  800390:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800395:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800399:	7e 0a                	jle    8003a5 <libmain+0x72>
		binaryname = argv[0];
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	8b 00                	mov    (%eax),%eax
  8003a0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003a5:	83 ec 08             	sub    $0x8,%esp
  8003a8:	ff 75 0c             	pushl  0xc(%ebp)
  8003ab:	ff 75 08             	pushl  0x8(%ebp)
  8003ae:	e8 85 fc ff ff       	call   800038 <_main>
  8003b3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003b6:	e8 9f 16 00 00       	call   801a5a <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003bb:	83 ec 0c             	sub    $0xc,%esp
  8003be:	68 28 23 80 00       	push   $0x802328
  8003c3:	e8 52 03 00 00       	call   80071a <cprintf>
  8003c8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d0:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003db:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8003e1:	83 ec 04             	sub    $0x4,%esp
  8003e4:	52                   	push   %edx
  8003e5:	50                   	push   %eax
  8003e6:	68 50 23 80 00       	push   $0x802350
  8003eb:	e8 2a 03 00 00       	call   80071a <cprintf>
  8003f0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8003f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f8:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800409:	83 ec 04             	sub    $0x4,%esp
  80040c:	52                   	push   %edx
  80040d:	50                   	push   %eax
  80040e:	68 78 23 80 00       	push   $0x802378
  800413:	e8 02 03 00 00       	call   80071a <cprintf>
  800418:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80041b:	a1 20 30 80 00       	mov    0x803020,%eax
  800420:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800426:	83 ec 08             	sub    $0x8,%esp
  800429:	50                   	push   %eax
  80042a:	68 b9 23 80 00       	push   $0x8023b9
  80042f:	e8 e6 02 00 00       	call   80071a <cprintf>
  800434:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800437:	83 ec 0c             	sub    $0xc,%esp
  80043a:	68 28 23 80 00       	push   $0x802328
  80043f:	e8 d6 02 00 00       	call   80071a <cprintf>
  800444:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800447:	e8 28 16 00 00       	call   801a74 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80044c:	e8 19 00 00 00       	call   80046a <exit>
}
  800451:	90                   	nop
  800452:	c9                   	leave  
  800453:	c3                   	ret    

00800454 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800454:	55                   	push   %ebp
  800455:	89 e5                	mov    %esp,%ebp
  800457:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80045a:	83 ec 0c             	sub    $0xc,%esp
  80045d:	6a 00                	push   $0x0
  80045f:	e8 27 14 00 00       	call   80188b <sys_env_destroy>
  800464:	83 c4 10             	add    $0x10,%esp
}
  800467:	90                   	nop
  800468:	c9                   	leave  
  800469:	c3                   	ret    

0080046a <exit>:

void
exit(void)
{
  80046a:	55                   	push   %ebp
  80046b:	89 e5                	mov    %esp,%ebp
  80046d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800470:	e8 7c 14 00 00       	call   8018f1 <sys_env_exit>
}
  800475:	90                   	nop
  800476:	c9                   	leave  
  800477:	c3                   	ret    

00800478 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800478:	55                   	push   %ebp
  800479:	89 e5                	mov    %esp,%ebp
  80047b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80047e:	8d 45 10             	lea    0x10(%ebp),%eax
  800481:	83 c0 04             	add    $0x4,%eax
  800484:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800487:	a1 18 31 80 00       	mov    0x803118,%eax
  80048c:	85 c0                	test   %eax,%eax
  80048e:	74 16                	je     8004a6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800490:	a1 18 31 80 00       	mov    0x803118,%eax
  800495:	83 ec 08             	sub    $0x8,%esp
  800498:	50                   	push   %eax
  800499:	68 d0 23 80 00       	push   $0x8023d0
  80049e:	e8 77 02 00 00       	call   80071a <cprintf>
  8004a3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004a6:	a1 00 30 80 00       	mov    0x803000,%eax
  8004ab:	ff 75 0c             	pushl  0xc(%ebp)
  8004ae:	ff 75 08             	pushl  0x8(%ebp)
  8004b1:	50                   	push   %eax
  8004b2:	68 d5 23 80 00       	push   $0x8023d5
  8004b7:	e8 5e 02 00 00       	call   80071a <cprintf>
  8004bc:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c2:	83 ec 08             	sub    $0x8,%esp
  8004c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c8:	50                   	push   %eax
  8004c9:	e8 e1 01 00 00       	call   8006af <vcprintf>
  8004ce:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004d1:	83 ec 08             	sub    $0x8,%esp
  8004d4:	6a 00                	push   $0x0
  8004d6:	68 f1 23 80 00       	push   $0x8023f1
  8004db:	e8 cf 01 00 00       	call   8006af <vcprintf>
  8004e0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004e3:	e8 82 ff ff ff       	call   80046a <exit>

	// should not return here
	while (1) ;
  8004e8:	eb fe                	jmp    8004e8 <_panic+0x70>

008004ea <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004ea:	55                   	push   %ebp
  8004eb:	89 e5                	mov    %esp,%ebp
  8004ed:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8b 50 74             	mov    0x74(%eax),%edx
  8004f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fb:	39 c2                	cmp    %eax,%edx
  8004fd:	74 14                	je     800513 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004ff:	83 ec 04             	sub    $0x4,%esp
  800502:	68 f4 23 80 00       	push   $0x8023f4
  800507:	6a 26                	push   $0x26
  800509:	68 40 24 80 00       	push   $0x802440
  80050e:	e8 65 ff ff ff       	call   800478 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800513:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80051a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800521:	e9 b6 00 00 00       	jmp    8005dc <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800526:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800529:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800530:	8b 45 08             	mov    0x8(%ebp),%eax
  800533:	01 d0                	add    %edx,%eax
  800535:	8b 00                	mov    (%eax),%eax
  800537:	85 c0                	test   %eax,%eax
  800539:	75 08                	jne    800543 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80053b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80053e:	e9 96 00 00 00       	jmp    8005d9 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800543:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80054a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800551:	eb 5d                	jmp    8005b0 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800553:	a1 20 30 80 00       	mov    0x803020,%eax
  800558:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80055e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800561:	c1 e2 04             	shl    $0x4,%edx
  800564:	01 d0                	add    %edx,%eax
  800566:	8a 40 04             	mov    0x4(%eax),%al
  800569:	84 c0                	test   %al,%al
  80056b:	75 40                	jne    8005ad <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80056d:	a1 20 30 80 00       	mov    0x803020,%eax
  800572:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800578:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80057b:	c1 e2 04             	shl    $0x4,%edx
  80057e:	01 d0                	add    %edx,%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800585:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800588:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80058d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80058f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800592:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	01 c8                	add    %ecx,%eax
  80059e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005a0:	39 c2                	cmp    %eax,%edx
  8005a2:	75 09                	jne    8005ad <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005a4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005ab:	eb 12                	jmp    8005bf <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ad:	ff 45 e8             	incl   -0x18(%ebp)
  8005b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b5:	8b 50 74             	mov    0x74(%eax),%edx
  8005b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005bb:	39 c2                	cmp    %eax,%edx
  8005bd:	77 94                	ja     800553 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005c3:	75 14                	jne    8005d9 <CheckWSWithoutLastIndex+0xef>
			panic(
  8005c5:	83 ec 04             	sub    $0x4,%esp
  8005c8:	68 4c 24 80 00       	push   $0x80244c
  8005cd:	6a 3a                	push   $0x3a
  8005cf:	68 40 24 80 00       	push   $0x802440
  8005d4:	e8 9f fe ff ff       	call   800478 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005d9:	ff 45 f0             	incl   -0x10(%ebp)
  8005dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005df:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005e2:	0f 8c 3e ff ff ff    	jl     800526 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005f6:	eb 20                	jmp    800618 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800603:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800606:	c1 e2 04             	shl    $0x4,%edx
  800609:	01 d0                	add    %edx,%eax
  80060b:	8a 40 04             	mov    0x4(%eax),%al
  80060e:	3c 01                	cmp    $0x1,%al
  800610:	75 03                	jne    800615 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800612:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800615:	ff 45 e0             	incl   -0x20(%ebp)
  800618:	a1 20 30 80 00       	mov    0x803020,%eax
  80061d:	8b 50 74             	mov    0x74(%eax),%edx
  800620:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800623:	39 c2                	cmp    %eax,%edx
  800625:	77 d1                	ja     8005f8 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800627:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80062a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80062d:	74 14                	je     800643 <CheckWSWithoutLastIndex+0x159>
		panic(
  80062f:	83 ec 04             	sub    $0x4,%esp
  800632:	68 a0 24 80 00       	push   $0x8024a0
  800637:	6a 44                	push   $0x44
  800639:	68 40 24 80 00       	push   $0x802440
  80063e:	e8 35 fe ff ff       	call   800478 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800643:	90                   	nop
  800644:	c9                   	leave  
  800645:	c3                   	ret    

00800646 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800646:	55                   	push   %ebp
  800647:	89 e5                	mov    %esp,%ebp
  800649:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80064c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	8d 48 01             	lea    0x1(%eax),%ecx
  800654:	8b 55 0c             	mov    0xc(%ebp),%edx
  800657:	89 0a                	mov    %ecx,(%edx)
  800659:	8b 55 08             	mov    0x8(%ebp),%edx
  80065c:	88 d1                	mov    %dl,%cl
  80065e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800661:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800665:	8b 45 0c             	mov    0xc(%ebp),%eax
  800668:	8b 00                	mov    (%eax),%eax
  80066a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80066f:	75 2c                	jne    80069d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800671:	a0 24 30 80 00       	mov    0x803024,%al
  800676:	0f b6 c0             	movzbl %al,%eax
  800679:	8b 55 0c             	mov    0xc(%ebp),%edx
  80067c:	8b 12                	mov    (%edx),%edx
  80067e:	89 d1                	mov    %edx,%ecx
  800680:	8b 55 0c             	mov    0xc(%ebp),%edx
  800683:	83 c2 08             	add    $0x8,%edx
  800686:	83 ec 04             	sub    $0x4,%esp
  800689:	50                   	push   %eax
  80068a:	51                   	push   %ecx
  80068b:	52                   	push   %edx
  80068c:	e8 b8 11 00 00       	call   801849 <sys_cputs>
  800691:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800694:	8b 45 0c             	mov    0xc(%ebp),%eax
  800697:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80069d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a0:	8b 40 04             	mov    0x4(%eax),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006ac:	90                   	nop
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006b8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006bf:	00 00 00 
	b.cnt = 0;
  8006c2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006c9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006cc:	ff 75 0c             	pushl  0xc(%ebp)
  8006cf:	ff 75 08             	pushl  0x8(%ebp)
  8006d2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006d8:	50                   	push   %eax
  8006d9:	68 46 06 80 00       	push   $0x800646
  8006de:	e8 11 02 00 00       	call   8008f4 <vprintfmt>
  8006e3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006e6:	a0 24 30 80 00       	mov    0x803024,%al
  8006eb:	0f b6 c0             	movzbl %al,%eax
  8006ee:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006f4:	83 ec 04             	sub    $0x4,%esp
  8006f7:	50                   	push   %eax
  8006f8:	52                   	push   %edx
  8006f9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006ff:	83 c0 08             	add    $0x8,%eax
  800702:	50                   	push   %eax
  800703:	e8 41 11 00 00       	call   801849 <sys_cputs>
  800708:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80070b:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800712:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <cprintf>:

int cprintf(const char *fmt, ...) {
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800720:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800727:	8d 45 0c             	lea    0xc(%ebp),%eax
  80072a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	83 ec 08             	sub    $0x8,%esp
  800733:	ff 75 f4             	pushl  -0xc(%ebp)
  800736:	50                   	push   %eax
  800737:	e8 73 ff ff ff       	call   8006af <vcprintf>
  80073c:	83 c4 10             	add    $0x10,%esp
  80073f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800742:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800745:	c9                   	leave  
  800746:	c3                   	ret    

00800747 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800747:	55                   	push   %ebp
  800748:	89 e5                	mov    %esp,%ebp
  80074a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074d:	e8 08 13 00 00       	call   801a5a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800752:	8d 45 0c             	lea    0xc(%ebp),%eax
  800755:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800758:	8b 45 08             	mov    0x8(%ebp),%eax
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 f4             	pushl  -0xc(%ebp)
  800761:	50                   	push   %eax
  800762:	e8 48 ff ff ff       	call   8006af <vcprintf>
  800767:	83 c4 10             	add    $0x10,%esp
  80076a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80076d:	e8 02 13 00 00       	call   801a74 <sys_enable_interrupt>
	return cnt;
  800772:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800775:	c9                   	leave  
  800776:	c3                   	ret    

00800777 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800777:	55                   	push   %ebp
  800778:	89 e5                	mov    %esp,%ebp
  80077a:	53                   	push   %ebx
  80077b:	83 ec 14             	sub    $0x14,%esp
  80077e:	8b 45 10             	mov    0x10(%ebp),%eax
  800781:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800784:	8b 45 14             	mov    0x14(%ebp),%eax
  800787:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80078a:	8b 45 18             	mov    0x18(%ebp),%eax
  80078d:	ba 00 00 00 00       	mov    $0x0,%edx
  800792:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800795:	77 55                	ja     8007ec <printnum+0x75>
  800797:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80079a:	72 05                	jb     8007a1 <printnum+0x2a>
  80079c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80079f:	77 4b                	ja     8007ec <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007a1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007a4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007a7:	8b 45 18             	mov    0x18(%ebp),%eax
  8007aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8007af:	52                   	push   %edx
  8007b0:	50                   	push   %eax
  8007b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b4:	ff 75 f0             	pushl  -0x10(%ebp)
  8007b7:	e8 c0 16 00 00       	call   801e7c <__udivdi3>
  8007bc:	83 c4 10             	add    $0x10,%esp
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	ff 75 20             	pushl  0x20(%ebp)
  8007c5:	53                   	push   %ebx
  8007c6:	ff 75 18             	pushl  0x18(%ebp)
  8007c9:	52                   	push   %edx
  8007ca:	50                   	push   %eax
  8007cb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ce:	ff 75 08             	pushl  0x8(%ebp)
  8007d1:	e8 a1 ff ff ff       	call   800777 <printnum>
  8007d6:	83 c4 20             	add    $0x20,%esp
  8007d9:	eb 1a                	jmp    8007f5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007db:	83 ec 08             	sub    $0x8,%esp
  8007de:	ff 75 0c             	pushl  0xc(%ebp)
  8007e1:	ff 75 20             	pushl  0x20(%ebp)
  8007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e7:	ff d0                	call   *%eax
  8007e9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007ec:	ff 4d 1c             	decl   0x1c(%ebp)
  8007ef:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007f3:	7f e6                	jg     8007db <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007f5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007f8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800800:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800803:	53                   	push   %ebx
  800804:	51                   	push   %ecx
  800805:	52                   	push   %edx
  800806:	50                   	push   %eax
  800807:	e8 80 17 00 00       	call   801f8c <__umoddi3>
  80080c:	83 c4 10             	add    $0x10,%esp
  80080f:	05 14 27 80 00       	add    $0x802714,%eax
  800814:	8a 00                	mov    (%eax),%al
  800816:	0f be c0             	movsbl %al,%eax
  800819:	83 ec 08             	sub    $0x8,%esp
  80081c:	ff 75 0c             	pushl  0xc(%ebp)
  80081f:	50                   	push   %eax
  800820:	8b 45 08             	mov    0x8(%ebp),%eax
  800823:	ff d0                	call   *%eax
  800825:	83 c4 10             	add    $0x10,%esp
}
  800828:	90                   	nop
  800829:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80082c:	c9                   	leave  
  80082d:	c3                   	ret    

0080082e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80082e:	55                   	push   %ebp
  80082f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800831:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800835:	7e 1c                	jle    800853 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800837:	8b 45 08             	mov    0x8(%ebp),%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	8d 50 08             	lea    0x8(%eax),%edx
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	89 10                	mov    %edx,(%eax)
  800844:	8b 45 08             	mov    0x8(%ebp),%eax
  800847:	8b 00                	mov    (%eax),%eax
  800849:	83 e8 08             	sub    $0x8,%eax
  80084c:	8b 50 04             	mov    0x4(%eax),%edx
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	eb 40                	jmp    800893 <getuint+0x65>
	else if (lflag)
  800853:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800857:	74 1e                	je     800877 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	8d 50 04             	lea    0x4(%eax),%edx
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	89 10                	mov    %edx,(%eax)
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	83 e8 04             	sub    $0x4,%eax
  80086e:	8b 00                	mov    (%eax),%eax
  800870:	ba 00 00 00 00       	mov    $0x0,%edx
  800875:	eb 1c                	jmp    800893 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	8d 50 04             	lea    0x4(%eax),%edx
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	89 10                	mov    %edx,(%eax)
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	8b 00                	mov    (%eax),%eax
  800889:	83 e8 04             	sub    $0x4,%eax
  80088c:	8b 00                	mov    (%eax),%eax
  80088e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800893:	5d                   	pop    %ebp
  800894:	c3                   	ret    

00800895 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800895:	55                   	push   %ebp
  800896:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800898:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80089c:	7e 1c                	jle    8008ba <getint+0x25>
		return va_arg(*ap, long long);
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	8d 50 08             	lea    0x8(%eax),%edx
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	89 10                	mov    %edx,(%eax)
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	8b 00                	mov    (%eax),%eax
  8008b0:	83 e8 08             	sub    $0x8,%eax
  8008b3:	8b 50 04             	mov    0x4(%eax),%edx
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	eb 38                	jmp    8008f2 <getint+0x5d>
	else if (lflag)
  8008ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008be:	74 1a                	je     8008da <getint+0x45>
		return va_arg(*ap, long);
  8008c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c3:	8b 00                	mov    (%eax),%eax
  8008c5:	8d 50 04             	lea    0x4(%eax),%edx
  8008c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cb:	89 10                	mov    %edx,(%eax)
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	8b 00                	mov    (%eax),%eax
  8008d2:	83 e8 04             	sub    $0x4,%eax
  8008d5:	8b 00                	mov    (%eax),%eax
  8008d7:	99                   	cltd   
  8008d8:	eb 18                	jmp    8008f2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008da:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dd:	8b 00                	mov    (%eax),%eax
  8008df:	8d 50 04             	lea    0x4(%eax),%edx
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	89 10                	mov    %edx,(%eax)
  8008e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ea:	8b 00                	mov    (%eax),%eax
  8008ec:	83 e8 04             	sub    $0x4,%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	99                   	cltd   
}
  8008f2:	5d                   	pop    %ebp
  8008f3:	c3                   	ret    

008008f4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008f4:	55                   	push   %ebp
  8008f5:	89 e5                	mov    %esp,%ebp
  8008f7:	56                   	push   %esi
  8008f8:	53                   	push   %ebx
  8008f9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008fc:	eb 17                	jmp    800915 <vprintfmt+0x21>
			if (ch == '\0')
  8008fe:	85 db                	test   %ebx,%ebx
  800900:	0f 84 af 03 00 00    	je     800cb5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800906:	83 ec 08             	sub    $0x8,%esp
  800909:	ff 75 0c             	pushl  0xc(%ebp)
  80090c:	53                   	push   %ebx
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	ff d0                	call   *%eax
  800912:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800915:	8b 45 10             	mov    0x10(%ebp),%eax
  800918:	8d 50 01             	lea    0x1(%eax),%edx
  80091b:	89 55 10             	mov    %edx,0x10(%ebp)
  80091e:	8a 00                	mov    (%eax),%al
  800920:	0f b6 d8             	movzbl %al,%ebx
  800923:	83 fb 25             	cmp    $0x25,%ebx
  800926:	75 d6                	jne    8008fe <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800928:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80092c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800933:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80093a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800941:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800948:	8b 45 10             	mov    0x10(%ebp),%eax
  80094b:	8d 50 01             	lea    0x1(%eax),%edx
  80094e:	89 55 10             	mov    %edx,0x10(%ebp)
  800951:	8a 00                	mov    (%eax),%al
  800953:	0f b6 d8             	movzbl %al,%ebx
  800956:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800959:	83 f8 55             	cmp    $0x55,%eax
  80095c:	0f 87 2b 03 00 00    	ja     800c8d <vprintfmt+0x399>
  800962:	8b 04 85 38 27 80 00 	mov    0x802738(,%eax,4),%eax
  800969:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80096b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80096f:	eb d7                	jmp    800948 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800971:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800975:	eb d1                	jmp    800948 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800977:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80097e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800981:	89 d0                	mov    %edx,%eax
  800983:	c1 e0 02             	shl    $0x2,%eax
  800986:	01 d0                	add    %edx,%eax
  800988:	01 c0                	add    %eax,%eax
  80098a:	01 d8                	add    %ebx,%eax
  80098c:	83 e8 30             	sub    $0x30,%eax
  80098f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800992:	8b 45 10             	mov    0x10(%ebp),%eax
  800995:	8a 00                	mov    (%eax),%al
  800997:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80099a:	83 fb 2f             	cmp    $0x2f,%ebx
  80099d:	7e 3e                	jle    8009dd <vprintfmt+0xe9>
  80099f:	83 fb 39             	cmp    $0x39,%ebx
  8009a2:	7f 39                	jg     8009dd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009a4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009a7:	eb d5                	jmp    80097e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ac:	83 c0 04             	add    $0x4,%eax
  8009af:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b5:	83 e8 04             	sub    $0x4,%eax
  8009b8:	8b 00                	mov    (%eax),%eax
  8009ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009bd:	eb 1f                	jmp    8009de <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009c3:	79 83                	jns    800948 <vprintfmt+0x54>
				width = 0;
  8009c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009cc:	e9 77 ff ff ff       	jmp    800948 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009d1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009d8:	e9 6b ff ff ff       	jmp    800948 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009dd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e2:	0f 89 60 ff ff ff    	jns    800948 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009ee:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009f5:	e9 4e ff ff ff       	jmp    800948 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009fa:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009fd:	e9 46 ff ff ff       	jmp    800948 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a02:	8b 45 14             	mov    0x14(%ebp),%eax
  800a05:	83 c0 04             	add    $0x4,%eax
  800a08:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0e:	83 e8 04             	sub    $0x4,%eax
  800a11:	8b 00                	mov    (%eax),%eax
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	50                   	push   %eax
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	ff d0                	call   *%eax
  800a1f:	83 c4 10             	add    $0x10,%esp
			break;
  800a22:	e9 89 02 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	83 c0 04             	add    $0x4,%eax
  800a2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a30:	8b 45 14             	mov    0x14(%ebp),%eax
  800a33:	83 e8 04             	sub    $0x4,%eax
  800a36:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a38:	85 db                	test   %ebx,%ebx
  800a3a:	79 02                	jns    800a3e <vprintfmt+0x14a>
				err = -err;
  800a3c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a3e:	83 fb 64             	cmp    $0x64,%ebx
  800a41:	7f 0b                	jg     800a4e <vprintfmt+0x15a>
  800a43:	8b 34 9d 80 25 80 00 	mov    0x802580(,%ebx,4),%esi
  800a4a:	85 f6                	test   %esi,%esi
  800a4c:	75 19                	jne    800a67 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a4e:	53                   	push   %ebx
  800a4f:	68 25 27 80 00       	push   $0x802725
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	ff 75 08             	pushl  0x8(%ebp)
  800a5a:	e8 5e 02 00 00       	call   800cbd <printfmt>
  800a5f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a62:	e9 49 02 00 00       	jmp    800cb0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a67:	56                   	push   %esi
  800a68:	68 2e 27 80 00       	push   $0x80272e
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	ff 75 08             	pushl  0x8(%ebp)
  800a73:	e8 45 02 00 00       	call   800cbd <printfmt>
  800a78:	83 c4 10             	add    $0x10,%esp
			break;
  800a7b:	e9 30 02 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a80:	8b 45 14             	mov    0x14(%ebp),%eax
  800a83:	83 c0 04             	add    $0x4,%eax
  800a86:	89 45 14             	mov    %eax,0x14(%ebp)
  800a89:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8c:	83 e8 04             	sub    $0x4,%eax
  800a8f:	8b 30                	mov    (%eax),%esi
  800a91:	85 f6                	test   %esi,%esi
  800a93:	75 05                	jne    800a9a <vprintfmt+0x1a6>
				p = "(null)";
  800a95:	be 31 27 80 00       	mov    $0x802731,%esi
			if (width > 0 && padc != '-')
  800a9a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a9e:	7e 6d                	jle    800b0d <vprintfmt+0x219>
  800aa0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800aa4:	74 67                	je     800b0d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aa6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa9:	83 ec 08             	sub    $0x8,%esp
  800aac:	50                   	push   %eax
  800aad:	56                   	push   %esi
  800aae:	e8 0c 03 00 00       	call   800dbf <strnlen>
  800ab3:	83 c4 10             	add    $0x10,%esp
  800ab6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ab9:	eb 16                	jmp    800ad1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800abb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800abf:	83 ec 08             	sub    $0x8,%esp
  800ac2:	ff 75 0c             	pushl  0xc(%ebp)
  800ac5:	50                   	push   %eax
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	ff d0                	call   *%eax
  800acb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ace:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad5:	7f e4                	jg     800abb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad7:	eb 34                	jmp    800b0d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ad9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800add:	74 1c                	je     800afb <vprintfmt+0x207>
  800adf:	83 fb 1f             	cmp    $0x1f,%ebx
  800ae2:	7e 05                	jle    800ae9 <vprintfmt+0x1f5>
  800ae4:	83 fb 7e             	cmp    $0x7e,%ebx
  800ae7:	7e 12                	jle    800afb <vprintfmt+0x207>
					putch('?', putdat);
  800ae9:	83 ec 08             	sub    $0x8,%esp
  800aec:	ff 75 0c             	pushl  0xc(%ebp)
  800aef:	6a 3f                	push   $0x3f
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	ff d0                	call   *%eax
  800af6:	83 c4 10             	add    $0x10,%esp
  800af9:	eb 0f                	jmp    800b0a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800afb:	83 ec 08             	sub    $0x8,%esp
  800afe:	ff 75 0c             	pushl  0xc(%ebp)
  800b01:	53                   	push   %ebx
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	ff d0                	call   *%eax
  800b07:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b0a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b0d:	89 f0                	mov    %esi,%eax
  800b0f:	8d 70 01             	lea    0x1(%eax),%esi
  800b12:	8a 00                	mov    (%eax),%al
  800b14:	0f be d8             	movsbl %al,%ebx
  800b17:	85 db                	test   %ebx,%ebx
  800b19:	74 24                	je     800b3f <vprintfmt+0x24b>
  800b1b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b1f:	78 b8                	js     800ad9 <vprintfmt+0x1e5>
  800b21:	ff 4d e0             	decl   -0x20(%ebp)
  800b24:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b28:	79 af                	jns    800ad9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b2a:	eb 13                	jmp    800b3f <vprintfmt+0x24b>
				putch(' ', putdat);
  800b2c:	83 ec 08             	sub    $0x8,%esp
  800b2f:	ff 75 0c             	pushl  0xc(%ebp)
  800b32:	6a 20                	push   $0x20
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	ff d0                	call   *%eax
  800b39:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b3c:	ff 4d e4             	decl   -0x1c(%ebp)
  800b3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b43:	7f e7                	jg     800b2c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b45:	e9 66 01 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 e8             	pushl  -0x18(%ebp)
  800b50:	8d 45 14             	lea    0x14(%ebp),%eax
  800b53:	50                   	push   %eax
  800b54:	e8 3c fd ff ff       	call   800895 <getint>
  800b59:	83 c4 10             	add    $0x10,%esp
  800b5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b68:	85 d2                	test   %edx,%edx
  800b6a:	79 23                	jns    800b8f <vprintfmt+0x29b>
				putch('-', putdat);
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	6a 2d                	push   $0x2d
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	ff d0                	call   *%eax
  800b79:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b82:	f7 d8                	neg    %eax
  800b84:	83 d2 00             	adc    $0x0,%edx
  800b87:	f7 da                	neg    %edx
  800b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b8f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b96:	e9 bc 00 00 00       	jmp    800c57 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 e8             	pushl  -0x18(%ebp)
  800ba1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba4:	50                   	push   %eax
  800ba5:	e8 84 fc ff ff       	call   80082e <getuint>
  800baa:	83 c4 10             	add    $0x10,%esp
  800bad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bb3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bba:	e9 98 00 00 00       	jmp    800c57 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	6a 58                	push   $0x58
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	ff d0                	call   *%eax
  800bcc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bcf:	83 ec 08             	sub    $0x8,%esp
  800bd2:	ff 75 0c             	pushl  0xc(%ebp)
  800bd5:	6a 58                	push   $0x58
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	ff d0                	call   *%eax
  800bdc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bdf:	83 ec 08             	sub    $0x8,%esp
  800be2:	ff 75 0c             	pushl  0xc(%ebp)
  800be5:	6a 58                	push   $0x58
  800be7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bea:	ff d0                	call   *%eax
  800bec:	83 c4 10             	add    $0x10,%esp
			break;
  800bef:	e9 bc 00 00 00       	jmp    800cb0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bf4:	83 ec 08             	sub    $0x8,%esp
  800bf7:	ff 75 0c             	pushl  0xc(%ebp)
  800bfa:	6a 30                	push   $0x30
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	ff d0                	call   *%eax
  800c01:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 0c             	pushl  0xc(%ebp)
  800c0a:	6a 78                	push   $0x78
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	ff d0                	call   *%eax
  800c11:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c14:	8b 45 14             	mov    0x14(%ebp),%eax
  800c17:	83 c0 04             	add    $0x4,%eax
  800c1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c20:	83 e8 04             	sub    $0x4,%eax
  800c23:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c2f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c36:	eb 1f                	jmp    800c57 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c38:	83 ec 08             	sub    $0x8,%esp
  800c3b:	ff 75 e8             	pushl  -0x18(%ebp)
  800c3e:	8d 45 14             	lea    0x14(%ebp),%eax
  800c41:	50                   	push   %eax
  800c42:	e8 e7 fb ff ff       	call   80082e <getuint>
  800c47:	83 c4 10             	add    $0x10,%esp
  800c4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c50:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c57:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c5e:	83 ec 04             	sub    $0x4,%esp
  800c61:	52                   	push   %edx
  800c62:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c65:	50                   	push   %eax
  800c66:	ff 75 f4             	pushl  -0xc(%ebp)
  800c69:	ff 75 f0             	pushl  -0x10(%ebp)
  800c6c:	ff 75 0c             	pushl  0xc(%ebp)
  800c6f:	ff 75 08             	pushl  0x8(%ebp)
  800c72:	e8 00 fb ff ff       	call   800777 <printnum>
  800c77:	83 c4 20             	add    $0x20,%esp
			break;
  800c7a:	eb 34                	jmp    800cb0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c7c:	83 ec 08             	sub    $0x8,%esp
  800c7f:	ff 75 0c             	pushl  0xc(%ebp)
  800c82:	53                   	push   %ebx
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	ff d0                	call   *%eax
  800c88:	83 c4 10             	add    $0x10,%esp
			break;
  800c8b:	eb 23                	jmp    800cb0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c8d:	83 ec 08             	sub    $0x8,%esp
  800c90:	ff 75 0c             	pushl  0xc(%ebp)
  800c93:	6a 25                	push   $0x25
  800c95:	8b 45 08             	mov    0x8(%ebp),%eax
  800c98:	ff d0                	call   *%eax
  800c9a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c9d:	ff 4d 10             	decl   0x10(%ebp)
  800ca0:	eb 03                	jmp    800ca5 <vprintfmt+0x3b1>
  800ca2:	ff 4d 10             	decl   0x10(%ebp)
  800ca5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca8:	48                   	dec    %eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	3c 25                	cmp    $0x25,%al
  800cad:	75 f3                	jne    800ca2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800caf:	90                   	nop
		}
	}
  800cb0:	e9 47 fc ff ff       	jmp    8008fc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cb5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cb9:	5b                   	pop    %ebx
  800cba:	5e                   	pop    %esi
  800cbb:	5d                   	pop    %ebp
  800cbc:	c3                   	ret    

00800cbd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cbd:	55                   	push   %ebp
  800cbe:	89 e5                	mov    %esp,%ebp
  800cc0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cc3:	8d 45 10             	lea    0x10(%ebp),%eax
  800cc6:	83 c0 04             	add    $0x4,%eax
  800cc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ccc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccf:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd2:	50                   	push   %eax
  800cd3:	ff 75 0c             	pushl  0xc(%ebp)
  800cd6:	ff 75 08             	pushl  0x8(%ebp)
  800cd9:	e8 16 fc ff ff       	call   8008f4 <vprintfmt>
  800cde:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ce1:	90                   	nop
  800ce2:	c9                   	leave  
  800ce3:	c3                   	ret    

00800ce4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ce4:	55                   	push   %ebp
  800ce5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	8b 40 08             	mov    0x8(%eax),%eax
  800ced:	8d 50 01             	lea    0x1(%eax),%edx
  800cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf9:	8b 10                	mov    (%eax),%edx
  800cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfe:	8b 40 04             	mov    0x4(%eax),%eax
  800d01:	39 c2                	cmp    %eax,%edx
  800d03:	73 12                	jae    800d17 <sprintputch+0x33>
		*b->buf++ = ch;
  800d05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d08:	8b 00                	mov    (%eax),%eax
  800d0a:	8d 48 01             	lea    0x1(%eax),%ecx
  800d0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d10:	89 0a                	mov    %ecx,(%edx)
  800d12:	8b 55 08             	mov    0x8(%ebp),%edx
  800d15:	88 10                	mov    %dl,(%eax)
}
  800d17:	90                   	nop
  800d18:	5d                   	pop    %ebp
  800d19:	c3                   	ret    

00800d1a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d1a:	55                   	push   %ebp
  800d1b:	89 e5                	mov    %esp,%ebp
  800d1d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d29:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	01 d0                	add    %edx,%eax
  800d31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d3b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d3f:	74 06                	je     800d47 <vsnprintf+0x2d>
  800d41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d45:	7f 07                	jg     800d4e <vsnprintf+0x34>
		return -E_INVAL;
  800d47:	b8 03 00 00 00       	mov    $0x3,%eax
  800d4c:	eb 20                	jmp    800d6e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d4e:	ff 75 14             	pushl  0x14(%ebp)
  800d51:	ff 75 10             	pushl  0x10(%ebp)
  800d54:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d57:	50                   	push   %eax
  800d58:	68 e4 0c 80 00       	push   $0x800ce4
  800d5d:	e8 92 fb ff ff       	call   8008f4 <vprintfmt>
  800d62:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d65:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d68:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d6e:	c9                   	leave  
  800d6f:	c3                   	ret    

00800d70 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d76:	8d 45 10             	lea    0x10(%ebp),%eax
  800d79:	83 c0 04             	add    $0x4,%eax
  800d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d82:	ff 75 f4             	pushl  -0xc(%ebp)
  800d85:	50                   	push   %eax
  800d86:	ff 75 0c             	pushl  0xc(%ebp)
  800d89:	ff 75 08             	pushl  0x8(%ebp)
  800d8c:	e8 89 ff ff ff       	call   800d1a <vsnprintf>
  800d91:	83 c4 10             	add    $0x10,%esp
  800d94:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d97:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d9a:	c9                   	leave  
  800d9b:	c3                   	ret    

00800d9c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d9c:	55                   	push   %ebp
  800d9d:	89 e5                	mov    %esp,%ebp
  800d9f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800da2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da9:	eb 06                	jmp    800db1 <strlen+0x15>
		n++;
  800dab:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dae:	ff 45 08             	incl   0x8(%ebp)
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	84 c0                	test   %al,%al
  800db8:	75 f1                	jne    800dab <strlen+0xf>
		n++;
	return n;
  800dba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dbd:	c9                   	leave  
  800dbe:	c3                   	ret    

00800dbf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dbf:	55                   	push   %ebp
  800dc0:	89 e5                	mov    %esp,%ebp
  800dc2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dc5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dcc:	eb 09                	jmp    800dd7 <strnlen+0x18>
		n++;
  800dce:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dd1:	ff 45 08             	incl   0x8(%ebp)
  800dd4:	ff 4d 0c             	decl   0xc(%ebp)
  800dd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ddb:	74 09                	je     800de6 <strnlen+0x27>
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8a 00                	mov    (%eax),%al
  800de2:	84 c0                	test   %al,%al
  800de4:	75 e8                	jne    800dce <strnlen+0xf>
		n++;
	return n;
  800de6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800df7:	90                   	nop
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8d 50 01             	lea    0x1(%eax),%edx
  800dfe:	89 55 08             	mov    %edx,0x8(%ebp)
  800e01:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e04:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e07:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e0a:	8a 12                	mov    (%edx),%dl
  800e0c:	88 10                	mov    %dl,(%eax)
  800e0e:	8a 00                	mov    (%eax),%al
  800e10:	84 c0                	test   %al,%al
  800e12:	75 e4                	jne    800df8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e17:	c9                   	leave  
  800e18:	c3                   	ret    

00800e19 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e19:	55                   	push   %ebp
  800e1a:	89 e5                	mov    %esp,%ebp
  800e1c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e2c:	eb 1f                	jmp    800e4d <strncpy+0x34>
		*dst++ = *src;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8d 50 01             	lea    0x1(%eax),%edx
  800e34:	89 55 08             	mov    %edx,0x8(%ebp)
  800e37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3a:	8a 12                	mov    (%edx),%dl
  800e3c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	84 c0                	test   %al,%al
  800e45:	74 03                	je     800e4a <strncpy+0x31>
			src++;
  800e47:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e4a:	ff 45 fc             	incl   -0x4(%ebp)
  800e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e50:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e53:	72 d9                	jb     800e2e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e55:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e58:	c9                   	leave  
  800e59:	c3                   	ret    

00800e5a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e5a:	55                   	push   %ebp
  800e5b:	89 e5                	mov    %esp,%ebp
  800e5d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e6a:	74 30                	je     800e9c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e6c:	eb 16                	jmp    800e84 <strlcpy+0x2a>
			*dst++ = *src++;
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8d 50 01             	lea    0x1(%eax),%edx
  800e74:	89 55 08             	mov    %edx,0x8(%ebp)
  800e77:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e7a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e7d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e80:	8a 12                	mov    (%edx),%dl
  800e82:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e84:	ff 4d 10             	decl   0x10(%ebp)
  800e87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e8b:	74 09                	je     800e96 <strlcpy+0x3c>
  800e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e90:	8a 00                	mov    (%eax),%al
  800e92:	84 c0                	test   %al,%al
  800e94:	75 d8                	jne    800e6e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e9c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea2:	29 c2                	sub    %eax,%edx
  800ea4:	89 d0                	mov    %edx,%eax
}
  800ea6:	c9                   	leave  
  800ea7:	c3                   	ret    

00800ea8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ea8:	55                   	push   %ebp
  800ea9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800eab:	eb 06                	jmp    800eb3 <strcmp+0xb>
		p++, q++;
  800ead:	ff 45 08             	incl   0x8(%ebp)
  800eb0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	8a 00                	mov    (%eax),%al
  800eb8:	84 c0                	test   %al,%al
  800eba:	74 0e                	je     800eca <strcmp+0x22>
  800ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebf:	8a 10                	mov    (%eax),%dl
  800ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec4:	8a 00                	mov    (%eax),%al
  800ec6:	38 c2                	cmp    %al,%dl
  800ec8:	74 e3                	je     800ead <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	0f b6 d0             	movzbl %al,%edx
  800ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	0f b6 c0             	movzbl %al,%eax
  800eda:	29 c2                	sub    %eax,%edx
  800edc:	89 d0                	mov    %edx,%eax
}
  800ede:	5d                   	pop    %ebp
  800edf:	c3                   	ret    

00800ee0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ee3:	eb 09                	jmp    800eee <strncmp+0xe>
		n--, p++, q++;
  800ee5:	ff 4d 10             	decl   0x10(%ebp)
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800eee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef2:	74 17                	je     800f0b <strncmp+0x2b>
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	8a 00                	mov    (%eax),%al
  800ef9:	84 c0                	test   %al,%al
  800efb:	74 0e                	je     800f0b <strncmp+0x2b>
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 10                	mov    (%eax),%dl
  800f02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f05:	8a 00                	mov    (%eax),%al
  800f07:	38 c2                	cmp    %al,%dl
  800f09:	74 da                	je     800ee5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f0f:	75 07                	jne    800f18 <strncmp+0x38>
		return 0;
  800f11:	b8 00 00 00 00       	mov    $0x0,%eax
  800f16:	eb 14                	jmp    800f2c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	0f b6 d0             	movzbl %al,%edx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	8a 00                	mov    (%eax),%al
  800f25:	0f b6 c0             	movzbl %al,%eax
  800f28:	29 c2                	sub    %eax,%edx
  800f2a:	89 d0                	mov    %edx,%eax
}
  800f2c:	5d                   	pop    %ebp
  800f2d:	c3                   	ret    

00800f2e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
  800f31:	83 ec 04             	sub    $0x4,%esp
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f3a:	eb 12                	jmp    800f4e <strchr+0x20>
		if (*s == c)
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f44:	75 05                	jne    800f4b <strchr+0x1d>
			return (char *) s;
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	eb 11                	jmp    800f5c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	84 c0                	test   %al,%al
  800f55:	75 e5                	jne    800f3c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f5c:	c9                   	leave  
  800f5d:	c3                   	ret    

00800f5e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f5e:	55                   	push   %ebp
  800f5f:	89 e5                	mov    %esp,%ebp
  800f61:	83 ec 04             	sub    $0x4,%esp
  800f64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f67:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f6a:	eb 0d                	jmp    800f79 <strfind+0x1b>
		if (*s == c)
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f74:	74 0e                	je     800f84 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f76:	ff 45 08             	incl   0x8(%ebp)
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	84 c0                	test   %al,%al
  800f80:	75 ea                	jne    800f6c <strfind+0xe>
  800f82:	eb 01                	jmp    800f85 <strfind+0x27>
		if (*s == c)
			break;
  800f84:	90                   	nop
	return (char *) s;
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f88:	c9                   	leave  
  800f89:	c3                   	ret    

00800f8a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f8a:	55                   	push   %ebp
  800f8b:	89 e5                	mov    %esp,%ebp
  800f8d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f96:	8b 45 10             	mov    0x10(%ebp),%eax
  800f99:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f9c:	eb 0e                	jmp    800fac <memset+0x22>
		*p++ = c;
  800f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa1:	8d 50 01             	lea    0x1(%eax),%edx
  800fa4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fa7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800faa:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fac:	ff 4d f8             	decl   -0x8(%ebp)
  800faf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fb3:	79 e9                	jns    800f9e <memset+0x14>
		*p++ = c;

	return v;
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb8:	c9                   	leave  
  800fb9:	c3                   	ret    

00800fba <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fba:	55                   	push   %ebp
  800fbb:	89 e5                	mov    %esp,%ebp
  800fbd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fcc:	eb 16                	jmp    800fe4 <memcpy+0x2a>
		*d++ = *s++;
  800fce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd1:	8d 50 01             	lea    0x1(%eax),%edx
  800fd4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fda:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fdd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fe0:	8a 12                	mov    (%edx),%dl
  800fe2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fe4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fea:	89 55 10             	mov    %edx,0x10(%ebp)
  800fed:	85 c0                	test   %eax,%eax
  800fef:	75 dd                	jne    800fce <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801008:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80100e:	73 50                	jae    801060 <memmove+0x6a>
  801010:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801013:	8b 45 10             	mov    0x10(%ebp),%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80101b:	76 43                	jbe    801060 <memmove+0x6a>
		s += n;
  80101d:	8b 45 10             	mov    0x10(%ebp),%eax
  801020:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801023:	8b 45 10             	mov    0x10(%ebp),%eax
  801026:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801029:	eb 10                	jmp    80103b <memmove+0x45>
			*--d = *--s;
  80102b:	ff 4d f8             	decl   -0x8(%ebp)
  80102e:	ff 4d fc             	decl   -0x4(%ebp)
  801031:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801034:	8a 10                	mov    (%eax),%dl
  801036:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801039:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80103b:	8b 45 10             	mov    0x10(%ebp),%eax
  80103e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801041:	89 55 10             	mov    %edx,0x10(%ebp)
  801044:	85 c0                	test   %eax,%eax
  801046:	75 e3                	jne    80102b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801048:	eb 23                	jmp    80106d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80104a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104d:	8d 50 01             	lea    0x1(%eax),%edx
  801050:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801053:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801056:	8d 4a 01             	lea    0x1(%edx),%ecx
  801059:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80105c:	8a 12                	mov    (%edx),%dl
  80105e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801060:	8b 45 10             	mov    0x10(%ebp),%eax
  801063:	8d 50 ff             	lea    -0x1(%eax),%edx
  801066:	89 55 10             	mov    %edx,0x10(%ebp)
  801069:	85 c0                	test   %eax,%eax
  80106b:	75 dd                	jne    80104a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801070:	c9                   	leave  
  801071:	c3                   	ret    

00801072 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801072:	55                   	push   %ebp
  801073:	89 e5                	mov    %esp,%ebp
  801075:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801081:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801084:	eb 2a                	jmp    8010b0 <memcmp+0x3e>
		if (*s1 != *s2)
  801086:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801089:	8a 10                	mov    (%eax),%dl
  80108b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108e:	8a 00                	mov    (%eax),%al
  801090:	38 c2                	cmp    %al,%dl
  801092:	74 16                	je     8010aa <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801094:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801097:	8a 00                	mov    (%eax),%al
  801099:	0f b6 d0             	movzbl %al,%edx
  80109c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	0f b6 c0             	movzbl %al,%eax
  8010a4:	29 c2                	sub    %eax,%edx
  8010a6:	89 d0                	mov    %edx,%eax
  8010a8:	eb 18                	jmp    8010c2 <memcmp+0x50>
		s1++, s2++;
  8010aa:	ff 45 fc             	incl   -0x4(%ebp)
  8010ad:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b9:	85 c0                	test   %eax,%eax
  8010bb:	75 c9                	jne    801086 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
  8010c7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8010cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d0:	01 d0                	add    %edx,%eax
  8010d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010d5:	eb 15                	jmp    8010ec <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	0f b6 d0             	movzbl %al,%edx
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	0f b6 c0             	movzbl %al,%eax
  8010e5:	39 c2                	cmp    %eax,%edx
  8010e7:	74 0d                	je     8010f6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010e9:	ff 45 08             	incl   0x8(%ebp)
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010f2:	72 e3                	jb     8010d7 <memfind+0x13>
  8010f4:	eb 01                	jmp    8010f7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010f6:	90                   	nop
	return (void *) s;
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010fa:	c9                   	leave  
  8010fb:	c3                   	ret    

008010fc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010fc:	55                   	push   %ebp
  8010fd:	89 e5                	mov    %esp,%ebp
  8010ff:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801102:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801109:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801110:	eb 03                	jmp    801115 <strtol+0x19>
		s++;
  801112:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	8a 00                	mov    (%eax),%al
  80111a:	3c 20                	cmp    $0x20,%al
  80111c:	74 f4                	je     801112 <strtol+0x16>
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	8a 00                	mov    (%eax),%al
  801123:	3c 09                	cmp    $0x9,%al
  801125:	74 eb                	je     801112 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8a 00                	mov    (%eax),%al
  80112c:	3c 2b                	cmp    $0x2b,%al
  80112e:	75 05                	jne    801135 <strtol+0x39>
		s++;
  801130:	ff 45 08             	incl   0x8(%ebp)
  801133:	eb 13                	jmp    801148 <strtol+0x4c>
	else if (*s == '-')
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
  801138:	8a 00                	mov    (%eax),%al
  80113a:	3c 2d                	cmp    $0x2d,%al
  80113c:	75 0a                	jne    801148 <strtol+0x4c>
		s++, neg = 1;
  80113e:	ff 45 08             	incl   0x8(%ebp)
  801141:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801148:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114c:	74 06                	je     801154 <strtol+0x58>
  80114e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801152:	75 20                	jne    801174 <strtol+0x78>
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	3c 30                	cmp    $0x30,%al
  80115b:	75 17                	jne    801174 <strtol+0x78>
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	40                   	inc    %eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	3c 78                	cmp    $0x78,%al
  801165:	75 0d                	jne    801174 <strtol+0x78>
		s += 2, base = 16;
  801167:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80116b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801172:	eb 28                	jmp    80119c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801174:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801178:	75 15                	jne    80118f <strtol+0x93>
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	3c 30                	cmp    $0x30,%al
  801181:	75 0c                	jne    80118f <strtol+0x93>
		s++, base = 8;
  801183:	ff 45 08             	incl   0x8(%ebp)
  801186:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80118d:	eb 0d                	jmp    80119c <strtol+0xa0>
	else if (base == 0)
  80118f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801193:	75 07                	jne    80119c <strtol+0xa0>
		base = 10;
  801195:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 00                	mov    (%eax),%al
  8011a1:	3c 2f                	cmp    $0x2f,%al
  8011a3:	7e 19                	jle    8011be <strtol+0xc2>
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	3c 39                	cmp    $0x39,%al
  8011ac:	7f 10                	jg     8011be <strtol+0xc2>
			dig = *s - '0';
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	0f be c0             	movsbl %al,%eax
  8011b6:	83 e8 30             	sub    $0x30,%eax
  8011b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011bc:	eb 42                	jmp    801200 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	3c 60                	cmp    $0x60,%al
  8011c5:	7e 19                	jle    8011e0 <strtol+0xe4>
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	3c 7a                	cmp    $0x7a,%al
  8011ce:	7f 10                	jg     8011e0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	8a 00                	mov    (%eax),%al
  8011d5:	0f be c0             	movsbl %al,%eax
  8011d8:	83 e8 57             	sub    $0x57,%eax
  8011db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011de:	eb 20                	jmp    801200 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	3c 40                	cmp    $0x40,%al
  8011e7:	7e 39                	jle    801222 <strtol+0x126>
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	3c 5a                	cmp    $0x5a,%al
  8011f0:	7f 30                	jg     801222 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f5:	8a 00                	mov    (%eax),%al
  8011f7:	0f be c0             	movsbl %al,%eax
  8011fa:	83 e8 37             	sub    $0x37,%eax
  8011fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801200:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801203:	3b 45 10             	cmp    0x10(%ebp),%eax
  801206:	7d 19                	jge    801221 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801208:	ff 45 08             	incl   0x8(%ebp)
  80120b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801212:	89 c2                	mov    %eax,%edx
  801214:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801217:	01 d0                	add    %edx,%eax
  801219:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80121c:	e9 7b ff ff ff       	jmp    80119c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801221:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801222:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801226:	74 08                	je     801230 <strtol+0x134>
		*endptr = (char *) s;
  801228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122b:	8b 55 08             	mov    0x8(%ebp),%edx
  80122e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801230:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801234:	74 07                	je     80123d <strtol+0x141>
  801236:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801239:	f7 d8                	neg    %eax
  80123b:	eb 03                	jmp    801240 <strtol+0x144>
  80123d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <ltostr>:

void
ltostr(long value, char *str)
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
  801245:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80124f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801256:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80125a:	79 13                	jns    80126f <ltostr+0x2d>
	{
		neg = 1;
  80125c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801263:	8b 45 0c             	mov    0xc(%ebp),%eax
  801266:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801269:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80126c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801277:	99                   	cltd   
  801278:	f7 f9                	idiv   %ecx
  80127a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80127d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801280:	8d 50 01             	lea    0x1(%eax),%edx
  801283:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801286:	89 c2                	mov    %eax,%edx
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	01 d0                	add    %edx,%eax
  80128d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801290:	83 c2 30             	add    $0x30,%edx
  801293:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801295:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801298:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80129d:	f7 e9                	imul   %ecx
  80129f:	c1 fa 02             	sar    $0x2,%edx
  8012a2:	89 c8                	mov    %ecx,%eax
  8012a4:	c1 f8 1f             	sar    $0x1f,%eax
  8012a7:	29 c2                	sub    %eax,%edx
  8012a9:	89 d0                	mov    %edx,%eax
  8012ab:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012b1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012b6:	f7 e9                	imul   %ecx
  8012b8:	c1 fa 02             	sar    $0x2,%edx
  8012bb:	89 c8                	mov    %ecx,%eax
  8012bd:	c1 f8 1f             	sar    $0x1f,%eax
  8012c0:	29 c2                	sub    %eax,%edx
  8012c2:	89 d0                	mov    %edx,%eax
  8012c4:	c1 e0 02             	shl    $0x2,%eax
  8012c7:	01 d0                	add    %edx,%eax
  8012c9:	01 c0                	add    %eax,%eax
  8012cb:	29 c1                	sub    %eax,%ecx
  8012cd:	89 ca                	mov    %ecx,%edx
  8012cf:	85 d2                	test   %edx,%edx
  8012d1:	75 9c                	jne    80126f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012dd:	48                   	dec    %eax
  8012de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012e1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012e5:	74 3d                	je     801324 <ltostr+0xe2>
		start = 1 ;
  8012e7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012ee:	eb 34                	jmp    801324 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	01 d0                	add    %edx,%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801300:	8b 45 0c             	mov    0xc(%ebp),%eax
  801303:	01 c2                	add    %eax,%edx
  801305:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130b:	01 c8                	add    %ecx,%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801311:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801314:	8b 45 0c             	mov    0xc(%ebp),%eax
  801317:	01 c2                	add    %eax,%edx
  801319:	8a 45 eb             	mov    -0x15(%ebp),%al
  80131c:	88 02                	mov    %al,(%edx)
		start++ ;
  80131e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801321:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801324:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801327:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80132a:	7c c4                	jl     8012f0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80132c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80132f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801332:	01 d0                	add    %edx,%eax
  801334:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801337:	90                   	nop
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
  80133d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801340:	ff 75 08             	pushl  0x8(%ebp)
  801343:	e8 54 fa ff ff       	call   800d9c <strlen>
  801348:	83 c4 04             	add    $0x4,%esp
  80134b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80134e:	ff 75 0c             	pushl  0xc(%ebp)
  801351:	e8 46 fa ff ff       	call   800d9c <strlen>
  801356:	83 c4 04             	add    $0x4,%esp
  801359:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136a:	eb 17                	jmp    801383 <strcconcat+0x49>
		final[s] = str1[s] ;
  80136c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80136f:	8b 45 10             	mov    0x10(%ebp),%eax
  801372:	01 c2                	add    %eax,%edx
  801374:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	01 c8                	add    %ecx,%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801380:	ff 45 fc             	incl   -0x4(%ebp)
  801383:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801386:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801389:	7c e1                	jl     80136c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80138b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801392:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801399:	eb 1f                	jmp    8013ba <strcconcat+0x80>
		final[s++] = str2[i] ;
  80139b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139e:	8d 50 01             	lea    0x1(%eax),%edx
  8013a1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013a4:	89 c2                	mov    %eax,%edx
  8013a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a9:	01 c2                	add    %eax,%edx
  8013ab:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b1:	01 c8                	add    %ecx,%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013b7:	ff 45 f8             	incl   -0x8(%ebp)
  8013ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013bd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013c0:	7c d9                	jl     80139b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c8:	01 d0                	add    %edx,%eax
  8013ca:	c6 00 00             	movb   $0x0,(%eax)
}
  8013cd:	90                   	nop
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013df:	8b 00                	mov    (%eax),%eax
  8013e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013eb:	01 d0                	add    %edx,%eax
  8013ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013f3:	eb 0c                	jmp    801401 <strsplit+0x31>
			*string++ = 0;
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	8d 50 01             	lea    0x1(%eax),%edx
  8013fb:	89 55 08             	mov    %edx,0x8(%ebp)
  8013fe:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8a 00                	mov    (%eax),%al
  801406:	84 c0                	test   %al,%al
  801408:	74 18                	je     801422 <strsplit+0x52>
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	0f be c0             	movsbl %al,%eax
  801412:	50                   	push   %eax
  801413:	ff 75 0c             	pushl  0xc(%ebp)
  801416:	e8 13 fb ff ff       	call   800f2e <strchr>
  80141b:	83 c4 08             	add    $0x8,%esp
  80141e:	85 c0                	test   %eax,%eax
  801420:	75 d3                	jne    8013f5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	84 c0                	test   %al,%al
  801429:	74 5a                	je     801485 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80142b:	8b 45 14             	mov    0x14(%ebp),%eax
  80142e:	8b 00                	mov    (%eax),%eax
  801430:	83 f8 0f             	cmp    $0xf,%eax
  801433:	75 07                	jne    80143c <strsplit+0x6c>
		{
			return 0;
  801435:	b8 00 00 00 00       	mov    $0x0,%eax
  80143a:	eb 66                	jmp    8014a2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80143c:	8b 45 14             	mov    0x14(%ebp),%eax
  80143f:	8b 00                	mov    (%eax),%eax
  801441:	8d 48 01             	lea    0x1(%eax),%ecx
  801444:	8b 55 14             	mov    0x14(%ebp),%edx
  801447:	89 0a                	mov    %ecx,(%edx)
  801449:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801450:	8b 45 10             	mov    0x10(%ebp),%eax
  801453:	01 c2                	add    %eax,%edx
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80145a:	eb 03                	jmp    80145f <strsplit+0x8f>
			string++;
  80145c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	84 c0                	test   %al,%al
  801466:	74 8b                	je     8013f3 <strsplit+0x23>
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	0f be c0             	movsbl %al,%eax
  801470:	50                   	push   %eax
  801471:	ff 75 0c             	pushl  0xc(%ebp)
  801474:	e8 b5 fa ff ff       	call   800f2e <strchr>
  801479:	83 c4 08             	add    $0x8,%esp
  80147c:	85 c0                	test   %eax,%eax
  80147e:	74 dc                	je     80145c <strsplit+0x8c>
			string++;
	}
  801480:	e9 6e ff ff ff       	jmp    8013f3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801485:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801486:	8b 45 14             	mov    0x14(%ebp),%eax
  801489:	8b 00                	mov    (%eax),%eax
  80148b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801492:	8b 45 10             	mov    0x10(%ebp),%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80149d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
  8014a7:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8014aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ad:	c1 e8 0c             	shr    $0xc,%eax
  8014b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8014b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b6:	25 ff 0f 00 00       	and    $0xfff,%eax
  8014bb:	85 c0                	test   %eax,%eax
  8014bd:	74 03                	je     8014c2 <malloc+0x1e>
			num++;
  8014bf:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8014c2:	a1 04 30 80 00       	mov    0x803004,%eax
  8014c7:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8014cc:	75 73                	jne    801541 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8014ce:	83 ec 08             	sub    $0x8,%esp
  8014d1:	ff 75 08             	pushl  0x8(%ebp)
  8014d4:	68 00 00 00 80       	push   $0x80000000
  8014d9:	e8 13 05 00 00       	call   8019f1 <sys_allocateMem>
  8014de:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8014e1:	a1 04 30 80 00       	mov    0x803004,%eax
  8014e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8014e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ec:	c1 e0 0c             	shl    $0xc,%eax
  8014ef:	89 c2                	mov    %eax,%edx
  8014f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8014f6:	01 d0                	add    %edx,%eax
  8014f8:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8014fd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801502:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801505:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80150c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801511:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801517:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80151e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801523:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80152a:	01 00 00 00 
			sizeofarray++;
  80152e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801533:	40                   	inc    %eax
  801534:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801539:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80153c:	e9 71 01 00 00       	jmp    8016b2 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801541:	a1 28 30 80 00       	mov    0x803028,%eax
  801546:	85 c0                	test   %eax,%eax
  801548:	75 71                	jne    8015bb <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  80154a:	a1 04 30 80 00       	mov    0x803004,%eax
  80154f:	83 ec 08             	sub    $0x8,%esp
  801552:	ff 75 08             	pushl  0x8(%ebp)
  801555:	50                   	push   %eax
  801556:	e8 96 04 00 00       	call   8019f1 <sys_allocateMem>
  80155b:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  80155e:	a1 04 30 80 00       	mov    0x803004,%eax
  801563:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801566:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801569:	c1 e0 0c             	shl    $0xc,%eax
  80156c:	89 c2                	mov    %eax,%edx
  80156e:	a1 04 30 80 00       	mov    0x803004,%eax
  801573:	01 d0                	add    %edx,%eax
  801575:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  80157a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80157f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801582:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801589:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80158e:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801591:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801598:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80159d:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8015a4:	01 00 00 00 
				sizeofarray++;
  8015a8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015ad:	40                   	inc    %eax
  8015ae:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8015b3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015b6:	e9 f7 00 00 00       	jmp    8016b2 <malloc+0x20e>
			}
			else{
				int count=0;
  8015bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8015c2:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8015c9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8015d0:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8015d7:	eb 7c                	jmp    801655 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8015d9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8015e0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8015e7:	eb 1a                	jmp    801603 <malloc+0x15f>
					{
						if(addresses[j]==i)
  8015e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015ec:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8015f6:	75 08                	jne    801600 <malloc+0x15c>
						{
							index=j;
  8015f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8015fe:	eb 0d                	jmp    80160d <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801600:	ff 45 dc             	incl   -0x24(%ebp)
  801603:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801608:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80160b:	7c dc                	jl     8015e9 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80160d:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801611:	75 05                	jne    801618 <malloc+0x174>
					{
						count++;
  801613:	ff 45 f0             	incl   -0x10(%ebp)
  801616:	eb 36                	jmp    80164e <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801618:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80161b:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801622:	85 c0                	test   %eax,%eax
  801624:	75 05                	jne    80162b <malloc+0x187>
						{
							count++;
  801626:	ff 45 f0             	incl   -0x10(%ebp)
  801629:	eb 23                	jmp    80164e <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  80162b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80162e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801631:	7d 14                	jge    801647 <malloc+0x1a3>
  801633:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801636:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801639:	7c 0c                	jl     801647 <malloc+0x1a3>
							{
								min=count;
  80163b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80163e:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801641:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801644:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801647:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80164e:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801655:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80165c:	0f 86 77 ff ff ff    	jbe    8015d9 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801662:	83 ec 08             	sub    $0x8,%esp
  801665:	ff 75 08             	pushl  0x8(%ebp)
  801668:	ff 75 e4             	pushl  -0x1c(%ebp)
  80166b:	e8 81 03 00 00       	call   8019f1 <sys_allocateMem>
  801670:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801673:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801678:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80167b:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801682:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801687:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80168d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801694:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801699:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8016a0:	01 00 00 00 
				sizeofarray++;
  8016a4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016a9:	40                   	inc    %eax
  8016aa:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  8016af:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8016b2:	c9                   	leave  
  8016b3:	c3                   	ret    

008016b4 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8016b4:	55                   	push   %ebp
  8016b5:	89 e5                	mov    %esp,%ebp
  8016b7:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  8016c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8016c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8016ce:	eb 30                	jmp    801700 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8016d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016d3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8016da:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8016dd:	75 1e                	jne    8016fd <free+0x49>
  8016df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016e2:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8016e9:	83 f8 01             	cmp    $0x1,%eax
  8016ec:	75 0f                	jne    8016fd <free+0x49>
    		is_found=1;
  8016ee:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  8016f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  8016fb:	eb 0d                	jmp    80170a <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  8016fd:	ff 45 ec             	incl   -0x14(%ebp)
  801700:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801705:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801708:	7c c6                	jl     8016d0 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  80170a:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  80170e:	75 3a                	jne    80174a <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  801710:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801713:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  80171a:	c1 e0 0c             	shl    $0xc,%eax
  80171d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801720:	83 ec 08             	sub    $0x8,%esp
  801723:	ff 75 e4             	pushl  -0x1c(%ebp)
  801726:	ff 75 e8             	pushl  -0x18(%ebp)
  801729:	e8 a7 02 00 00       	call   8019d5 <sys_freeMem>
  80172e:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801731:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801734:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  80173b:	00 00 00 00 
    	changes++;
  80173f:	a1 28 30 80 00       	mov    0x803028,%eax
  801744:	40                   	inc    %eax
  801745:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  80174a:	90                   	nop
  80174b:	c9                   	leave  
  80174c:	c3                   	ret    

0080174d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
  801750:	83 ec 18             	sub    $0x18,%esp
  801753:	8b 45 10             	mov    0x10(%ebp),%eax
  801756:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801759:	83 ec 04             	sub    $0x4,%esp
  80175c:	68 90 28 80 00       	push   $0x802890
  801761:	68 9f 00 00 00       	push   $0x9f
  801766:	68 b3 28 80 00       	push   $0x8028b3
  80176b:	e8 08 ed ff ff       	call   800478 <_panic>

00801770 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801776:	83 ec 04             	sub    $0x4,%esp
  801779:	68 90 28 80 00       	push   $0x802890
  80177e:	68 a5 00 00 00       	push   $0xa5
  801783:	68 b3 28 80 00       	push   $0x8028b3
  801788:	e8 eb ec ff ff       	call   800478 <_panic>

0080178d <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
  801790:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801793:	83 ec 04             	sub    $0x4,%esp
  801796:	68 90 28 80 00       	push   $0x802890
  80179b:	68 ab 00 00 00       	push   $0xab
  8017a0:	68 b3 28 80 00       	push   $0x8028b3
  8017a5:	e8 ce ec ff ff       	call   800478 <_panic>

008017aa <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
  8017ad:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017b0:	83 ec 04             	sub    $0x4,%esp
  8017b3:	68 90 28 80 00       	push   $0x802890
  8017b8:	68 b0 00 00 00       	push   $0xb0
  8017bd:	68 b3 28 80 00       	push   $0x8028b3
  8017c2:	e8 b1 ec ff ff       	call   800478 <_panic>

008017c7 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
  8017ca:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017cd:	83 ec 04             	sub    $0x4,%esp
  8017d0:	68 90 28 80 00       	push   $0x802890
  8017d5:	68 b6 00 00 00       	push   $0xb6
  8017da:	68 b3 28 80 00       	push   $0x8028b3
  8017df:	e8 94 ec ff ff       	call   800478 <_panic>

008017e4 <shrink>:
}
void shrink(uint32 newSize)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017ea:	83 ec 04             	sub    $0x4,%esp
  8017ed:	68 90 28 80 00       	push   $0x802890
  8017f2:	68 ba 00 00 00       	push   $0xba
  8017f7:	68 b3 28 80 00       	push   $0x8028b3
  8017fc:	e8 77 ec ff ff       	call   800478 <_panic>

00801801 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
  801804:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801807:	83 ec 04             	sub    $0x4,%esp
  80180a:	68 90 28 80 00       	push   $0x802890
  80180f:	68 bf 00 00 00       	push   $0xbf
  801814:	68 b3 28 80 00       	push   $0x8028b3
  801819:	e8 5a ec ff ff       	call   800478 <_panic>

0080181e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
  801821:	57                   	push   %edi
  801822:	56                   	push   %esi
  801823:	53                   	push   %ebx
  801824:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801827:	8b 45 08             	mov    0x8(%ebp),%eax
  80182a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801830:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801833:	8b 7d 18             	mov    0x18(%ebp),%edi
  801836:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801839:	cd 30                	int    $0x30
  80183b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80183e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801841:	83 c4 10             	add    $0x10,%esp
  801844:	5b                   	pop    %ebx
  801845:	5e                   	pop    %esi
  801846:	5f                   	pop    %edi
  801847:	5d                   	pop    %ebp
  801848:	c3                   	ret    

00801849 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
  80184c:	83 ec 04             	sub    $0x4,%esp
  80184f:	8b 45 10             	mov    0x10(%ebp),%eax
  801852:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801855:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	52                   	push   %edx
  801861:	ff 75 0c             	pushl  0xc(%ebp)
  801864:	50                   	push   %eax
  801865:	6a 00                	push   $0x0
  801867:	e8 b2 ff ff ff       	call   80181e <syscall>
  80186c:	83 c4 18             	add    $0x18,%esp
}
  80186f:	90                   	nop
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <sys_cgetc>:

int
sys_cgetc(void)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 01                	push   $0x1
  801881:	e8 98 ff ff ff       	call   80181e <syscall>
  801886:	83 c4 18             	add    $0x18,%esp
}
  801889:	c9                   	leave  
  80188a:	c3                   	ret    

0080188b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	50                   	push   %eax
  80189a:	6a 05                	push   $0x5
  80189c:	e8 7d ff ff ff       	call   80181e <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 02                	push   $0x2
  8018b5:	e8 64 ff ff ff       	call   80181e <syscall>
  8018ba:	83 c4 18             	add    $0x18,%esp
}
  8018bd:	c9                   	leave  
  8018be:	c3                   	ret    

008018bf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018bf:	55                   	push   %ebp
  8018c0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 03                	push   $0x3
  8018ce:	e8 4b ff ff ff       	call   80181e <syscall>
  8018d3:	83 c4 18             	add    $0x18,%esp
}
  8018d6:	c9                   	leave  
  8018d7:	c3                   	ret    

008018d8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 04                	push   $0x4
  8018e7:	e8 32 ff ff ff       	call   80181e <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_env_exit>:


void sys_env_exit(void)
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 06                	push   $0x6
  801900:	e8 19 ff ff ff       	call   80181e <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
}
  801908:	90                   	nop
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80190e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	52                   	push   %edx
  80191b:	50                   	push   %eax
  80191c:	6a 07                	push   $0x7
  80191e:	e8 fb fe ff ff       	call   80181e <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
  80192b:	56                   	push   %esi
  80192c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80192d:	8b 75 18             	mov    0x18(%ebp),%esi
  801930:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801933:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801936:	8b 55 0c             	mov    0xc(%ebp),%edx
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	56                   	push   %esi
  80193d:	53                   	push   %ebx
  80193e:	51                   	push   %ecx
  80193f:	52                   	push   %edx
  801940:	50                   	push   %eax
  801941:	6a 08                	push   $0x8
  801943:	e8 d6 fe ff ff       	call   80181e <syscall>
  801948:	83 c4 18             	add    $0x18,%esp
}
  80194b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80194e:	5b                   	pop    %ebx
  80194f:	5e                   	pop    %esi
  801950:	5d                   	pop    %ebp
  801951:	c3                   	ret    

00801952 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801955:	8b 55 0c             	mov    0xc(%ebp),%edx
  801958:	8b 45 08             	mov    0x8(%ebp),%eax
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	52                   	push   %edx
  801962:	50                   	push   %eax
  801963:	6a 09                	push   $0x9
  801965:	e8 b4 fe ff ff       	call   80181e <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	ff 75 0c             	pushl  0xc(%ebp)
  80197b:	ff 75 08             	pushl  0x8(%ebp)
  80197e:	6a 0a                	push   $0xa
  801980:	e8 99 fe ff ff       	call   80181e <syscall>
  801985:	83 c4 18             	add    $0x18,%esp
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 0b                	push   $0xb
  801999:	e8 80 fe ff ff       	call   80181e <syscall>
  80199e:	83 c4 18             	add    $0x18,%esp
}
  8019a1:	c9                   	leave  
  8019a2:	c3                   	ret    

008019a3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019a3:	55                   	push   %ebp
  8019a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 0c                	push   $0xc
  8019b2:	e8 67 fe ff ff       	call   80181e <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
}
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 0d                	push   $0xd
  8019cb:	e8 4e fe ff ff       	call   80181e <syscall>
  8019d0:	83 c4 18             	add    $0x18,%esp
}
  8019d3:	c9                   	leave  
  8019d4:	c3                   	ret    

008019d5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019d5:	55                   	push   %ebp
  8019d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	ff 75 0c             	pushl  0xc(%ebp)
  8019e1:	ff 75 08             	pushl  0x8(%ebp)
  8019e4:	6a 11                	push   $0x11
  8019e6:	e8 33 fe ff ff       	call   80181e <syscall>
  8019eb:	83 c4 18             	add    $0x18,%esp
	return;
  8019ee:	90                   	nop
}
  8019ef:	c9                   	leave  
  8019f0:	c3                   	ret    

008019f1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019f1:	55                   	push   %ebp
  8019f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	ff 75 0c             	pushl  0xc(%ebp)
  8019fd:	ff 75 08             	pushl  0x8(%ebp)
  801a00:	6a 12                	push   $0x12
  801a02:	e8 17 fe ff ff       	call   80181e <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0a:	90                   	nop
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 0e                	push   $0xe
  801a1c:	e8 fd fd ff ff       	call   80181e <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	ff 75 08             	pushl  0x8(%ebp)
  801a34:	6a 0f                	push   $0xf
  801a36:	e8 e3 fd ff ff       	call   80181e <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
}
  801a3e:	c9                   	leave  
  801a3f:	c3                   	ret    

00801a40 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a40:	55                   	push   %ebp
  801a41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 10                	push   $0x10
  801a4f:	e8 ca fd ff ff       	call   80181e <syscall>
  801a54:	83 c4 18             	add    $0x18,%esp
}
  801a57:	90                   	nop
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 14                	push   $0x14
  801a69:	e8 b0 fd ff ff       	call   80181e <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	90                   	nop
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 15                	push   $0x15
  801a83:	e8 96 fd ff ff       	call   80181e <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	90                   	nop
  801a8c:	c9                   	leave  
  801a8d:	c3                   	ret    

00801a8e <sys_cputc>:


void
sys_cputc(const char c)
{
  801a8e:	55                   	push   %ebp
  801a8f:	89 e5                	mov    %esp,%ebp
  801a91:	83 ec 04             	sub    $0x4,%esp
  801a94:	8b 45 08             	mov    0x8(%ebp),%eax
  801a97:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a9a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	50                   	push   %eax
  801aa7:	6a 16                	push   $0x16
  801aa9:	e8 70 fd ff ff       	call   80181e <syscall>
  801aae:	83 c4 18             	add    $0x18,%esp
}
  801ab1:	90                   	nop
  801ab2:	c9                   	leave  
  801ab3:	c3                   	ret    

00801ab4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 17                	push   $0x17
  801ac3:	e8 56 fd ff ff       	call   80181e <syscall>
  801ac8:	83 c4 18             	add    $0x18,%esp
}
  801acb:	90                   	nop
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	ff 75 0c             	pushl  0xc(%ebp)
  801add:	50                   	push   %eax
  801ade:	6a 18                	push   $0x18
  801ae0:	e8 39 fd ff ff       	call   80181e <syscall>
  801ae5:	83 c4 18             	add    $0x18,%esp
}
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801aed:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af0:	8b 45 08             	mov    0x8(%ebp),%eax
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	52                   	push   %edx
  801afa:	50                   	push   %eax
  801afb:	6a 1b                	push   $0x1b
  801afd:	e8 1c fd ff ff       	call   80181e <syscall>
  801b02:	83 c4 18             	add    $0x18,%esp
}
  801b05:	c9                   	leave  
  801b06:	c3                   	ret    

00801b07 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b07:	55                   	push   %ebp
  801b08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	52                   	push   %edx
  801b17:	50                   	push   %eax
  801b18:	6a 19                	push   $0x19
  801b1a:	e8 ff fc ff ff       	call   80181e <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
}
  801b22:	90                   	nop
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	52                   	push   %edx
  801b35:	50                   	push   %eax
  801b36:	6a 1a                	push   $0x1a
  801b38:	e8 e1 fc ff ff       	call   80181e <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	90                   	nop
  801b41:	c9                   	leave  
  801b42:	c3                   	ret    

00801b43 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
  801b46:	83 ec 04             	sub    $0x4,%esp
  801b49:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b4f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b52:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b56:	8b 45 08             	mov    0x8(%ebp),%eax
  801b59:	6a 00                	push   $0x0
  801b5b:	51                   	push   %ecx
  801b5c:	52                   	push   %edx
  801b5d:	ff 75 0c             	pushl  0xc(%ebp)
  801b60:	50                   	push   %eax
  801b61:	6a 1c                	push   $0x1c
  801b63:	e8 b6 fc ff ff       	call   80181e <syscall>
  801b68:	83 c4 18             	add    $0x18,%esp
}
  801b6b:	c9                   	leave  
  801b6c:	c3                   	ret    

00801b6d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b6d:	55                   	push   %ebp
  801b6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b73:	8b 45 08             	mov    0x8(%ebp),%eax
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	52                   	push   %edx
  801b7d:	50                   	push   %eax
  801b7e:	6a 1d                	push   $0x1d
  801b80:	e8 99 fc ff ff       	call   80181e <syscall>
  801b85:	83 c4 18             	add    $0x18,%esp
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b8d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b93:	8b 45 08             	mov    0x8(%ebp),%eax
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	51                   	push   %ecx
  801b9b:	52                   	push   %edx
  801b9c:	50                   	push   %eax
  801b9d:	6a 1e                	push   $0x1e
  801b9f:	e8 7a fc ff ff       	call   80181e <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
}
  801ba7:	c9                   	leave  
  801ba8:	c3                   	ret    

00801ba9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ba9:	55                   	push   %ebp
  801baa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801baf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	52                   	push   %edx
  801bb9:	50                   	push   %eax
  801bba:	6a 1f                	push   $0x1f
  801bbc:	e8 5d fc ff ff       	call   80181e <syscall>
  801bc1:	83 c4 18             	add    $0x18,%esp
}
  801bc4:	c9                   	leave  
  801bc5:	c3                   	ret    

00801bc6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 20                	push   $0x20
  801bd5:	e8 44 fc ff ff       	call   80181e <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
}
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	6a 00                	push   $0x0
  801be7:	ff 75 14             	pushl  0x14(%ebp)
  801bea:	ff 75 10             	pushl  0x10(%ebp)
  801bed:	ff 75 0c             	pushl  0xc(%ebp)
  801bf0:	50                   	push   %eax
  801bf1:	6a 21                	push   $0x21
  801bf3:	e8 26 fc ff ff       	call   80181e <syscall>
  801bf8:	83 c4 18             	add    $0x18,%esp
}
  801bfb:	c9                   	leave  
  801bfc:	c3                   	ret    

00801bfd <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bfd:	55                   	push   %ebp
  801bfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	50                   	push   %eax
  801c0c:	6a 22                	push   $0x22
  801c0e:	e8 0b fc ff ff       	call   80181e <syscall>
  801c13:	83 c4 18             	add    $0x18,%esp
}
  801c16:	90                   	nop
  801c17:	c9                   	leave  
  801c18:	c3                   	ret    

00801c19 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	50                   	push   %eax
  801c28:	6a 23                	push   $0x23
  801c2a:	e8 ef fb ff ff       	call   80181e <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
}
  801c32:	90                   	nop
  801c33:	c9                   	leave  
  801c34:	c3                   	ret    

00801c35 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c35:	55                   	push   %ebp
  801c36:	89 e5                	mov    %esp,%ebp
  801c38:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c3b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c3e:	8d 50 04             	lea    0x4(%eax),%edx
  801c41:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	52                   	push   %edx
  801c4b:	50                   	push   %eax
  801c4c:	6a 24                	push   $0x24
  801c4e:	e8 cb fb ff ff       	call   80181e <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
	return result;
  801c56:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c5c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c5f:	89 01                	mov    %eax,(%ecx)
  801c61:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c64:	8b 45 08             	mov    0x8(%ebp),%eax
  801c67:	c9                   	leave  
  801c68:	c2 04 00             	ret    $0x4

00801c6b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c6b:	55                   	push   %ebp
  801c6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	ff 75 10             	pushl  0x10(%ebp)
  801c75:	ff 75 0c             	pushl  0xc(%ebp)
  801c78:	ff 75 08             	pushl  0x8(%ebp)
  801c7b:	6a 13                	push   $0x13
  801c7d:	e8 9c fb ff ff       	call   80181e <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
	return ;
  801c85:	90                   	nop
}
  801c86:	c9                   	leave  
  801c87:	c3                   	ret    

00801c88 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 25                	push   $0x25
  801c97:	e8 82 fb ff ff       	call   80181e <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	c9                   	leave  
  801ca0:	c3                   	ret    

00801ca1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
  801ca4:	83 ec 04             	sub    $0x4,%esp
  801ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  801caa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cad:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	50                   	push   %eax
  801cba:	6a 26                	push   $0x26
  801cbc:	e8 5d fb ff ff       	call   80181e <syscall>
  801cc1:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc4:	90                   	nop
}
  801cc5:	c9                   	leave  
  801cc6:	c3                   	ret    

00801cc7 <rsttst>:
void rsttst()
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 28                	push   $0x28
  801cd6:	e8 43 fb ff ff       	call   80181e <syscall>
  801cdb:	83 c4 18             	add    $0x18,%esp
	return ;
  801cde:	90                   	nop
}
  801cdf:	c9                   	leave  
  801ce0:	c3                   	ret    

00801ce1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
  801ce4:	83 ec 04             	sub    $0x4,%esp
  801ce7:	8b 45 14             	mov    0x14(%ebp),%eax
  801cea:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ced:	8b 55 18             	mov    0x18(%ebp),%edx
  801cf0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cf4:	52                   	push   %edx
  801cf5:	50                   	push   %eax
  801cf6:	ff 75 10             	pushl  0x10(%ebp)
  801cf9:	ff 75 0c             	pushl  0xc(%ebp)
  801cfc:	ff 75 08             	pushl  0x8(%ebp)
  801cff:	6a 27                	push   $0x27
  801d01:	e8 18 fb ff ff       	call   80181e <syscall>
  801d06:	83 c4 18             	add    $0x18,%esp
	return ;
  801d09:	90                   	nop
}
  801d0a:	c9                   	leave  
  801d0b:	c3                   	ret    

00801d0c <chktst>:
void chktst(uint32 n)
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	ff 75 08             	pushl  0x8(%ebp)
  801d1a:	6a 29                	push   $0x29
  801d1c:	e8 fd fa ff ff       	call   80181e <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
	return ;
  801d24:	90                   	nop
}
  801d25:	c9                   	leave  
  801d26:	c3                   	ret    

00801d27 <inctst>:

void inctst()
{
  801d27:	55                   	push   %ebp
  801d28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 2a                	push   $0x2a
  801d36:	e8 e3 fa ff ff       	call   80181e <syscall>
  801d3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d3e:	90                   	nop
}
  801d3f:	c9                   	leave  
  801d40:	c3                   	ret    

00801d41 <gettst>:
uint32 gettst()
{
  801d41:	55                   	push   %ebp
  801d42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 2b                	push   $0x2b
  801d50:	e8 c9 fa ff ff       	call   80181e <syscall>
  801d55:	83 c4 18             	add    $0x18,%esp
}
  801d58:	c9                   	leave  
  801d59:	c3                   	ret    

00801d5a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
  801d5d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 2c                	push   $0x2c
  801d6c:	e8 ad fa ff ff       	call   80181e <syscall>
  801d71:	83 c4 18             	add    $0x18,%esp
  801d74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d77:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d7b:	75 07                	jne    801d84 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d7d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d82:	eb 05                	jmp    801d89 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d84:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d89:	c9                   	leave  
  801d8a:	c3                   	ret    

00801d8b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
  801d8e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 2c                	push   $0x2c
  801d9d:	e8 7c fa ff ff       	call   80181e <syscall>
  801da2:	83 c4 18             	add    $0x18,%esp
  801da5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801da8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801dac:	75 07                	jne    801db5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801dae:	b8 01 00 00 00       	mov    $0x1,%eax
  801db3:	eb 05                	jmp    801dba <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801db5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dba:	c9                   	leave  
  801dbb:	c3                   	ret    

00801dbc <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801dbc:	55                   	push   %ebp
  801dbd:	89 e5                	mov    %esp,%ebp
  801dbf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 2c                	push   $0x2c
  801dce:	e8 4b fa ff ff       	call   80181e <syscall>
  801dd3:	83 c4 18             	add    $0x18,%esp
  801dd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801dd9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ddd:	75 07                	jne    801de6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ddf:	b8 01 00 00 00       	mov    $0x1,%eax
  801de4:	eb 05                	jmp    801deb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801de6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801deb:	c9                   	leave  
  801dec:	c3                   	ret    

00801ded <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ded:	55                   	push   %ebp
  801dee:	89 e5                	mov    %esp,%ebp
  801df0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 2c                	push   $0x2c
  801dff:	e8 1a fa ff ff       	call   80181e <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
  801e07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e0a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e0e:	75 07                	jne    801e17 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e10:	b8 01 00 00 00       	mov    $0x1,%eax
  801e15:	eb 05                	jmp    801e1c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e1c:	c9                   	leave  
  801e1d:	c3                   	ret    

00801e1e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e1e:	55                   	push   %ebp
  801e1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	ff 75 08             	pushl  0x8(%ebp)
  801e2c:	6a 2d                	push   $0x2d
  801e2e:	e8 eb f9 ff ff       	call   80181e <syscall>
  801e33:	83 c4 18             	add    $0x18,%esp
	return ;
  801e36:	90                   	nop
}
  801e37:	c9                   	leave  
  801e38:	c3                   	ret    

00801e39 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
  801e3c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e3d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e40:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e43:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e46:	8b 45 08             	mov    0x8(%ebp),%eax
  801e49:	6a 00                	push   $0x0
  801e4b:	53                   	push   %ebx
  801e4c:	51                   	push   %ecx
  801e4d:	52                   	push   %edx
  801e4e:	50                   	push   %eax
  801e4f:	6a 2e                	push   $0x2e
  801e51:	e8 c8 f9 ff ff       	call   80181e <syscall>
  801e56:	83 c4 18             	add    $0x18,%esp
}
  801e59:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e64:	8b 45 08             	mov    0x8(%ebp),%eax
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	52                   	push   %edx
  801e6e:	50                   	push   %eax
  801e6f:	6a 2f                	push   $0x2f
  801e71:	e8 a8 f9 ff ff       	call   80181e <syscall>
  801e76:	83 c4 18             	add    $0x18,%esp
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    
  801e7b:	90                   	nop

00801e7c <__udivdi3>:
  801e7c:	55                   	push   %ebp
  801e7d:	57                   	push   %edi
  801e7e:	56                   	push   %esi
  801e7f:	53                   	push   %ebx
  801e80:	83 ec 1c             	sub    $0x1c,%esp
  801e83:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e87:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e8b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e8f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e93:	89 ca                	mov    %ecx,%edx
  801e95:	89 f8                	mov    %edi,%eax
  801e97:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e9b:	85 f6                	test   %esi,%esi
  801e9d:	75 2d                	jne    801ecc <__udivdi3+0x50>
  801e9f:	39 cf                	cmp    %ecx,%edi
  801ea1:	77 65                	ja     801f08 <__udivdi3+0x8c>
  801ea3:	89 fd                	mov    %edi,%ebp
  801ea5:	85 ff                	test   %edi,%edi
  801ea7:	75 0b                	jne    801eb4 <__udivdi3+0x38>
  801ea9:	b8 01 00 00 00       	mov    $0x1,%eax
  801eae:	31 d2                	xor    %edx,%edx
  801eb0:	f7 f7                	div    %edi
  801eb2:	89 c5                	mov    %eax,%ebp
  801eb4:	31 d2                	xor    %edx,%edx
  801eb6:	89 c8                	mov    %ecx,%eax
  801eb8:	f7 f5                	div    %ebp
  801eba:	89 c1                	mov    %eax,%ecx
  801ebc:	89 d8                	mov    %ebx,%eax
  801ebe:	f7 f5                	div    %ebp
  801ec0:	89 cf                	mov    %ecx,%edi
  801ec2:	89 fa                	mov    %edi,%edx
  801ec4:	83 c4 1c             	add    $0x1c,%esp
  801ec7:	5b                   	pop    %ebx
  801ec8:	5e                   	pop    %esi
  801ec9:	5f                   	pop    %edi
  801eca:	5d                   	pop    %ebp
  801ecb:	c3                   	ret    
  801ecc:	39 ce                	cmp    %ecx,%esi
  801ece:	77 28                	ja     801ef8 <__udivdi3+0x7c>
  801ed0:	0f bd fe             	bsr    %esi,%edi
  801ed3:	83 f7 1f             	xor    $0x1f,%edi
  801ed6:	75 40                	jne    801f18 <__udivdi3+0x9c>
  801ed8:	39 ce                	cmp    %ecx,%esi
  801eda:	72 0a                	jb     801ee6 <__udivdi3+0x6a>
  801edc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ee0:	0f 87 9e 00 00 00    	ja     801f84 <__udivdi3+0x108>
  801ee6:	b8 01 00 00 00       	mov    $0x1,%eax
  801eeb:	89 fa                	mov    %edi,%edx
  801eed:	83 c4 1c             	add    $0x1c,%esp
  801ef0:	5b                   	pop    %ebx
  801ef1:	5e                   	pop    %esi
  801ef2:	5f                   	pop    %edi
  801ef3:	5d                   	pop    %ebp
  801ef4:	c3                   	ret    
  801ef5:	8d 76 00             	lea    0x0(%esi),%esi
  801ef8:	31 ff                	xor    %edi,%edi
  801efa:	31 c0                	xor    %eax,%eax
  801efc:	89 fa                	mov    %edi,%edx
  801efe:	83 c4 1c             	add    $0x1c,%esp
  801f01:	5b                   	pop    %ebx
  801f02:	5e                   	pop    %esi
  801f03:	5f                   	pop    %edi
  801f04:	5d                   	pop    %ebp
  801f05:	c3                   	ret    
  801f06:	66 90                	xchg   %ax,%ax
  801f08:	89 d8                	mov    %ebx,%eax
  801f0a:	f7 f7                	div    %edi
  801f0c:	31 ff                	xor    %edi,%edi
  801f0e:	89 fa                	mov    %edi,%edx
  801f10:	83 c4 1c             	add    $0x1c,%esp
  801f13:	5b                   	pop    %ebx
  801f14:	5e                   	pop    %esi
  801f15:	5f                   	pop    %edi
  801f16:	5d                   	pop    %ebp
  801f17:	c3                   	ret    
  801f18:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f1d:	89 eb                	mov    %ebp,%ebx
  801f1f:	29 fb                	sub    %edi,%ebx
  801f21:	89 f9                	mov    %edi,%ecx
  801f23:	d3 e6                	shl    %cl,%esi
  801f25:	89 c5                	mov    %eax,%ebp
  801f27:	88 d9                	mov    %bl,%cl
  801f29:	d3 ed                	shr    %cl,%ebp
  801f2b:	89 e9                	mov    %ebp,%ecx
  801f2d:	09 f1                	or     %esi,%ecx
  801f2f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f33:	89 f9                	mov    %edi,%ecx
  801f35:	d3 e0                	shl    %cl,%eax
  801f37:	89 c5                	mov    %eax,%ebp
  801f39:	89 d6                	mov    %edx,%esi
  801f3b:	88 d9                	mov    %bl,%cl
  801f3d:	d3 ee                	shr    %cl,%esi
  801f3f:	89 f9                	mov    %edi,%ecx
  801f41:	d3 e2                	shl    %cl,%edx
  801f43:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f47:	88 d9                	mov    %bl,%cl
  801f49:	d3 e8                	shr    %cl,%eax
  801f4b:	09 c2                	or     %eax,%edx
  801f4d:	89 d0                	mov    %edx,%eax
  801f4f:	89 f2                	mov    %esi,%edx
  801f51:	f7 74 24 0c          	divl   0xc(%esp)
  801f55:	89 d6                	mov    %edx,%esi
  801f57:	89 c3                	mov    %eax,%ebx
  801f59:	f7 e5                	mul    %ebp
  801f5b:	39 d6                	cmp    %edx,%esi
  801f5d:	72 19                	jb     801f78 <__udivdi3+0xfc>
  801f5f:	74 0b                	je     801f6c <__udivdi3+0xf0>
  801f61:	89 d8                	mov    %ebx,%eax
  801f63:	31 ff                	xor    %edi,%edi
  801f65:	e9 58 ff ff ff       	jmp    801ec2 <__udivdi3+0x46>
  801f6a:	66 90                	xchg   %ax,%ax
  801f6c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f70:	89 f9                	mov    %edi,%ecx
  801f72:	d3 e2                	shl    %cl,%edx
  801f74:	39 c2                	cmp    %eax,%edx
  801f76:	73 e9                	jae    801f61 <__udivdi3+0xe5>
  801f78:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f7b:	31 ff                	xor    %edi,%edi
  801f7d:	e9 40 ff ff ff       	jmp    801ec2 <__udivdi3+0x46>
  801f82:	66 90                	xchg   %ax,%ax
  801f84:	31 c0                	xor    %eax,%eax
  801f86:	e9 37 ff ff ff       	jmp    801ec2 <__udivdi3+0x46>
  801f8b:	90                   	nop

00801f8c <__umoddi3>:
  801f8c:	55                   	push   %ebp
  801f8d:	57                   	push   %edi
  801f8e:	56                   	push   %esi
  801f8f:	53                   	push   %ebx
  801f90:	83 ec 1c             	sub    $0x1c,%esp
  801f93:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f97:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f9b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f9f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fa3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801fa7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801fab:	89 f3                	mov    %esi,%ebx
  801fad:	89 fa                	mov    %edi,%edx
  801faf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fb3:	89 34 24             	mov    %esi,(%esp)
  801fb6:	85 c0                	test   %eax,%eax
  801fb8:	75 1a                	jne    801fd4 <__umoddi3+0x48>
  801fba:	39 f7                	cmp    %esi,%edi
  801fbc:	0f 86 a2 00 00 00    	jbe    802064 <__umoddi3+0xd8>
  801fc2:	89 c8                	mov    %ecx,%eax
  801fc4:	89 f2                	mov    %esi,%edx
  801fc6:	f7 f7                	div    %edi
  801fc8:	89 d0                	mov    %edx,%eax
  801fca:	31 d2                	xor    %edx,%edx
  801fcc:	83 c4 1c             	add    $0x1c,%esp
  801fcf:	5b                   	pop    %ebx
  801fd0:	5e                   	pop    %esi
  801fd1:	5f                   	pop    %edi
  801fd2:	5d                   	pop    %ebp
  801fd3:	c3                   	ret    
  801fd4:	39 f0                	cmp    %esi,%eax
  801fd6:	0f 87 ac 00 00 00    	ja     802088 <__umoddi3+0xfc>
  801fdc:	0f bd e8             	bsr    %eax,%ebp
  801fdf:	83 f5 1f             	xor    $0x1f,%ebp
  801fe2:	0f 84 ac 00 00 00    	je     802094 <__umoddi3+0x108>
  801fe8:	bf 20 00 00 00       	mov    $0x20,%edi
  801fed:	29 ef                	sub    %ebp,%edi
  801fef:	89 fe                	mov    %edi,%esi
  801ff1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ff5:	89 e9                	mov    %ebp,%ecx
  801ff7:	d3 e0                	shl    %cl,%eax
  801ff9:	89 d7                	mov    %edx,%edi
  801ffb:	89 f1                	mov    %esi,%ecx
  801ffd:	d3 ef                	shr    %cl,%edi
  801fff:	09 c7                	or     %eax,%edi
  802001:	89 e9                	mov    %ebp,%ecx
  802003:	d3 e2                	shl    %cl,%edx
  802005:	89 14 24             	mov    %edx,(%esp)
  802008:	89 d8                	mov    %ebx,%eax
  80200a:	d3 e0                	shl    %cl,%eax
  80200c:	89 c2                	mov    %eax,%edx
  80200e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802012:	d3 e0                	shl    %cl,%eax
  802014:	89 44 24 04          	mov    %eax,0x4(%esp)
  802018:	8b 44 24 08          	mov    0x8(%esp),%eax
  80201c:	89 f1                	mov    %esi,%ecx
  80201e:	d3 e8                	shr    %cl,%eax
  802020:	09 d0                	or     %edx,%eax
  802022:	d3 eb                	shr    %cl,%ebx
  802024:	89 da                	mov    %ebx,%edx
  802026:	f7 f7                	div    %edi
  802028:	89 d3                	mov    %edx,%ebx
  80202a:	f7 24 24             	mull   (%esp)
  80202d:	89 c6                	mov    %eax,%esi
  80202f:	89 d1                	mov    %edx,%ecx
  802031:	39 d3                	cmp    %edx,%ebx
  802033:	0f 82 87 00 00 00    	jb     8020c0 <__umoddi3+0x134>
  802039:	0f 84 91 00 00 00    	je     8020d0 <__umoddi3+0x144>
  80203f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802043:	29 f2                	sub    %esi,%edx
  802045:	19 cb                	sbb    %ecx,%ebx
  802047:	89 d8                	mov    %ebx,%eax
  802049:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80204d:	d3 e0                	shl    %cl,%eax
  80204f:	89 e9                	mov    %ebp,%ecx
  802051:	d3 ea                	shr    %cl,%edx
  802053:	09 d0                	or     %edx,%eax
  802055:	89 e9                	mov    %ebp,%ecx
  802057:	d3 eb                	shr    %cl,%ebx
  802059:	89 da                	mov    %ebx,%edx
  80205b:	83 c4 1c             	add    $0x1c,%esp
  80205e:	5b                   	pop    %ebx
  80205f:	5e                   	pop    %esi
  802060:	5f                   	pop    %edi
  802061:	5d                   	pop    %ebp
  802062:	c3                   	ret    
  802063:	90                   	nop
  802064:	89 fd                	mov    %edi,%ebp
  802066:	85 ff                	test   %edi,%edi
  802068:	75 0b                	jne    802075 <__umoddi3+0xe9>
  80206a:	b8 01 00 00 00       	mov    $0x1,%eax
  80206f:	31 d2                	xor    %edx,%edx
  802071:	f7 f7                	div    %edi
  802073:	89 c5                	mov    %eax,%ebp
  802075:	89 f0                	mov    %esi,%eax
  802077:	31 d2                	xor    %edx,%edx
  802079:	f7 f5                	div    %ebp
  80207b:	89 c8                	mov    %ecx,%eax
  80207d:	f7 f5                	div    %ebp
  80207f:	89 d0                	mov    %edx,%eax
  802081:	e9 44 ff ff ff       	jmp    801fca <__umoddi3+0x3e>
  802086:	66 90                	xchg   %ax,%ax
  802088:	89 c8                	mov    %ecx,%eax
  80208a:	89 f2                	mov    %esi,%edx
  80208c:	83 c4 1c             	add    $0x1c,%esp
  80208f:	5b                   	pop    %ebx
  802090:	5e                   	pop    %esi
  802091:	5f                   	pop    %edi
  802092:	5d                   	pop    %ebp
  802093:	c3                   	ret    
  802094:	3b 04 24             	cmp    (%esp),%eax
  802097:	72 06                	jb     80209f <__umoddi3+0x113>
  802099:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80209d:	77 0f                	ja     8020ae <__umoddi3+0x122>
  80209f:	89 f2                	mov    %esi,%edx
  8020a1:	29 f9                	sub    %edi,%ecx
  8020a3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020a7:	89 14 24             	mov    %edx,(%esp)
  8020aa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020ae:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020b2:	8b 14 24             	mov    (%esp),%edx
  8020b5:	83 c4 1c             	add    $0x1c,%esp
  8020b8:	5b                   	pop    %ebx
  8020b9:	5e                   	pop    %esi
  8020ba:	5f                   	pop    %edi
  8020bb:	5d                   	pop    %ebp
  8020bc:	c3                   	ret    
  8020bd:	8d 76 00             	lea    0x0(%esi),%esi
  8020c0:	2b 04 24             	sub    (%esp),%eax
  8020c3:	19 fa                	sbb    %edi,%edx
  8020c5:	89 d1                	mov    %edx,%ecx
  8020c7:	89 c6                	mov    %eax,%esi
  8020c9:	e9 71 ff ff ff       	jmp    80203f <__umoddi3+0xb3>
  8020ce:	66 90                	xchg   %ax,%ax
  8020d0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020d4:	72 ea                	jb     8020c0 <__umoddi3+0x134>
  8020d6:	89 d9                	mov    %ebx,%ecx
  8020d8:	e9 62 ff ff ff       	jmp    80203f <__umoddi3+0xb3>
