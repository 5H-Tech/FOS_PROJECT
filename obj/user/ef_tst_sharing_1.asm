
obj/user/ef_tst_sharing_1:     file format elf32-i386


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
  800031:	e8 5e 03 00 00       	call   800394 <libmain>
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
  800087:	68 80 20 80 00       	push   $0x802080
  80008c:	6a 12                	push   $0x12
  80008e:	68 9c 20 80 00       	push   $0x80209c
  800093:	e8 41 04 00 00       	call   8004d9 <_panic>
	}

	uint32 *x, *y, *z ;
	cprintf("STEP A: checking the creation of shared variables... \n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 b4 20 80 00       	push   $0x8020b4
  8000a0:	e8 d6 06 00 00       	call   80077b <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000a8:	e8 65 18 00 00       	call   801912 <sys_calculate_free_frames>
  8000ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000b0:	83 ec 04             	sub    $0x4,%esp
  8000b3:	6a 01                	push   $0x1
  8000b5:	68 00 10 00 00       	push   $0x1000
  8000ba:	68 eb 20 80 00       	push   $0x8020eb
  8000bf:	e8 11 16 00 00       	call   8016d5 <smalloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000ca:	81 7d e4 00 00 00 80 	cmpl   $0x80000000,-0x1c(%ebp)
  8000d1:	74 14                	je     8000e7 <_main+0xaf>
  8000d3:	83 ec 04             	sub    $0x4,%esp
  8000d6:	68 f0 20 80 00       	push   $0x8020f0
  8000db:	6a 1a                	push   $0x1a
  8000dd:	68 9c 20 80 00       	push   $0x80209c
  8000e2:	e8 f2 03 00 00       	call   8004d9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage %d %d %d", freeFrames, sys_calculate_free_frames(), freeFrames - sys_calculate_free_frames());
  8000e7:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000ea:	e8 23 18 00 00       	call   801912 <sys_calculate_free_frames>
  8000ef:	29 c3                	sub    %eax,%ebx
  8000f1:	89 d8                	mov    %ebx,%eax
  8000f3:	83 f8 04             	cmp    $0x4,%eax
  8000f6:	74 28                	je     800120 <_main+0xe8>
  8000f8:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000fb:	e8 12 18 00 00       	call   801912 <sys_calculate_free_frames>
  800100:	29 c3                	sub    %eax,%ebx
  800102:	e8 0b 18 00 00       	call   801912 <sys_calculate_free_frames>
  800107:	83 ec 08             	sub    $0x8,%esp
  80010a:	53                   	push   %ebx
  80010b:	50                   	push   %eax
  80010c:	ff 75 e8             	pushl  -0x18(%ebp)
  80010f:	68 5c 21 80 00       	push   $0x80215c
  800114:	6a 1b                	push   $0x1b
  800116:	68 9c 20 80 00       	push   $0x80209c
  80011b:	e8 b9 03 00 00       	call   8004d9 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800120:	e8 ed 17 00 00       	call   801912 <sys_calculate_free_frames>
  800125:	89 45 e8             	mov    %eax,-0x18(%ebp)
		z = smalloc("y", PAGE_SIZE + 4, 1);
  800128:	83 ec 04             	sub    $0x4,%esp
  80012b:	6a 01                	push   $0x1
  80012d:	68 04 10 00 00       	push   $0x1004
  800132:	68 e3 21 80 00       	push   $0x8021e3
  800137:	e8 99 15 00 00       	call   8016d5 <smalloc>
  80013c:	83 c4 10             	add    $0x10,%esp
  80013f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		if (z != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800142:	81 7d e0 00 10 00 80 	cmpl   $0x80001000,-0x20(%ebp)
  800149:	74 14                	je     80015f <_main+0x127>
  80014b:	83 ec 04             	sub    $0x4,%esp
  80014e:	68 f0 20 80 00       	push   $0x8020f0
  800153:	6a 1f                	push   $0x1f
  800155:	68 9c 20 80 00       	push   $0x80209c
  80015a:	e8 7a 03 00 00       	call   8004d9 <_panic>

		if ((freeFrames - sys_calculate_free_frames()) !=  2+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage %d %d %d", freeFrames, sys_calculate_free_frames(), freeFrames - sys_calculate_free_frames());
  80015f:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800162:	e8 ab 17 00 00       	call   801912 <sys_calculate_free_frames>
  800167:	29 c3                	sub    %eax,%ebx
  800169:	89 d8                	mov    %ebx,%eax
  80016b:	83 f8 04             	cmp    $0x4,%eax
  80016e:	74 28                	je     800198 <_main+0x160>
  800170:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800173:	e8 9a 17 00 00       	call   801912 <sys_calculate_free_frames>
  800178:	29 c3                	sub    %eax,%ebx
  80017a:	e8 93 17 00 00       	call   801912 <sys_calculate_free_frames>
  80017f:	83 ec 08             	sub    $0x8,%esp
  800182:	53                   	push   %ebx
  800183:	50                   	push   %eax
  800184:	ff 75 e8             	pushl  -0x18(%ebp)
  800187:	68 5c 21 80 00       	push   $0x80215c
  80018c:	6a 21                	push   $0x21
  80018e:	68 9c 20 80 00       	push   $0x80209c
  800193:	e8 41 03 00 00       	call   8004d9 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800198:	e8 75 17 00 00       	call   801912 <sys_calculate_free_frames>
  80019d:	89 45 e8             	mov    %eax,-0x18(%ebp)
		y = smalloc("z", 4, 1);
  8001a0:	83 ec 04             	sub    $0x4,%esp
  8001a3:	6a 01                	push   $0x1
  8001a5:	6a 04                	push   $0x4
  8001a7:	68 e5 21 80 00       	push   $0x8021e5
  8001ac:	e8 24 15 00 00       	call   8016d5 <smalloc>
  8001b1:	83 c4 10             	add    $0x10,%esp
  8001b4:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (y != (uint32*)(USER_HEAP_START + 3 * PAGE_SIZE)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8001b7:	81 7d dc 00 30 00 80 	cmpl   $0x80003000,-0x24(%ebp)
  8001be:	74 14                	je     8001d4 <_main+0x19c>
  8001c0:	83 ec 04             	sub    $0x4,%esp
  8001c3:	68 f0 20 80 00       	push   $0x8020f0
  8001c8:	6a 25                	push   $0x25
  8001ca:	68 9c 20 80 00       	push   $0x80209c
  8001cf:	e8 05 03 00 00       	call   8004d9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8001d4:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8001d7:	e8 36 17 00 00       	call   801912 <sys_calculate_free_frames>
  8001dc:	29 c3                	sub    %eax,%ebx
  8001de:	89 d8                	mov    %ebx,%eax
  8001e0:	83 f8 03             	cmp    $0x3,%eax
  8001e3:	74 14                	je     8001f9 <_main+0x1c1>
  8001e5:	83 ec 04             	sub    $0x4,%esp
  8001e8:	68 e8 21 80 00       	push   $0x8021e8
  8001ed:	6a 26                	push   $0x26
  8001ef:	68 9c 20 80 00       	push   $0x80209c
  8001f4:	e8 e0 02 00 00       	call   8004d9 <_panic>
	}
	cprintf("Step A is completed successfully!!\n\n\n");
  8001f9:	83 ec 0c             	sub    $0xc,%esp
  8001fc:	68 68 22 80 00       	push   $0x802268
  800201:	e8 75 05 00 00       	call   80077b <cprintf>
  800206:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking reading & writing... \n");
  800209:	83 ec 0c             	sub    $0xc,%esp
  80020c:	68 90 22 80 00       	push   $0x802290
  800211:	e8 65 05 00 00       	call   80077b <cprintf>
  800216:	83 c4 10             	add    $0x10,%esp
	{
		int i=0;
  800219:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<PAGE_SIZE/4;i++)
  800220:	eb 2d                	jmp    80024f <_main+0x217>
		{
			x[i] = -1;
  800222:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800225:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80022c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80022f:	01 d0                	add    %edx,%eax
  800231:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			y[i] = -1;
  800237:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80023a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800241:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800244:	01 d0                	add    %edx,%eax
  800246:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)


	cprintf("STEP B: checking reading & writing... \n");
	{
		int i=0;
		for(;i<PAGE_SIZE/4;i++)
  80024c:	ff 45 ec             	incl   -0x14(%ebp)
  80024f:	81 7d ec ff 03 00 00 	cmpl   $0x3ff,-0x14(%ebp)
  800256:	7e ca                	jle    800222 <_main+0x1ea>
		{
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
  800258:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(;i<2*PAGE_SIZE/4;i++)
  80025f:	eb 18                	jmp    800279 <_main+0x241>
		{
			z[i] = -1;
  800261:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800264:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80026b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80026e:	01 d0                	add    %edx,%eax
  800270:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
			x[i] = -1;
			y[i] = -1;
		}

		i=0;
		for(;i<2*PAGE_SIZE/4;i++)
  800276:	ff 45 ec             	incl   -0x14(%ebp)
  800279:	81 7d ec ff 07 00 00 	cmpl   $0x7ff,-0x14(%ebp)
  800280:	7e df                	jle    800261 <_main+0x229>
		{
			z[i] = -1;
		}

		if( x[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  800282:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800285:	8b 00                	mov    (%eax),%eax
  800287:	83 f8 ff             	cmp    $0xffffffff,%eax
  80028a:	74 14                	je     8002a0 <_main+0x268>
  80028c:	83 ec 04             	sub    $0x4,%esp
  80028f:	68 b8 22 80 00       	push   $0x8022b8
  800294:	6a 3a                	push   $0x3a
  800296:	68 9c 20 80 00       	push   $0x80209c
  80029b:	e8 39 02 00 00       	call   8004d9 <_panic>
		if( x[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a3:	05 fc 0f 00 00       	add    $0xffc,%eax
  8002a8:	8b 00                	mov    (%eax),%eax
  8002aa:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002ad:	74 14                	je     8002c3 <_main+0x28b>
  8002af:	83 ec 04             	sub    $0x4,%esp
  8002b2:	68 b8 22 80 00       	push   $0x8022b8
  8002b7:	6a 3b                	push   $0x3b
  8002b9:	68 9c 20 80 00       	push   $0x80209c
  8002be:	e8 16 02 00 00       	call   8004d9 <_panic>

		if( y[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  8002c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002c6:	8b 00                	mov    (%eax),%eax
  8002c8:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002cb:	74 14                	je     8002e1 <_main+0x2a9>
  8002cd:	83 ec 04             	sub    $0x4,%esp
  8002d0:	68 b8 22 80 00       	push   $0x8022b8
  8002d5:	6a 3d                	push   $0x3d
  8002d7:	68 9c 20 80 00       	push   $0x80209c
  8002dc:	e8 f8 01 00 00       	call   8004d9 <_panic>
		if( y[PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  8002e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002e4:	05 fc 0f 00 00       	add    $0xffc,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
  8002eb:	83 f8 ff             	cmp    $0xffffffff,%eax
  8002ee:	74 14                	je     800304 <_main+0x2cc>
  8002f0:	83 ec 04             	sub    $0x4,%esp
  8002f3:	68 b8 22 80 00       	push   $0x8022b8
  8002f8:	6a 3e                	push   $0x3e
  8002fa:	68 9c 20 80 00       	push   $0x80209c
  8002ff:	e8 d5 01 00 00       	call   8004d9 <_panic>

		if( z[0] !=  -1)  					panic("Reading/Writing of shared object is failed");
  800304:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800307:	8b 00                	mov    (%eax),%eax
  800309:	83 f8 ff             	cmp    $0xffffffff,%eax
  80030c:	74 14                	je     800322 <_main+0x2ea>
  80030e:	83 ec 04             	sub    $0x4,%esp
  800311:	68 b8 22 80 00       	push   $0x8022b8
  800316:	6a 40                	push   $0x40
  800318:	68 9c 20 80 00       	push   $0x80209c
  80031d:	e8 b7 01 00 00       	call   8004d9 <_panic>
		if( z[2*PAGE_SIZE/4 - 1] !=  -1)  	panic("Reading/Writing of shared object is failed");
  800322:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800325:	05 fc 1f 00 00       	add    $0x1ffc,%eax
  80032a:	8b 00                	mov    (%eax),%eax
  80032c:	83 f8 ff             	cmp    $0xffffffff,%eax
  80032f:	74 14                	je     800345 <_main+0x30d>
  800331:	83 ec 04             	sub    $0x4,%esp
  800334:	68 b8 22 80 00       	push   $0x8022b8
  800339:	6a 41                	push   $0x41
  80033b:	68 9c 20 80 00       	push   $0x80209c
  800340:	e8 94 01 00 00       	call   8004d9 <_panic>
	}

	cprintf("Congratulations!! Test of Shared Variables [Create] [1] completed successfully!!\n\n\n");
  800345:	83 ec 0c             	sub    $0xc,%esp
  800348:	68 e4 22 80 00       	push   $0x8022e4
  80034d:	e8 29 04 00 00       	call   80077b <cprintf>
  800352:	83 c4 10             	add    $0x10,%esp

	int32 parentenvID = sys_getparentenvid();
  800355:	e8 06 15 00 00       	call   801860 <sys_getparentenvid>
  80035a:	89 45 d8             	mov    %eax,-0x28(%ebp)
	if(parentenvID > 0)
  80035d:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  800361:	7e 2b                	jle    80038e <_main+0x356>
	{
		//Get the check-finishing counter
		int *finishedCount = NULL;
  800363:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
		finishedCount = sget(parentenvID, "finishedCount") ;
  80036a:	83 ec 08             	sub    $0x8,%esp
  80036d:	68 38 23 80 00       	push   $0x802338
  800372:	ff 75 d8             	pushl  -0x28(%ebp)
  800375:	e8 7e 13 00 00       	call   8016f8 <sget>
  80037a:	83 c4 10             	add    $0x10,%esp
  80037d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		(*finishedCount)++ ;
  800380:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	8d 50 01             	lea    0x1(%eax),%edx
  800388:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80038b:	89 10                	mov    %edx,(%eax)
	}

	return;
  80038d:	90                   	nop
  80038e:	90                   	nop
}
  80038f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800392:	c9                   	leave  
  800393:	c3                   	ret    

00800394 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800394:	55                   	push   %ebp
  800395:	89 e5                	mov    %esp,%ebp
  800397:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80039a:	e8 a8 14 00 00       	call   801847 <sys_getenvindex>
  80039f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a5:	89 d0                	mov    %edx,%eax
  8003a7:	c1 e0 03             	shl    $0x3,%eax
  8003aa:	01 d0                	add    %edx,%eax
  8003ac:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8003b3:	01 c8                	add    %ecx,%eax
  8003b5:	01 c0                	add    %eax,%eax
  8003b7:	01 d0                	add    %edx,%eax
  8003b9:	01 c0                	add    %eax,%eax
  8003bb:	01 d0                	add    %edx,%eax
  8003bd:	89 c2                	mov    %eax,%edx
  8003bf:	c1 e2 05             	shl    $0x5,%edx
  8003c2:	29 c2                	sub    %eax,%edx
  8003c4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8003cb:	89 c2                	mov    %eax,%edx
  8003cd:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8003d3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003dd:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003e3:	84 c0                	test   %al,%al
  8003e5:	74 0f                	je     8003f6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ec:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003f1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003f6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003fa:	7e 0a                	jle    800406 <libmain+0x72>
		binaryname = argv[0];
  8003fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800406:	83 ec 08             	sub    $0x8,%esp
  800409:	ff 75 0c             	pushl  0xc(%ebp)
  80040c:	ff 75 08             	pushl  0x8(%ebp)
  80040f:	e8 24 fc ff ff       	call   800038 <_main>
  800414:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800417:	e8 c6 15 00 00       	call   8019e2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80041c:	83 ec 0c             	sub    $0xc,%esp
  80041f:	68 60 23 80 00       	push   $0x802360
  800424:	e8 52 03 00 00       	call   80077b <cprintf>
  800429:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80042c:	a1 20 30 80 00       	mov    0x803020,%eax
  800431:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800437:	a1 20 30 80 00       	mov    0x803020,%eax
  80043c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800442:	83 ec 04             	sub    $0x4,%esp
  800445:	52                   	push   %edx
  800446:	50                   	push   %eax
  800447:	68 88 23 80 00       	push   $0x802388
  80044c:	e8 2a 03 00 00       	call   80077b <cprintf>
  800451:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800454:	a1 20 30 80 00       	mov    0x803020,%eax
  800459:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80045f:	a1 20 30 80 00       	mov    0x803020,%eax
  800464:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80046a:	83 ec 04             	sub    $0x4,%esp
  80046d:	52                   	push   %edx
  80046e:	50                   	push   %eax
  80046f:	68 b0 23 80 00       	push   $0x8023b0
  800474:	e8 02 03 00 00       	call   80077b <cprintf>
  800479:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80047c:	a1 20 30 80 00       	mov    0x803020,%eax
  800481:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800487:	83 ec 08             	sub    $0x8,%esp
  80048a:	50                   	push   %eax
  80048b:	68 f1 23 80 00       	push   $0x8023f1
  800490:	e8 e6 02 00 00       	call   80077b <cprintf>
  800495:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800498:	83 ec 0c             	sub    $0xc,%esp
  80049b:	68 60 23 80 00       	push   $0x802360
  8004a0:	e8 d6 02 00 00       	call   80077b <cprintf>
  8004a5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004a8:	e8 4f 15 00 00       	call   8019fc <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004ad:	e8 19 00 00 00       	call   8004cb <exit>
}
  8004b2:	90                   	nop
  8004b3:	c9                   	leave  
  8004b4:	c3                   	ret    

008004b5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004b5:	55                   	push   %ebp
  8004b6:	89 e5                	mov    %esp,%ebp
  8004b8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004bb:	83 ec 0c             	sub    $0xc,%esp
  8004be:	6a 00                	push   $0x0
  8004c0:	e8 4e 13 00 00       	call   801813 <sys_env_destroy>
  8004c5:	83 c4 10             	add    $0x10,%esp
}
  8004c8:	90                   	nop
  8004c9:	c9                   	leave  
  8004ca:	c3                   	ret    

008004cb <exit>:

void
exit(void)
{
  8004cb:	55                   	push   %ebp
  8004cc:	89 e5                	mov    %esp,%ebp
  8004ce:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004d1:	e8 a3 13 00 00       	call   801879 <sys_env_exit>
}
  8004d6:	90                   	nop
  8004d7:	c9                   	leave  
  8004d8:	c3                   	ret    

008004d9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004d9:	55                   	push   %ebp
  8004da:	89 e5                	mov    %esp,%ebp
  8004dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004df:	8d 45 10             	lea    0x10(%ebp),%eax
  8004e2:	83 c0 04             	add    $0x4,%eax
  8004e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004e8:	a1 18 31 80 00       	mov    0x803118,%eax
  8004ed:	85 c0                	test   %eax,%eax
  8004ef:	74 16                	je     800507 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004f1:	a1 18 31 80 00       	mov    0x803118,%eax
  8004f6:	83 ec 08             	sub    $0x8,%esp
  8004f9:	50                   	push   %eax
  8004fa:	68 08 24 80 00       	push   $0x802408
  8004ff:	e8 77 02 00 00       	call   80077b <cprintf>
  800504:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800507:	a1 00 30 80 00       	mov    0x803000,%eax
  80050c:	ff 75 0c             	pushl  0xc(%ebp)
  80050f:	ff 75 08             	pushl  0x8(%ebp)
  800512:	50                   	push   %eax
  800513:	68 0d 24 80 00       	push   $0x80240d
  800518:	e8 5e 02 00 00       	call   80077b <cprintf>
  80051d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800520:	8b 45 10             	mov    0x10(%ebp),%eax
  800523:	83 ec 08             	sub    $0x8,%esp
  800526:	ff 75 f4             	pushl  -0xc(%ebp)
  800529:	50                   	push   %eax
  80052a:	e8 e1 01 00 00       	call   800710 <vcprintf>
  80052f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800532:	83 ec 08             	sub    $0x8,%esp
  800535:	6a 00                	push   $0x0
  800537:	68 29 24 80 00       	push   $0x802429
  80053c:	e8 cf 01 00 00       	call   800710 <vcprintf>
  800541:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800544:	e8 82 ff ff ff       	call   8004cb <exit>

	// should not return here
	while (1) ;
  800549:	eb fe                	jmp    800549 <_panic+0x70>

0080054b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80054b:	55                   	push   %ebp
  80054c:	89 e5                	mov    %esp,%ebp
  80054e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800551:	a1 20 30 80 00       	mov    0x803020,%eax
  800556:	8b 50 74             	mov    0x74(%eax),%edx
  800559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80055c:	39 c2                	cmp    %eax,%edx
  80055e:	74 14                	je     800574 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800560:	83 ec 04             	sub    $0x4,%esp
  800563:	68 2c 24 80 00       	push   $0x80242c
  800568:	6a 26                	push   $0x26
  80056a:	68 78 24 80 00       	push   $0x802478
  80056f:	e8 65 ff ff ff       	call   8004d9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800574:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80057b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800582:	e9 b6 00 00 00       	jmp    80063d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800587:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800591:	8b 45 08             	mov    0x8(%ebp),%eax
  800594:	01 d0                	add    %edx,%eax
  800596:	8b 00                	mov    (%eax),%eax
  800598:	85 c0                	test   %eax,%eax
  80059a:	75 08                	jne    8005a4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80059c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80059f:	e9 96 00 00 00       	jmp    80063a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8005a4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b2:	eb 5d                	jmp    800611 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005c2:	c1 e2 04             	shl    $0x4,%edx
  8005c5:	01 d0                	add    %edx,%eax
  8005c7:	8a 40 04             	mov    0x4(%eax),%al
  8005ca:	84 c0                	test   %al,%al
  8005cc:	75 40                	jne    80060e <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005d9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005dc:	c1 e2 04             	shl    $0x4,%edx
  8005df:	01 d0                	add    %edx,%eax
  8005e1:	8b 00                	mov    (%eax),%eax
  8005e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005ee:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fd:	01 c8                	add    %ecx,%eax
  8005ff:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800601:	39 c2                	cmp    %eax,%edx
  800603:	75 09                	jne    80060e <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800605:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80060c:	eb 12                	jmp    800620 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80060e:	ff 45 e8             	incl   -0x18(%ebp)
  800611:	a1 20 30 80 00       	mov    0x803020,%eax
  800616:	8b 50 74             	mov    0x74(%eax),%edx
  800619:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	77 94                	ja     8005b4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800620:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800624:	75 14                	jne    80063a <CheckWSWithoutLastIndex+0xef>
			panic(
  800626:	83 ec 04             	sub    $0x4,%esp
  800629:	68 84 24 80 00       	push   $0x802484
  80062e:	6a 3a                	push   $0x3a
  800630:	68 78 24 80 00       	push   $0x802478
  800635:	e8 9f fe ff ff       	call   8004d9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80063a:	ff 45 f0             	incl   -0x10(%ebp)
  80063d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800640:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800643:	0f 8c 3e ff ff ff    	jl     800587 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800649:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800650:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800657:	eb 20                	jmp    800679 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800659:	a1 20 30 80 00       	mov    0x803020,%eax
  80065e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800664:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800667:	c1 e2 04             	shl    $0x4,%edx
  80066a:	01 d0                	add    %edx,%eax
  80066c:	8a 40 04             	mov    0x4(%eax),%al
  80066f:	3c 01                	cmp    $0x1,%al
  800671:	75 03                	jne    800676 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800673:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800676:	ff 45 e0             	incl   -0x20(%ebp)
  800679:	a1 20 30 80 00       	mov    0x803020,%eax
  80067e:	8b 50 74             	mov    0x74(%eax),%edx
  800681:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800684:	39 c2                	cmp    %eax,%edx
  800686:	77 d1                	ja     800659 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800688:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80068b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80068e:	74 14                	je     8006a4 <CheckWSWithoutLastIndex+0x159>
		panic(
  800690:	83 ec 04             	sub    $0x4,%esp
  800693:	68 d8 24 80 00       	push   $0x8024d8
  800698:	6a 44                	push   $0x44
  80069a:	68 78 24 80 00       	push   $0x802478
  80069f:	e8 35 fe ff ff       	call   8004d9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006a4:	90                   	nop
  8006a5:	c9                   	leave  
  8006a6:	c3                   	ret    

008006a7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006a7:	55                   	push   %ebp
  8006a8:	89 e5                	mov    %esp,%ebp
  8006aa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b0:	8b 00                	mov    (%eax),%eax
  8006b2:	8d 48 01             	lea    0x1(%eax),%ecx
  8006b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006b8:	89 0a                	mov    %ecx,(%edx)
  8006ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8006bd:	88 d1                	mov    %dl,%cl
  8006bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006d0:	75 2c                	jne    8006fe <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006d2:	a0 24 30 80 00       	mov    0x803024,%al
  8006d7:	0f b6 c0             	movzbl %al,%eax
  8006da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006dd:	8b 12                	mov    (%edx),%edx
  8006df:	89 d1                	mov    %edx,%ecx
  8006e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e4:	83 c2 08             	add    $0x8,%edx
  8006e7:	83 ec 04             	sub    $0x4,%esp
  8006ea:	50                   	push   %eax
  8006eb:	51                   	push   %ecx
  8006ec:	52                   	push   %edx
  8006ed:	e8 df 10 00 00       	call   8017d1 <sys_cputs>
  8006f2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800701:	8b 40 04             	mov    0x4(%eax),%eax
  800704:	8d 50 01             	lea    0x1(%eax),%edx
  800707:	8b 45 0c             	mov    0xc(%ebp),%eax
  80070a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80070d:	90                   	nop
  80070e:	c9                   	leave  
  80070f:	c3                   	ret    

00800710 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800710:	55                   	push   %ebp
  800711:	89 e5                	mov    %esp,%ebp
  800713:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800719:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800720:	00 00 00 
	b.cnt = 0;
  800723:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80072a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80072d:	ff 75 0c             	pushl  0xc(%ebp)
  800730:	ff 75 08             	pushl  0x8(%ebp)
  800733:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800739:	50                   	push   %eax
  80073a:	68 a7 06 80 00       	push   $0x8006a7
  80073f:	e8 11 02 00 00       	call   800955 <vprintfmt>
  800744:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800747:	a0 24 30 80 00       	mov    0x803024,%al
  80074c:	0f b6 c0             	movzbl %al,%eax
  80074f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800755:	83 ec 04             	sub    $0x4,%esp
  800758:	50                   	push   %eax
  800759:	52                   	push   %edx
  80075a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800760:	83 c0 08             	add    $0x8,%eax
  800763:	50                   	push   %eax
  800764:	e8 68 10 00 00       	call   8017d1 <sys_cputs>
  800769:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80076c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800773:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800779:	c9                   	leave  
  80077a:	c3                   	ret    

0080077b <cprintf>:

int cprintf(const char *fmt, ...) {
  80077b:	55                   	push   %ebp
  80077c:	89 e5                	mov    %esp,%ebp
  80077e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800781:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800788:	8d 45 0c             	lea    0xc(%ebp),%eax
  80078b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	83 ec 08             	sub    $0x8,%esp
  800794:	ff 75 f4             	pushl  -0xc(%ebp)
  800797:	50                   	push   %eax
  800798:	e8 73 ff ff ff       	call   800710 <vcprintf>
  80079d:	83 c4 10             	add    $0x10,%esp
  8007a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007a6:	c9                   	leave  
  8007a7:	c3                   	ret    

008007a8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007a8:	55                   	push   %ebp
  8007a9:	89 e5                	mov    %esp,%ebp
  8007ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007ae:	e8 2f 12 00 00       	call   8019e2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007b3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	83 ec 08             	sub    $0x8,%esp
  8007bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c2:	50                   	push   %eax
  8007c3:	e8 48 ff ff ff       	call   800710 <vcprintf>
  8007c8:	83 c4 10             	add    $0x10,%esp
  8007cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007ce:	e8 29 12 00 00       	call   8019fc <sys_enable_interrupt>
	return cnt;
  8007d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007d6:	c9                   	leave  
  8007d7:	c3                   	ret    

008007d8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007d8:	55                   	push   %ebp
  8007d9:	89 e5                	mov    %esp,%ebp
  8007db:	53                   	push   %ebx
  8007dc:	83 ec 14             	sub    $0x14,%esp
  8007df:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8007ee:	ba 00 00 00 00       	mov    $0x0,%edx
  8007f3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007f6:	77 55                	ja     80084d <printnum+0x75>
  8007f8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007fb:	72 05                	jb     800802 <printnum+0x2a>
  8007fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800800:	77 4b                	ja     80084d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800802:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800805:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800808:	8b 45 18             	mov    0x18(%ebp),%eax
  80080b:	ba 00 00 00 00       	mov    $0x0,%edx
  800810:	52                   	push   %edx
  800811:	50                   	push   %eax
  800812:	ff 75 f4             	pushl  -0xc(%ebp)
  800815:	ff 75 f0             	pushl  -0x10(%ebp)
  800818:	e8 e7 15 00 00       	call   801e04 <__udivdi3>
  80081d:	83 c4 10             	add    $0x10,%esp
  800820:	83 ec 04             	sub    $0x4,%esp
  800823:	ff 75 20             	pushl  0x20(%ebp)
  800826:	53                   	push   %ebx
  800827:	ff 75 18             	pushl  0x18(%ebp)
  80082a:	52                   	push   %edx
  80082b:	50                   	push   %eax
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 08             	pushl  0x8(%ebp)
  800832:	e8 a1 ff ff ff       	call   8007d8 <printnum>
  800837:	83 c4 20             	add    $0x20,%esp
  80083a:	eb 1a                	jmp    800856 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80083c:	83 ec 08             	sub    $0x8,%esp
  80083f:	ff 75 0c             	pushl  0xc(%ebp)
  800842:	ff 75 20             	pushl  0x20(%ebp)
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	ff d0                	call   *%eax
  80084a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80084d:	ff 4d 1c             	decl   0x1c(%ebp)
  800850:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800854:	7f e6                	jg     80083c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800856:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800859:	bb 00 00 00 00       	mov    $0x0,%ebx
  80085e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800861:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800864:	53                   	push   %ebx
  800865:	51                   	push   %ecx
  800866:	52                   	push   %edx
  800867:	50                   	push   %eax
  800868:	e8 a7 16 00 00       	call   801f14 <__umoddi3>
  80086d:	83 c4 10             	add    $0x10,%esp
  800870:	05 54 27 80 00       	add    $0x802754,%eax
  800875:	8a 00                	mov    (%eax),%al
  800877:	0f be c0             	movsbl %al,%eax
  80087a:	83 ec 08             	sub    $0x8,%esp
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	50                   	push   %eax
  800881:	8b 45 08             	mov    0x8(%ebp),%eax
  800884:	ff d0                	call   *%eax
  800886:	83 c4 10             	add    $0x10,%esp
}
  800889:	90                   	nop
  80088a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80088d:	c9                   	leave  
  80088e:	c3                   	ret    

0080088f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80088f:	55                   	push   %ebp
  800890:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800892:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800896:	7e 1c                	jle    8008b4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800898:	8b 45 08             	mov    0x8(%ebp),%eax
  80089b:	8b 00                	mov    (%eax),%eax
  80089d:	8d 50 08             	lea    0x8(%eax),%edx
  8008a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a3:	89 10                	mov    %edx,(%eax)
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	8b 00                	mov    (%eax),%eax
  8008aa:	83 e8 08             	sub    $0x8,%eax
  8008ad:	8b 50 04             	mov    0x4(%eax),%edx
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	eb 40                	jmp    8008f4 <getuint+0x65>
	else if (lflag)
  8008b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b8:	74 1e                	je     8008d8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bd:	8b 00                	mov    (%eax),%eax
  8008bf:	8d 50 04             	lea    0x4(%eax),%edx
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	89 10                	mov    %edx,(%eax)
  8008c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ca:	8b 00                	mov    (%eax),%eax
  8008cc:	83 e8 04             	sub    $0x4,%eax
  8008cf:	8b 00                	mov    (%eax),%eax
  8008d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8008d6:	eb 1c                	jmp    8008f4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008db:	8b 00                	mov    (%eax),%eax
  8008dd:	8d 50 04             	lea    0x4(%eax),%edx
  8008e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e3:	89 10                	mov    %edx,(%eax)
  8008e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e8:	8b 00                	mov    (%eax),%eax
  8008ea:	83 e8 04             	sub    $0x4,%eax
  8008ed:	8b 00                	mov    (%eax),%eax
  8008ef:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008f4:	5d                   	pop    %ebp
  8008f5:	c3                   	ret    

008008f6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008f6:	55                   	push   %ebp
  8008f7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008f9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008fd:	7e 1c                	jle    80091b <getint+0x25>
		return va_arg(*ap, long long);
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	8b 00                	mov    (%eax),%eax
  800904:	8d 50 08             	lea    0x8(%eax),%edx
  800907:	8b 45 08             	mov    0x8(%ebp),%eax
  80090a:	89 10                	mov    %edx,(%eax)
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	83 e8 08             	sub    $0x8,%eax
  800914:	8b 50 04             	mov    0x4(%eax),%edx
  800917:	8b 00                	mov    (%eax),%eax
  800919:	eb 38                	jmp    800953 <getint+0x5d>
	else if (lflag)
  80091b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80091f:	74 1a                	je     80093b <getint+0x45>
		return va_arg(*ap, long);
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	8b 00                	mov    (%eax),%eax
  800926:	8d 50 04             	lea    0x4(%eax),%edx
  800929:	8b 45 08             	mov    0x8(%ebp),%eax
  80092c:	89 10                	mov    %edx,(%eax)
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	8b 00                	mov    (%eax),%eax
  800933:	83 e8 04             	sub    $0x4,%eax
  800936:	8b 00                	mov    (%eax),%eax
  800938:	99                   	cltd   
  800939:	eb 18                	jmp    800953 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80093b:	8b 45 08             	mov    0x8(%ebp),%eax
  80093e:	8b 00                	mov    (%eax),%eax
  800940:	8d 50 04             	lea    0x4(%eax),%edx
  800943:	8b 45 08             	mov    0x8(%ebp),%eax
  800946:	89 10                	mov    %edx,(%eax)
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	8b 00                	mov    (%eax),%eax
  80094d:	83 e8 04             	sub    $0x4,%eax
  800950:	8b 00                	mov    (%eax),%eax
  800952:	99                   	cltd   
}
  800953:	5d                   	pop    %ebp
  800954:	c3                   	ret    

00800955 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800955:	55                   	push   %ebp
  800956:	89 e5                	mov    %esp,%ebp
  800958:	56                   	push   %esi
  800959:	53                   	push   %ebx
  80095a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80095d:	eb 17                	jmp    800976 <vprintfmt+0x21>
			if (ch == '\0')
  80095f:	85 db                	test   %ebx,%ebx
  800961:	0f 84 af 03 00 00    	je     800d16 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800967:	83 ec 08             	sub    $0x8,%esp
  80096a:	ff 75 0c             	pushl  0xc(%ebp)
  80096d:	53                   	push   %ebx
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	ff d0                	call   *%eax
  800973:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800976:	8b 45 10             	mov    0x10(%ebp),%eax
  800979:	8d 50 01             	lea    0x1(%eax),%edx
  80097c:	89 55 10             	mov    %edx,0x10(%ebp)
  80097f:	8a 00                	mov    (%eax),%al
  800981:	0f b6 d8             	movzbl %al,%ebx
  800984:	83 fb 25             	cmp    $0x25,%ebx
  800987:	75 d6                	jne    80095f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800989:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80098d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800994:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80099b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009a2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ac:	8d 50 01             	lea    0x1(%eax),%edx
  8009af:	89 55 10             	mov    %edx,0x10(%ebp)
  8009b2:	8a 00                	mov    (%eax),%al
  8009b4:	0f b6 d8             	movzbl %al,%ebx
  8009b7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009ba:	83 f8 55             	cmp    $0x55,%eax
  8009bd:	0f 87 2b 03 00 00    	ja     800cee <vprintfmt+0x399>
  8009c3:	8b 04 85 78 27 80 00 	mov    0x802778(,%eax,4),%eax
  8009ca:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009cc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009d0:	eb d7                	jmp    8009a9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009d2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009d6:	eb d1                	jmp    8009a9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009d8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009df:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009e2:	89 d0                	mov    %edx,%eax
  8009e4:	c1 e0 02             	shl    $0x2,%eax
  8009e7:	01 d0                	add    %edx,%eax
  8009e9:	01 c0                	add    %eax,%eax
  8009eb:	01 d8                	add    %ebx,%eax
  8009ed:	83 e8 30             	sub    $0x30,%eax
  8009f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f6:	8a 00                	mov    (%eax),%al
  8009f8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009fb:	83 fb 2f             	cmp    $0x2f,%ebx
  8009fe:	7e 3e                	jle    800a3e <vprintfmt+0xe9>
  800a00:	83 fb 39             	cmp    $0x39,%ebx
  800a03:	7f 39                	jg     800a3e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a05:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a08:	eb d5                	jmp    8009df <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0d:	83 c0 04             	add    $0x4,%eax
  800a10:	89 45 14             	mov    %eax,0x14(%ebp)
  800a13:	8b 45 14             	mov    0x14(%ebp),%eax
  800a16:	83 e8 04             	sub    $0x4,%eax
  800a19:	8b 00                	mov    (%eax),%eax
  800a1b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a1e:	eb 1f                	jmp    800a3f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a24:	79 83                	jns    8009a9 <vprintfmt+0x54>
				width = 0;
  800a26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a2d:	e9 77 ff ff ff       	jmp    8009a9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a32:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a39:	e9 6b ff ff ff       	jmp    8009a9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a3e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a43:	0f 89 60 ff ff ff    	jns    8009a9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a4f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a56:	e9 4e ff ff ff       	jmp    8009a9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a5b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a5e:	e9 46 ff ff ff       	jmp    8009a9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a63:	8b 45 14             	mov    0x14(%ebp),%eax
  800a66:	83 c0 04             	add    $0x4,%eax
  800a69:	89 45 14             	mov    %eax,0x14(%ebp)
  800a6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6f:	83 e8 04             	sub    $0x4,%eax
  800a72:	8b 00                	mov    (%eax),%eax
  800a74:	83 ec 08             	sub    $0x8,%esp
  800a77:	ff 75 0c             	pushl  0xc(%ebp)
  800a7a:	50                   	push   %eax
  800a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7e:	ff d0                	call   *%eax
  800a80:	83 c4 10             	add    $0x10,%esp
			break;
  800a83:	e9 89 02 00 00       	jmp    800d11 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a88:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8b:	83 c0 04             	add    $0x4,%eax
  800a8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800a91:	8b 45 14             	mov    0x14(%ebp),%eax
  800a94:	83 e8 04             	sub    $0x4,%eax
  800a97:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a99:	85 db                	test   %ebx,%ebx
  800a9b:	79 02                	jns    800a9f <vprintfmt+0x14a>
				err = -err;
  800a9d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a9f:	83 fb 64             	cmp    $0x64,%ebx
  800aa2:	7f 0b                	jg     800aaf <vprintfmt+0x15a>
  800aa4:	8b 34 9d c0 25 80 00 	mov    0x8025c0(,%ebx,4),%esi
  800aab:	85 f6                	test   %esi,%esi
  800aad:	75 19                	jne    800ac8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800aaf:	53                   	push   %ebx
  800ab0:	68 65 27 80 00       	push   $0x802765
  800ab5:	ff 75 0c             	pushl  0xc(%ebp)
  800ab8:	ff 75 08             	pushl  0x8(%ebp)
  800abb:	e8 5e 02 00 00       	call   800d1e <printfmt>
  800ac0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ac3:	e9 49 02 00 00       	jmp    800d11 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ac8:	56                   	push   %esi
  800ac9:	68 6e 27 80 00       	push   $0x80276e
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	ff 75 08             	pushl  0x8(%ebp)
  800ad4:	e8 45 02 00 00       	call   800d1e <printfmt>
  800ad9:	83 c4 10             	add    $0x10,%esp
			break;
  800adc:	e9 30 02 00 00       	jmp    800d11 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ae1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae4:	83 c0 04             	add    $0x4,%eax
  800ae7:	89 45 14             	mov    %eax,0x14(%ebp)
  800aea:	8b 45 14             	mov    0x14(%ebp),%eax
  800aed:	83 e8 04             	sub    $0x4,%eax
  800af0:	8b 30                	mov    (%eax),%esi
  800af2:	85 f6                	test   %esi,%esi
  800af4:	75 05                	jne    800afb <vprintfmt+0x1a6>
				p = "(null)";
  800af6:	be 71 27 80 00       	mov    $0x802771,%esi
			if (width > 0 && padc != '-')
  800afb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aff:	7e 6d                	jle    800b6e <vprintfmt+0x219>
  800b01:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b05:	74 67                	je     800b6e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b0a:	83 ec 08             	sub    $0x8,%esp
  800b0d:	50                   	push   %eax
  800b0e:	56                   	push   %esi
  800b0f:	e8 0c 03 00 00       	call   800e20 <strnlen>
  800b14:	83 c4 10             	add    $0x10,%esp
  800b17:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b1a:	eb 16                	jmp    800b32 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b1c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b20:	83 ec 08             	sub    $0x8,%esp
  800b23:	ff 75 0c             	pushl  0xc(%ebp)
  800b26:	50                   	push   %eax
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	ff d0                	call   *%eax
  800b2c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b2f:	ff 4d e4             	decl   -0x1c(%ebp)
  800b32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b36:	7f e4                	jg     800b1c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b38:	eb 34                	jmp    800b6e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b3e:	74 1c                	je     800b5c <vprintfmt+0x207>
  800b40:	83 fb 1f             	cmp    $0x1f,%ebx
  800b43:	7e 05                	jle    800b4a <vprintfmt+0x1f5>
  800b45:	83 fb 7e             	cmp    $0x7e,%ebx
  800b48:	7e 12                	jle    800b5c <vprintfmt+0x207>
					putch('?', putdat);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	6a 3f                	push   $0x3f
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	ff d0                	call   *%eax
  800b57:	83 c4 10             	add    $0x10,%esp
  800b5a:	eb 0f                	jmp    800b6b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b5c:	83 ec 08             	sub    $0x8,%esp
  800b5f:	ff 75 0c             	pushl  0xc(%ebp)
  800b62:	53                   	push   %ebx
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	ff d0                	call   *%eax
  800b68:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800b6e:	89 f0                	mov    %esi,%eax
  800b70:	8d 70 01             	lea    0x1(%eax),%esi
  800b73:	8a 00                	mov    (%eax),%al
  800b75:	0f be d8             	movsbl %al,%ebx
  800b78:	85 db                	test   %ebx,%ebx
  800b7a:	74 24                	je     800ba0 <vprintfmt+0x24b>
  800b7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b80:	78 b8                	js     800b3a <vprintfmt+0x1e5>
  800b82:	ff 4d e0             	decl   -0x20(%ebp)
  800b85:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b89:	79 af                	jns    800b3a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b8b:	eb 13                	jmp    800ba0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b8d:	83 ec 08             	sub    $0x8,%esp
  800b90:	ff 75 0c             	pushl  0xc(%ebp)
  800b93:	6a 20                	push   $0x20
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	ff d0                	call   *%eax
  800b9a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800ba0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ba4:	7f e7                	jg     800b8d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ba6:	e9 66 01 00 00       	jmp    800d11 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bab:	83 ec 08             	sub    $0x8,%esp
  800bae:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb1:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb4:	50                   	push   %eax
  800bb5:	e8 3c fd ff ff       	call   8008f6 <getint>
  800bba:	83 c4 10             	add    $0x10,%esp
  800bbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bc9:	85 d2                	test   %edx,%edx
  800bcb:	79 23                	jns    800bf0 <vprintfmt+0x29b>
				putch('-', putdat);
  800bcd:	83 ec 08             	sub    $0x8,%esp
  800bd0:	ff 75 0c             	pushl  0xc(%ebp)
  800bd3:	6a 2d                	push   $0x2d
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	ff d0                	call   *%eax
  800bda:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800be0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800be3:	f7 d8                	neg    %eax
  800be5:	83 d2 00             	adc    $0x0,%edx
  800be8:	f7 da                	neg    %edx
  800bea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bf0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bf7:	e9 bc 00 00 00       	jmp    800cb8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bfc:	83 ec 08             	sub    $0x8,%esp
  800bff:	ff 75 e8             	pushl  -0x18(%ebp)
  800c02:	8d 45 14             	lea    0x14(%ebp),%eax
  800c05:	50                   	push   %eax
  800c06:	e8 84 fc ff ff       	call   80088f <getuint>
  800c0b:	83 c4 10             	add    $0x10,%esp
  800c0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c11:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c14:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c1b:	e9 98 00 00 00       	jmp    800cb8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c20:	83 ec 08             	sub    $0x8,%esp
  800c23:	ff 75 0c             	pushl  0xc(%ebp)
  800c26:	6a 58                	push   $0x58
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	ff d0                	call   *%eax
  800c2d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c30:	83 ec 08             	sub    $0x8,%esp
  800c33:	ff 75 0c             	pushl  0xc(%ebp)
  800c36:	6a 58                	push   $0x58
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	ff d0                	call   *%eax
  800c3d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c40:	83 ec 08             	sub    $0x8,%esp
  800c43:	ff 75 0c             	pushl  0xc(%ebp)
  800c46:	6a 58                	push   $0x58
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	ff d0                	call   *%eax
  800c4d:	83 c4 10             	add    $0x10,%esp
			break;
  800c50:	e9 bc 00 00 00       	jmp    800d11 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c55:	83 ec 08             	sub    $0x8,%esp
  800c58:	ff 75 0c             	pushl  0xc(%ebp)
  800c5b:	6a 30                	push   $0x30
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c60:	ff d0                	call   *%eax
  800c62:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	ff 75 0c             	pushl  0xc(%ebp)
  800c6b:	6a 78                	push   $0x78
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	ff d0                	call   *%eax
  800c72:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c75:	8b 45 14             	mov    0x14(%ebp),%eax
  800c78:	83 c0 04             	add    $0x4,%eax
  800c7b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c81:	83 e8 04             	sub    $0x4,%eax
  800c84:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c90:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c97:	eb 1f                	jmp    800cb8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c99:	83 ec 08             	sub    $0x8,%esp
  800c9c:	ff 75 e8             	pushl  -0x18(%ebp)
  800c9f:	8d 45 14             	lea    0x14(%ebp),%eax
  800ca2:	50                   	push   %eax
  800ca3:	e8 e7 fb ff ff       	call   80088f <getuint>
  800ca8:	83 c4 10             	add    $0x10,%esp
  800cab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cb1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cb8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cbf:	83 ec 04             	sub    $0x4,%esp
  800cc2:	52                   	push   %edx
  800cc3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cc6:	50                   	push   %eax
  800cc7:	ff 75 f4             	pushl  -0xc(%ebp)
  800cca:	ff 75 f0             	pushl  -0x10(%ebp)
  800ccd:	ff 75 0c             	pushl  0xc(%ebp)
  800cd0:	ff 75 08             	pushl  0x8(%ebp)
  800cd3:	e8 00 fb ff ff       	call   8007d8 <printnum>
  800cd8:	83 c4 20             	add    $0x20,%esp
			break;
  800cdb:	eb 34                	jmp    800d11 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cdd:	83 ec 08             	sub    $0x8,%esp
  800ce0:	ff 75 0c             	pushl  0xc(%ebp)
  800ce3:	53                   	push   %ebx
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	ff d0                	call   *%eax
  800ce9:	83 c4 10             	add    $0x10,%esp
			break;
  800cec:	eb 23                	jmp    800d11 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cee:	83 ec 08             	sub    $0x8,%esp
  800cf1:	ff 75 0c             	pushl  0xc(%ebp)
  800cf4:	6a 25                	push   $0x25
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	ff d0                	call   *%eax
  800cfb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cfe:	ff 4d 10             	decl   0x10(%ebp)
  800d01:	eb 03                	jmp    800d06 <vprintfmt+0x3b1>
  800d03:	ff 4d 10             	decl   0x10(%ebp)
  800d06:	8b 45 10             	mov    0x10(%ebp),%eax
  800d09:	48                   	dec    %eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3c 25                	cmp    $0x25,%al
  800d0e:	75 f3                	jne    800d03 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d10:	90                   	nop
		}
	}
  800d11:	e9 47 fc ff ff       	jmp    80095d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d16:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d17:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d1a:	5b                   	pop    %ebx
  800d1b:	5e                   	pop    %esi
  800d1c:	5d                   	pop    %ebp
  800d1d:	c3                   	ret    

00800d1e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d1e:	55                   	push   %ebp
  800d1f:	89 e5                	mov    %esp,%ebp
  800d21:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d24:	8d 45 10             	lea    0x10(%ebp),%eax
  800d27:	83 c0 04             	add    $0x4,%eax
  800d2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d30:	ff 75 f4             	pushl  -0xc(%ebp)
  800d33:	50                   	push   %eax
  800d34:	ff 75 0c             	pushl  0xc(%ebp)
  800d37:	ff 75 08             	pushl  0x8(%ebp)
  800d3a:	e8 16 fc ff ff       	call   800955 <vprintfmt>
  800d3f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d42:	90                   	nop
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4b:	8b 40 08             	mov    0x8(%eax),%eax
  800d4e:	8d 50 01             	lea    0x1(%eax),%edx
  800d51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d54:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5a:	8b 10                	mov    (%eax),%edx
  800d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5f:	8b 40 04             	mov    0x4(%eax),%eax
  800d62:	39 c2                	cmp    %eax,%edx
  800d64:	73 12                	jae    800d78 <sprintputch+0x33>
		*b->buf++ = ch;
  800d66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d69:	8b 00                	mov    (%eax),%eax
  800d6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800d6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d71:	89 0a                	mov    %ecx,(%edx)
  800d73:	8b 55 08             	mov    0x8(%ebp),%edx
  800d76:	88 10                	mov    %dl,(%eax)
}
  800d78:	90                   	nop
  800d79:	5d                   	pop    %ebp
  800d7a:	c3                   	ret    

00800d7b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d7b:	55                   	push   %ebp
  800d7c:	89 e5                	mov    %esp,%ebp
  800d7e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	01 d0                	add    %edx,%eax
  800d92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d9c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800da0:	74 06                	je     800da8 <vsnprintf+0x2d>
  800da2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da6:	7f 07                	jg     800daf <vsnprintf+0x34>
		return -E_INVAL;
  800da8:	b8 03 00 00 00       	mov    $0x3,%eax
  800dad:	eb 20                	jmp    800dcf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800daf:	ff 75 14             	pushl  0x14(%ebp)
  800db2:	ff 75 10             	pushl  0x10(%ebp)
  800db5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800db8:	50                   	push   %eax
  800db9:	68 45 0d 80 00       	push   $0x800d45
  800dbe:	e8 92 fb ff ff       	call   800955 <vprintfmt>
  800dc3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dc9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dcf:	c9                   	leave  
  800dd0:	c3                   	ret    

00800dd1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800dd1:	55                   	push   %ebp
  800dd2:	89 e5                	mov    %esp,%ebp
  800dd4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dd7:	8d 45 10             	lea    0x10(%ebp),%eax
  800dda:	83 c0 04             	add    $0x4,%eax
  800ddd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800de0:	8b 45 10             	mov    0x10(%ebp),%eax
  800de3:	ff 75 f4             	pushl  -0xc(%ebp)
  800de6:	50                   	push   %eax
  800de7:	ff 75 0c             	pushl  0xc(%ebp)
  800dea:	ff 75 08             	pushl  0x8(%ebp)
  800ded:	e8 89 ff ff ff       	call   800d7b <vsnprintf>
  800df2:	83 c4 10             	add    $0x10,%esp
  800df5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800df8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dfb:	c9                   	leave  
  800dfc:	c3                   	ret    

00800dfd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dfd:	55                   	push   %ebp
  800dfe:	89 e5                	mov    %esp,%ebp
  800e00:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e0a:	eb 06                	jmp    800e12 <strlen+0x15>
		n++;
  800e0c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e0f:	ff 45 08             	incl   0x8(%ebp)
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	8a 00                	mov    (%eax),%al
  800e17:	84 c0                	test   %al,%al
  800e19:	75 f1                	jne    800e0c <strlen+0xf>
		n++;
	return n;
  800e1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e1e:	c9                   	leave  
  800e1f:	c3                   	ret    

00800e20 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e20:	55                   	push   %ebp
  800e21:	89 e5                	mov    %esp,%ebp
  800e23:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e2d:	eb 09                	jmp    800e38 <strnlen+0x18>
		n++;
  800e2f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e32:	ff 45 08             	incl   0x8(%ebp)
  800e35:	ff 4d 0c             	decl   0xc(%ebp)
  800e38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e3c:	74 09                	je     800e47 <strnlen+0x27>
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	84 c0                	test   %al,%al
  800e45:	75 e8                	jne    800e2f <strnlen+0xf>
		n++;
	return n;
  800e47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e4a:	c9                   	leave  
  800e4b:	c3                   	ret    

00800e4c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e4c:	55                   	push   %ebp
  800e4d:	89 e5                	mov    %esp,%ebp
  800e4f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e58:	90                   	nop
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	8d 50 01             	lea    0x1(%eax),%edx
  800e5f:	89 55 08             	mov    %edx,0x8(%ebp)
  800e62:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e65:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e68:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e6b:	8a 12                	mov    (%edx),%dl
  800e6d:	88 10                	mov    %dl,(%eax)
  800e6f:	8a 00                	mov    (%eax),%al
  800e71:	84 c0                	test   %al,%al
  800e73:	75 e4                	jne    800e59 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e75:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e78:	c9                   	leave  
  800e79:	c3                   	ret    

00800e7a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e7a:	55                   	push   %ebp
  800e7b:	89 e5                	mov    %esp,%ebp
  800e7d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e8d:	eb 1f                	jmp    800eae <strncpy+0x34>
		*dst++ = *src;
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	8d 50 01             	lea    0x1(%eax),%edx
  800e95:	89 55 08             	mov    %edx,0x8(%ebp)
  800e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9b:	8a 12                	mov    (%edx),%dl
  800e9d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea2:	8a 00                	mov    (%eax),%al
  800ea4:	84 c0                	test   %al,%al
  800ea6:	74 03                	je     800eab <strncpy+0x31>
			src++;
  800ea8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800eab:	ff 45 fc             	incl   -0x4(%ebp)
  800eae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800eb4:	72 d9                	jb     800e8f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800eb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eb9:	c9                   	leave  
  800eba:	c3                   	ret    

00800ebb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ec7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ecb:	74 30                	je     800efd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ecd:	eb 16                	jmp    800ee5 <strlcpy+0x2a>
			*dst++ = *src++;
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	8d 50 01             	lea    0x1(%eax),%edx
  800ed5:	89 55 08             	mov    %edx,0x8(%ebp)
  800ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800edb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ede:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ee1:	8a 12                	mov    (%edx),%dl
  800ee3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ee5:	ff 4d 10             	decl   0x10(%ebp)
  800ee8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eec:	74 09                	je     800ef7 <strlcpy+0x3c>
  800eee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	84 c0                	test   %al,%al
  800ef5:	75 d8                	jne    800ecf <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800efd:	8b 55 08             	mov    0x8(%ebp),%edx
  800f00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f03:	29 c2                	sub    %eax,%edx
  800f05:	89 d0                	mov    %edx,%eax
}
  800f07:	c9                   	leave  
  800f08:	c3                   	ret    

00800f09 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f09:	55                   	push   %ebp
  800f0a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f0c:	eb 06                	jmp    800f14 <strcmp+0xb>
		p++, q++;
  800f0e:	ff 45 08             	incl   0x8(%ebp)
  800f11:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	84 c0                	test   %al,%al
  800f1b:	74 0e                	je     800f2b <strcmp+0x22>
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	8a 10                	mov    (%eax),%dl
  800f22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	38 c2                	cmp    %al,%dl
  800f29:	74 e3                	je     800f0e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	8a 00                	mov    (%eax),%al
  800f30:	0f b6 d0             	movzbl %al,%edx
  800f33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f b6 c0             	movzbl %al,%eax
  800f3b:	29 c2                	sub    %eax,%edx
  800f3d:	89 d0                	mov    %edx,%eax
}
  800f3f:	5d                   	pop    %ebp
  800f40:	c3                   	ret    

00800f41 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f41:	55                   	push   %ebp
  800f42:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f44:	eb 09                	jmp    800f4f <strncmp+0xe>
		n--, p++, q++;
  800f46:	ff 4d 10             	decl   0x10(%ebp)
  800f49:	ff 45 08             	incl   0x8(%ebp)
  800f4c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f53:	74 17                	je     800f6c <strncmp+0x2b>
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	84 c0                	test   %al,%al
  800f5c:	74 0e                	je     800f6c <strncmp+0x2b>
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	8a 10                	mov    (%eax),%dl
  800f63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	38 c2                	cmp    %al,%dl
  800f6a:	74 da                	je     800f46 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f70:	75 07                	jne    800f79 <strncmp+0x38>
		return 0;
  800f72:	b8 00 00 00 00       	mov    $0x0,%eax
  800f77:	eb 14                	jmp    800f8d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	0f b6 d0             	movzbl %al,%edx
  800f81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	0f b6 c0             	movzbl %al,%eax
  800f89:	29 c2                	sub    %eax,%edx
  800f8b:	89 d0                	mov    %edx,%eax
}
  800f8d:	5d                   	pop    %ebp
  800f8e:	c3                   	ret    

00800f8f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f8f:	55                   	push   %ebp
  800f90:	89 e5                	mov    %esp,%ebp
  800f92:	83 ec 04             	sub    $0x4,%esp
  800f95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f98:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f9b:	eb 12                	jmp    800faf <strchr+0x20>
		if (*s == c)
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	8a 00                	mov    (%eax),%al
  800fa2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fa5:	75 05                	jne    800fac <strchr+0x1d>
			return (char *) s;
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	eb 11                	jmp    800fbd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fac:	ff 45 08             	incl   0x8(%ebp)
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	84 c0                	test   %al,%al
  800fb6:	75 e5                	jne    800f9d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fbd:	c9                   	leave  
  800fbe:	c3                   	ret    

00800fbf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fbf:	55                   	push   %ebp
  800fc0:	89 e5                	mov    %esp,%ebp
  800fc2:	83 ec 04             	sub    $0x4,%esp
  800fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fcb:	eb 0d                	jmp    800fda <strfind+0x1b>
		if (*s == c)
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fd5:	74 0e                	je     800fe5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fd7:	ff 45 08             	incl   0x8(%ebp)
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	84 c0                	test   %al,%al
  800fe1:	75 ea                	jne    800fcd <strfind+0xe>
  800fe3:	eb 01                	jmp    800fe6 <strfind+0x27>
		if (*s == c)
			break;
  800fe5:	90                   	nop
	return (char *) s;
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe9:	c9                   	leave  
  800fea:	c3                   	ret    

00800feb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800feb:	55                   	push   %ebp
  800fec:	89 e5                	mov    %esp,%ebp
  800fee:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ff7:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ffd:	eb 0e                	jmp    80100d <memset+0x22>
		*p++ = c;
  800fff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801002:	8d 50 01             	lea    0x1(%eax),%edx
  801005:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801008:	8b 55 0c             	mov    0xc(%ebp),%edx
  80100b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80100d:	ff 4d f8             	decl   -0x8(%ebp)
  801010:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801014:	79 e9                	jns    800fff <memset+0x14>
		*p++ = c;

	return v;
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801019:	c9                   	leave  
  80101a:	c3                   	ret    

0080101b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80101b:	55                   	push   %ebp
  80101c:	89 e5                	mov    %esp,%ebp
  80101e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801021:	8b 45 0c             	mov    0xc(%ebp),%eax
  801024:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80102d:	eb 16                	jmp    801045 <memcpy+0x2a>
		*d++ = *s++;
  80102f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801032:	8d 50 01             	lea    0x1(%eax),%edx
  801035:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801038:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80103b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80103e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801041:	8a 12                	mov    (%edx),%dl
  801043:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801045:	8b 45 10             	mov    0x10(%ebp),%eax
  801048:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104b:	89 55 10             	mov    %edx,0x10(%ebp)
  80104e:	85 c0                	test   %eax,%eax
  801050:	75 dd                	jne    80102f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801055:	c9                   	leave  
  801056:	c3                   	ret    

00801057 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
  80105a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80105d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801060:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801069:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80106f:	73 50                	jae    8010c1 <memmove+0x6a>
  801071:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801074:	8b 45 10             	mov    0x10(%ebp),%eax
  801077:	01 d0                	add    %edx,%eax
  801079:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80107c:	76 43                	jbe    8010c1 <memmove+0x6a>
		s += n;
  80107e:	8b 45 10             	mov    0x10(%ebp),%eax
  801081:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801084:	8b 45 10             	mov    0x10(%ebp),%eax
  801087:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80108a:	eb 10                	jmp    80109c <memmove+0x45>
			*--d = *--s;
  80108c:	ff 4d f8             	decl   -0x8(%ebp)
  80108f:	ff 4d fc             	decl   -0x4(%ebp)
  801092:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801095:	8a 10                	mov    (%eax),%dl
  801097:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80109c:	8b 45 10             	mov    0x10(%ebp),%eax
  80109f:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010a2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a5:	85 c0                	test   %eax,%eax
  8010a7:	75 e3                	jne    80108c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010a9:	eb 23                	jmp    8010ce <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ae:	8d 50 01             	lea    0x1(%eax),%edx
  8010b1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010b7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ba:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010bd:	8a 12                	mov    (%edx),%dl
  8010bf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ca:	85 c0                	test   %eax,%eax
  8010cc:	75 dd                	jne    8010ab <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
  8010d6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010e5:	eb 2a                	jmp    801111 <memcmp+0x3e>
		if (*s1 != *s2)
  8010e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ea:	8a 10                	mov    (%eax),%dl
  8010ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	38 c2                	cmp    %al,%dl
  8010f3:	74 16                	je     80110b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	0f b6 d0             	movzbl %al,%edx
  8010fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	0f b6 c0             	movzbl %al,%eax
  801105:	29 c2                	sub    %eax,%edx
  801107:	89 d0                	mov    %edx,%eax
  801109:	eb 18                	jmp    801123 <memcmp+0x50>
		s1++, s2++;
  80110b:	ff 45 fc             	incl   -0x4(%ebp)
  80110e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801111:	8b 45 10             	mov    0x10(%ebp),%eax
  801114:	8d 50 ff             	lea    -0x1(%eax),%edx
  801117:	89 55 10             	mov    %edx,0x10(%ebp)
  80111a:	85 c0                	test   %eax,%eax
  80111c:	75 c9                	jne    8010e7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80111e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801123:	c9                   	leave  
  801124:	c3                   	ret    

00801125 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80112b:	8b 55 08             	mov    0x8(%ebp),%edx
  80112e:	8b 45 10             	mov    0x10(%ebp),%eax
  801131:	01 d0                	add    %edx,%eax
  801133:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801136:	eb 15                	jmp    80114d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	8a 00                	mov    (%eax),%al
  80113d:	0f b6 d0             	movzbl %al,%edx
  801140:	8b 45 0c             	mov    0xc(%ebp),%eax
  801143:	0f b6 c0             	movzbl %al,%eax
  801146:	39 c2                	cmp    %eax,%edx
  801148:	74 0d                	je     801157 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80114a:	ff 45 08             	incl   0x8(%ebp)
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801153:	72 e3                	jb     801138 <memfind+0x13>
  801155:	eb 01                	jmp    801158 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801157:	90                   	nop
	return (void *) s;
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80115b:	c9                   	leave  
  80115c:	c3                   	ret    

0080115d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80115d:	55                   	push   %ebp
  80115e:	89 e5                	mov    %esp,%ebp
  801160:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801163:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80116a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801171:	eb 03                	jmp    801176 <strtol+0x19>
		s++;
  801173:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	8a 00                	mov    (%eax),%al
  80117b:	3c 20                	cmp    $0x20,%al
  80117d:	74 f4                	je     801173 <strtol+0x16>
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	8a 00                	mov    (%eax),%al
  801184:	3c 09                	cmp    $0x9,%al
  801186:	74 eb                	je     801173 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	3c 2b                	cmp    $0x2b,%al
  80118f:	75 05                	jne    801196 <strtol+0x39>
		s++;
  801191:	ff 45 08             	incl   0x8(%ebp)
  801194:	eb 13                	jmp    8011a9 <strtol+0x4c>
	else if (*s == '-')
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	3c 2d                	cmp    $0x2d,%al
  80119d:	75 0a                	jne    8011a9 <strtol+0x4c>
		s++, neg = 1;
  80119f:	ff 45 08             	incl   0x8(%ebp)
  8011a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ad:	74 06                	je     8011b5 <strtol+0x58>
  8011af:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011b3:	75 20                	jne    8011d5 <strtol+0x78>
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	3c 30                	cmp    $0x30,%al
  8011bc:	75 17                	jne    8011d5 <strtol+0x78>
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	40                   	inc    %eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	3c 78                	cmp    $0x78,%al
  8011c6:	75 0d                	jne    8011d5 <strtol+0x78>
		s += 2, base = 16;
  8011c8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011cc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011d3:	eb 28                	jmp    8011fd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d9:	75 15                	jne    8011f0 <strtol+0x93>
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	3c 30                	cmp    $0x30,%al
  8011e2:	75 0c                	jne    8011f0 <strtol+0x93>
		s++, base = 8;
  8011e4:	ff 45 08             	incl   0x8(%ebp)
  8011e7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011ee:	eb 0d                	jmp    8011fd <strtol+0xa0>
	else if (base == 0)
  8011f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011f4:	75 07                	jne    8011fd <strtol+0xa0>
		base = 10;
  8011f6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801200:	8a 00                	mov    (%eax),%al
  801202:	3c 2f                	cmp    $0x2f,%al
  801204:	7e 19                	jle    80121f <strtol+0xc2>
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	3c 39                	cmp    $0x39,%al
  80120d:	7f 10                	jg     80121f <strtol+0xc2>
			dig = *s - '0';
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	0f be c0             	movsbl %al,%eax
  801217:	83 e8 30             	sub    $0x30,%eax
  80121a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80121d:	eb 42                	jmp    801261 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	8a 00                	mov    (%eax),%al
  801224:	3c 60                	cmp    $0x60,%al
  801226:	7e 19                	jle    801241 <strtol+0xe4>
  801228:	8b 45 08             	mov    0x8(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	3c 7a                	cmp    $0x7a,%al
  80122f:	7f 10                	jg     801241 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
  801234:	8a 00                	mov    (%eax),%al
  801236:	0f be c0             	movsbl %al,%eax
  801239:	83 e8 57             	sub    $0x57,%eax
  80123c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80123f:	eb 20                	jmp    801261 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801241:	8b 45 08             	mov    0x8(%ebp),%eax
  801244:	8a 00                	mov    (%eax),%al
  801246:	3c 40                	cmp    $0x40,%al
  801248:	7e 39                	jle    801283 <strtol+0x126>
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	8a 00                	mov    (%eax),%al
  80124f:	3c 5a                	cmp    $0x5a,%al
  801251:	7f 30                	jg     801283 <strtol+0x126>
			dig = *s - 'A' + 10;
  801253:	8b 45 08             	mov    0x8(%ebp),%eax
  801256:	8a 00                	mov    (%eax),%al
  801258:	0f be c0             	movsbl %al,%eax
  80125b:	83 e8 37             	sub    $0x37,%eax
  80125e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801261:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801264:	3b 45 10             	cmp    0x10(%ebp),%eax
  801267:	7d 19                	jge    801282 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801269:	ff 45 08             	incl   0x8(%ebp)
  80126c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801273:	89 c2                	mov    %eax,%edx
  801275:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801278:	01 d0                	add    %edx,%eax
  80127a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80127d:	e9 7b ff ff ff       	jmp    8011fd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801282:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801283:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801287:	74 08                	je     801291 <strtol+0x134>
		*endptr = (char *) s;
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	8b 55 08             	mov    0x8(%ebp),%edx
  80128f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801291:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801295:	74 07                	je     80129e <strtol+0x141>
  801297:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129a:	f7 d8                	neg    %eax
  80129c:	eb 03                	jmp    8012a1 <strtol+0x144>
  80129e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012a1:	c9                   	leave  
  8012a2:	c3                   	ret    

008012a3 <ltostr>:

void
ltostr(long value, char *str)
{
  8012a3:	55                   	push   %ebp
  8012a4:	89 e5                	mov    %esp,%ebp
  8012a6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012bb:	79 13                	jns    8012d0 <ltostr+0x2d>
	{
		neg = 1;
  8012bd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012ca:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012cd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012d8:	99                   	cltd   
  8012d9:	f7 f9                	idiv   %ecx
  8012db:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e1:	8d 50 01             	lea    0x1(%eax),%edx
  8012e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012e7:	89 c2                	mov    %eax,%edx
  8012e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ec:	01 d0                	add    %edx,%eax
  8012ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012f1:	83 c2 30             	add    $0x30,%edx
  8012f4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012f9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012fe:	f7 e9                	imul   %ecx
  801300:	c1 fa 02             	sar    $0x2,%edx
  801303:	89 c8                	mov    %ecx,%eax
  801305:	c1 f8 1f             	sar    $0x1f,%eax
  801308:	29 c2                	sub    %eax,%edx
  80130a:	89 d0                	mov    %edx,%eax
  80130c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80130f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801312:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801317:	f7 e9                	imul   %ecx
  801319:	c1 fa 02             	sar    $0x2,%edx
  80131c:	89 c8                	mov    %ecx,%eax
  80131e:	c1 f8 1f             	sar    $0x1f,%eax
  801321:	29 c2                	sub    %eax,%edx
  801323:	89 d0                	mov    %edx,%eax
  801325:	c1 e0 02             	shl    $0x2,%eax
  801328:	01 d0                	add    %edx,%eax
  80132a:	01 c0                	add    %eax,%eax
  80132c:	29 c1                	sub    %eax,%ecx
  80132e:	89 ca                	mov    %ecx,%edx
  801330:	85 d2                	test   %edx,%edx
  801332:	75 9c                	jne    8012d0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801334:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80133b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80133e:	48                   	dec    %eax
  80133f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801342:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801346:	74 3d                	je     801385 <ltostr+0xe2>
		start = 1 ;
  801348:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80134f:	eb 34                	jmp    801385 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801351:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801354:	8b 45 0c             	mov    0xc(%ebp),%eax
  801357:	01 d0                	add    %edx,%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80135e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801361:	8b 45 0c             	mov    0xc(%ebp),%eax
  801364:	01 c2                	add    %eax,%edx
  801366:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801369:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136c:	01 c8                	add    %ecx,%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801372:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801375:	8b 45 0c             	mov    0xc(%ebp),%eax
  801378:	01 c2                	add    %eax,%edx
  80137a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80137d:	88 02                	mov    %al,(%edx)
		start++ ;
  80137f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801382:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801385:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801388:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80138b:	7c c4                	jl     801351 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80138d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801390:	8b 45 0c             	mov    0xc(%ebp),%eax
  801393:	01 d0                	add    %edx,%eax
  801395:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801398:	90                   	nop
  801399:	c9                   	leave  
  80139a:	c3                   	ret    

0080139b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
  80139e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013a1:	ff 75 08             	pushl  0x8(%ebp)
  8013a4:	e8 54 fa ff ff       	call   800dfd <strlen>
  8013a9:	83 c4 04             	add    $0x4,%esp
  8013ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013af:	ff 75 0c             	pushl  0xc(%ebp)
  8013b2:	e8 46 fa ff ff       	call   800dfd <strlen>
  8013b7:	83 c4 04             	add    $0x4,%esp
  8013ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cb:	eb 17                	jmp    8013e4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d3:	01 c2                	add    %eax,%edx
  8013d5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	01 c8                	add    %ecx,%eax
  8013dd:	8a 00                	mov    (%eax),%al
  8013df:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013e1:	ff 45 fc             	incl   -0x4(%ebp)
  8013e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013ea:	7c e1                	jl     8013cd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013fa:	eb 1f                	jmp    80141b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ff:	8d 50 01             	lea    0x1(%eax),%edx
  801402:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801405:	89 c2                	mov    %eax,%edx
  801407:	8b 45 10             	mov    0x10(%ebp),%eax
  80140a:	01 c2                	add    %eax,%edx
  80140c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80140f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801412:	01 c8                	add    %ecx,%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801418:	ff 45 f8             	incl   -0x8(%ebp)
  80141b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801421:	7c d9                	jl     8013fc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801423:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801426:	8b 45 10             	mov    0x10(%ebp),%eax
  801429:	01 d0                	add    %edx,%eax
  80142b:	c6 00 00             	movb   $0x0,(%eax)
}
  80142e:	90                   	nop
  80142f:	c9                   	leave  
  801430:	c3                   	ret    

00801431 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801431:	55                   	push   %ebp
  801432:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801434:	8b 45 14             	mov    0x14(%ebp),%eax
  801437:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80143d:	8b 45 14             	mov    0x14(%ebp),%eax
  801440:	8b 00                	mov    (%eax),%eax
  801442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801449:	8b 45 10             	mov    0x10(%ebp),%eax
  80144c:	01 d0                	add    %edx,%eax
  80144e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801454:	eb 0c                	jmp    801462 <strsplit+0x31>
			*string++ = 0;
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8d 50 01             	lea    0x1(%eax),%edx
  80145c:	89 55 08             	mov    %edx,0x8(%ebp)
  80145f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	8a 00                	mov    (%eax),%al
  801467:	84 c0                	test   %al,%al
  801469:	74 18                	je     801483 <strsplit+0x52>
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	0f be c0             	movsbl %al,%eax
  801473:	50                   	push   %eax
  801474:	ff 75 0c             	pushl  0xc(%ebp)
  801477:	e8 13 fb ff ff       	call   800f8f <strchr>
  80147c:	83 c4 08             	add    $0x8,%esp
  80147f:	85 c0                	test   %eax,%eax
  801481:	75 d3                	jne    801456 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	8a 00                	mov    (%eax),%al
  801488:	84 c0                	test   %al,%al
  80148a:	74 5a                	je     8014e6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80148c:	8b 45 14             	mov    0x14(%ebp),%eax
  80148f:	8b 00                	mov    (%eax),%eax
  801491:	83 f8 0f             	cmp    $0xf,%eax
  801494:	75 07                	jne    80149d <strsplit+0x6c>
		{
			return 0;
  801496:	b8 00 00 00 00       	mov    $0x0,%eax
  80149b:	eb 66                	jmp    801503 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80149d:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a0:	8b 00                	mov    (%eax),%eax
  8014a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8014a5:	8b 55 14             	mov    0x14(%ebp),%edx
  8014a8:	89 0a                	mov    %ecx,(%edx)
  8014aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b4:	01 c2                	add    %eax,%edx
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014bb:	eb 03                	jmp    8014c0 <strsplit+0x8f>
			string++;
  8014bd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	8a 00                	mov    (%eax),%al
  8014c5:	84 c0                	test   %al,%al
  8014c7:	74 8b                	je     801454 <strsplit+0x23>
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cc:	8a 00                	mov    (%eax),%al
  8014ce:	0f be c0             	movsbl %al,%eax
  8014d1:	50                   	push   %eax
  8014d2:	ff 75 0c             	pushl  0xc(%ebp)
  8014d5:	e8 b5 fa ff ff       	call   800f8f <strchr>
  8014da:	83 c4 08             	add    $0x8,%esp
  8014dd:	85 c0                	test   %eax,%eax
  8014df:	74 dc                	je     8014bd <strsplit+0x8c>
			string++;
	}
  8014e1:	e9 6e ff ff ff       	jmp    801454 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014e6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ea:	8b 00                	mov    (%eax),%eax
  8014ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f6:	01 d0                	add    %edx,%eax
  8014f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
  801508:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	c1 e8 0c             	shr    $0xc,%eax
  801511:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	25 ff 0f 00 00       	and    $0xfff,%eax
  80151c:	85 c0                	test   %eax,%eax
  80151e:	74 03                	je     801523 <malloc+0x1e>
			num++;
  801520:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801523:	a1 04 30 80 00       	mov    0x803004,%eax
  801528:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80152d:	75 64                	jne    801593 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80152f:	83 ec 08             	sub    $0x8,%esp
  801532:	ff 75 08             	pushl  0x8(%ebp)
  801535:	68 00 00 00 80       	push   $0x80000000
  80153a:	e8 3a 04 00 00       	call   801979 <sys_allocateMem>
  80153f:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801542:	a1 04 30 80 00       	mov    0x803004,%eax
  801547:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80154a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80154d:	c1 e0 0c             	shl    $0xc,%eax
  801550:	89 c2                	mov    %eax,%edx
  801552:	a1 04 30 80 00       	mov    0x803004,%eax
  801557:	01 d0                	add    %edx,%eax
  801559:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  80155e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801563:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801569:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801570:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801575:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  80157c:	01 00 00 00 
			sizeofarray++;
  801580:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801585:	40                   	inc    %eax
  801586:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80158b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80158e:	e9 26 01 00 00       	jmp    8016b9 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  801593:	a1 28 30 80 00       	mov    0x803028,%eax
  801598:	85 c0                	test   %eax,%eax
  80159a:	75 62                	jne    8015fe <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  80159c:	a1 04 30 80 00       	mov    0x803004,%eax
  8015a1:	83 ec 08             	sub    $0x8,%esp
  8015a4:	ff 75 08             	pushl  0x8(%ebp)
  8015a7:	50                   	push   %eax
  8015a8:	e8 cc 03 00 00       	call   801979 <sys_allocateMem>
  8015ad:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8015b0:	a1 04 30 80 00       	mov    0x803004,%eax
  8015b5:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8015b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015bb:	c1 e0 0c             	shl    $0xc,%eax
  8015be:	89 c2                	mov    %eax,%edx
  8015c0:	a1 04 30 80 00       	mov    0x803004,%eax
  8015c5:	01 d0                	add    %edx,%eax
  8015c7:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  8015cc:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015d1:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8015d4:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8015db:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015e0:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8015e7:	01 00 00 00 
				sizeofarray++;
  8015eb:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015f0:	40                   	inc    %eax
  8015f1:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8015f6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015f9:	e9 bb 00 00 00       	jmp    8016b9 <malloc+0x1b4>
			}
			else{
				int count=0;
  8015fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801605:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80160c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801613:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80161a:	eb 7c                	jmp    801698 <malloc+0x193>
				{
					uint32 *pg=NULL;
  80161c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801623:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80162a:	eb 1a                	jmp    801646 <malloc+0x141>
					{
						if(addresses[j]==i)
  80162c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80162f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801636:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801639:	75 08                	jne    801643 <malloc+0x13e>
						{
							index=j;
  80163b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80163e:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801641:	eb 0d                	jmp    801650 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801643:	ff 45 dc             	incl   -0x24(%ebp)
  801646:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80164b:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80164e:	7c dc                	jl     80162c <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  801650:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801654:	75 05                	jne    80165b <malloc+0x156>
					{
						count++;
  801656:	ff 45 f0             	incl   -0x10(%ebp)
  801659:	eb 36                	jmp    801691 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  80165b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80165e:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801665:	85 c0                	test   %eax,%eax
  801667:	75 05                	jne    80166e <malloc+0x169>
						{
							count++;
  801669:	ff 45 f0             	incl   -0x10(%ebp)
  80166c:	eb 23                	jmp    801691 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  80166e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801671:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801674:	7d 14                	jge    80168a <malloc+0x185>
  801676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801679:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80167c:	7c 0c                	jl     80168a <malloc+0x185>
							{
								min=count;
  80167e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801681:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801684:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801687:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80168a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801691:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801698:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80169f:	0f 86 77 ff ff ff    	jbe    80161c <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  8016a5:	83 ec 08             	sub    $0x8,%esp
  8016a8:	ff 75 08             	pushl  0x8(%ebp)
  8016ab:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016ae:	e8 c6 02 00 00       	call   801979 <sys_allocateMem>
  8016b3:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  8016b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8016b9:	c9                   	leave  
  8016ba:	c3                   	ret    

008016bb <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
  8016be:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8016c1:	83 ec 04             	sub    $0x4,%esp
  8016c4:	68 d0 28 80 00       	push   $0x8028d0
  8016c9:	6a 7b                	push   $0x7b
  8016cb:	68 f3 28 80 00       	push   $0x8028f3
  8016d0:	e8 04 ee ff ff       	call   8004d9 <_panic>

008016d5 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
  8016d8:	83 ec 18             	sub    $0x18,%esp
  8016db:	8b 45 10             	mov    0x10(%ebp),%eax
  8016de:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8016e1:	83 ec 04             	sub    $0x4,%esp
  8016e4:	68 00 29 80 00       	push   $0x802900
  8016e9:	68 88 00 00 00       	push   $0x88
  8016ee:	68 f3 28 80 00       	push   $0x8028f3
  8016f3:	e8 e1 ed ff ff       	call   8004d9 <_panic>

008016f8 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016f8:	55                   	push   %ebp
  8016f9:	89 e5                	mov    %esp,%ebp
  8016fb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016fe:	83 ec 04             	sub    $0x4,%esp
  801701:	68 00 29 80 00       	push   $0x802900
  801706:	68 8e 00 00 00       	push   $0x8e
  80170b:	68 f3 28 80 00       	push   $0x8028f3
  801710:	e8 c4 ed ff ff       	call   8004d9 <_panic>

00801715 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
  801718:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80171b:	83 ec 04             	sub    $0x4,%esp
  80171e:	68 00 29 80 00       	push   $0x802900
  801723:	68 94 00 00 00       	push   $0x94
  801728:	68 f3 28 80 00       	push   $0x8028f3
  80172d:	e8 a7 ed ff ff       	call   8004d9 <_panic>

00801732 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
  801735:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801738:	83 ec 04             	sub    $0x4,%esp
  80173b:	68 00 29 80 00       	push   $0x802900
  801740:	68 99 00 00 00       	push   $0x99
  801745:	68 f3 28 80 00       	push   $0x8028f3
  80174a:	e8 8a ed ff ff       	call   8004d9 <_panic>

0080174f <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
  801752:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801755:	83 ec 04             	sub    $0x4,%esp
  801758:	68 00 29 80 00       	push   $0x802900
  80175d:	68 9f 00 00 00       	push   $0x9f
  801762:	68 f3 28 80 00       	push   $0x8028f3
  801767:	e8 6d ed ff ff       	call   8004d9 <_panic>

0080176c <shrink>:
}
void shrink(uint32 newSize)
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
  80176f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801772:	83 ec 04             	sub    $0x4,%esp
  801775:	68 00 29 80 00       	push   $0x802900
  80177a:	68 a3 00 00 00       	push   $0xa3
  80177f:	68 f3 28 80 00       	push   $0x8028f3
  801784:	e8 50 ed ff ff       	call   8004d9 <_panic>

00801789 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
  80178c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80178f:	83 ec 04             	sub    $0x4,%esp
  801792:	68 00 29 80 00       	push   $0x802900
  801797:	68 a8 00 00 00       	push   $0xa8
  80179c:	68 f3 28 80 00       	push   $0x8028f3
  8017a1:	e8 33 ed ff ff       	call   8004d9 <_panic>

008017a6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
  8017a9:	57                   	push   %edi
  8017aa:	56                   	push   %esi
  8017ab:	53                   	push   %ebx
  8017ac:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017b8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017bb:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017be:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017c1:	cd 30                	int    $0x30
  8017c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017c9:	83 c4 10             	add    $0x10,%esp
  8017cc:	5b                   	pop    %ebx
  8017cd:	5e                   	pop    %esi
  8017ce:	5f                   	pop    %edi
  8017cf:	5d                   	pop    %ebp
  8017d0:	c3                   	ret    

008017d1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
  8017d4:	83 ec 04             	sub    $0x4,%esp
  8017d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017da:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017dd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	52                   	push   %edx
  8017e9:	ff 75 0c             	pushl  0xc(%ebp)
  8017ec:	50                   	push   %eax
  8017ed:	6a 00                	push   $0x0
  8017ef:	e8 b2 ff ff ff       	call   8017a6 <syscall>
  8017f4:	83 c4 18             	add    $0x18,%esp
}
  8017f7:	90                   	nop
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <sys_cgetc>:

int
sys_cgetc(void)
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 01                	push   $0x1
  801809:	e8 98 ff ff ff       	call   8017a6 <syscall>
  80180e:	83 c4 18             	add    $0x18,%esp
}
  801811:	c9                   	leave  
  801812:	c3                   	ret    

00801813 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801813:	55                   	push   %ebp
  801814:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	50                   	push   %eax
  801822:	6a 05                	push   $0x5
  801824:	e8 7d ff ff ff       	call   8017a6 <syscall>
  801829:	83 c4 18             	add    $0x18,%esp
}
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 02                	push   $0x2
  80183d:	e8 64 ff ff ff       	call   8017a6 <syscall>
  801842:	83 c4 18             	add    $0x18,%esp
}
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 03                	push   $0x3
  801856:	e8 4b ff ff ff       	call   8017a6 <syscall>
  80185b:	83 c4 18             	add    $0x18,%esp
}
  80185e:	c9                   	leave  
  80185f:	c3                   	ret    

00801860 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801860:	55                   	push   %ebp
  801861:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 04                	push   $0x4
  80186f:	e8 32 ff ff ff       	call   8017a6 <syscall>
  801874:	83 c4 18             	add    $0x18,%esp
}
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <sys_env_exit>:


void sys_env_exit(void)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 06                	push   $0x6
  801888:	e8 19 ff ff ff       	call   8017a6 <syscall>
  80188d:	83 c4 18             	add    $0x18,%esp
}
  801890:	90                   	nop
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801896:	8b 55 0c             	mov    0xc(%ebp),%edx
  801899:	8b 45 08             	mov    0x8(%ebp),%eax
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	52                   	push   %edx
  8018a3:	50                   	push   %eax
  8018a4:	6a 07                	push   $0x7
  8018a6:	e8 fb fe ff ff       	call   8017a6 <syscall>
  8018ab:	83 c4 18             	add    $0x18,%esp
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	56                   	push   %esi
  8018b4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018b5:	8b 75 18             	mov    0x18(%ebp),%esi
  8018b8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	56                   	push   %esi
  8018c5:	53                   	push   %ebx
  8018c6:	51                   	push   %ecx
  8018c7:	52                   	push   %edx
  8018c8:	50                   	push   %eax
  8018c9:	6a 08                	push   $0x8
  8018cb:	e8 d6 fe ff ff       	call   8017a6 <syscall>
  8018d0:	83 c4 18             	add    $0x18,%esp
}
  8018d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018d6:	5b                   	pop    %ebx
  8018d7:	5e                   	pop    %esi
  8018d8:	5d                   	pop    %ebp
  8018d9:	c3                   	ret    

008018da <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	52                   	push   %edx
  8018ea:	50                   	push   %eax
  8018eb:	6a 09                	push   $0x9
  8018ed:	e8 b4 fe ff ff       	call   8017a6 <syscall>
  8018f2:	83 c4 18             	add    $0x18,%esp
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	ff 75 0c             	pushl  0xc(%ebp)
  801903:	ff 75 08             	pushl  0x8(%ebp)
  801906:	6a 0a                	push   $0xa
  801908:	e8 99 fe ff ff       	call   8017a6 <syscall>
  80190d:	83 c4 18             	add    $0x18,%esp
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 0b                	push   $0xb
  801921:	e8 80 fe ff ff       	call   8017a6 <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 0c                	push   $0xc
  80193a:	e8 67 fe ff ff       	call   8017a6 <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 0d                	push   $0xd
  801953:	e8 4e fe ff ff       	call   8017a6 <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	ff 75 0c             	pushl  0xc(%ebp)
  801969:	ff 75 08             	pushl  0x8(%ebp)
  80196c:	6a 11                	push   $0x11
  80196e:	e8 33 fe ff ff       	call   8017a6 <syscall>
  801973:	83 c4 18             	add    $0x18,%esp
	return;
  801976:	90                   	nop
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	ff 75 0c             	pushl  0xc(%ebp)
  801985:	ff 75 08             	pushl  0x8(%ebp)
  801988:	6a 12                	push   $0x12
  80198a:	e8 17 fe ff ff       	call   8017a6 <syscall>
  80198f:	83 c4 18             	add    $0x18,%esp
	return ;
  801992:	90                   	nop
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 0e                	push   $0xe
  8019a4:	e8 fd fd ff ff       	call   8017a6 <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
}
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	ff 75 08             	pushl  0x8(%ebp)
  8019bc:	6a 0f                	push   $0xf
  8019be:	e8 e3 fd ff ff       	call   8017a6 <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 10                	push   $0x10
  8019d7:	e8 ca fd ff ff       	call   8017a6 <syscall>
  8019dc:	83 c4 18             	add    $0x18,%esp
}
  8019df:	90                   	nop
  8019e0:	c9                   	leave  
  8019e1:	c3                   	ret    

008019e2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8019e2:	55                   	push   %ebp
  8019e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 14                	push   $0x14
  8019f1:	e8 b0 fd ff ff       	call   8017a6 <syscall>
  8019f6:	83 c4 18             	add    $0x18,%esp
}
  8019f9:	90                   	nop
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 15                	push   $0x15
  801a0b:	e8 96 fd ff ff       	call   8017a6 <syscall>
  801a10:	83 c4 18             	add    $0x18,%esp
}
  801a13:	90                   	nop
  801a14:	c9                   	leave  
  801a15:	c3                   	ret    

00801a16 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
  801a19:	83 ec 04             	sub    $0x4,%esp
  801a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a22:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	50                   	push   %eax
  801a2f:	6a 16                	push   $0x16
  801a31:	e8 70 fd ff ff       	call   8017a6 <syscall>
  801a36:	83 c4 18             	add    $0x18,%esp
}
  801a39:	90                   	nop
  801a3a:	c9                   	leave  
  801a3b:	c3                   	ret    

00801a3c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a3c:	55                   	push   %ebp
  801a3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 17                	push   $0x17
  801a4b:	e8 56 fd ff ff       	call   8017a6 <syscall>
  801a50:	83 c4 18             	add    $0x18,%esp
}
  801a53:	90                   	nop
  801a54:	c9                   	leave  
  801a55:	c3                   	ret    

00801a56 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a56:	55                   	push   %ebp
  801a57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a59:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	ff 75 0c             	pushl  0xc(%ebp)
  801a65:	50                   	push   %eax
  801a66:	6a 18                	push   $0x18
  801a68:	e8 39 fd ff ff       	call   8017a6 <syscall>
  801a6d:	83 c4 18             	add    $0x18,%esp
}
  801a70:	c9                   	leave  
  801a71:	c3                   	ret    

00801a72 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a72:	55                   	push   %ebp
  801a73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a75:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	52                   	push   %edx
  801a82:	50                   	push   %eax
  801a83:	6a 1b                	push   $0x1b
  801a85:	e8 1c fd ff ff       	call   8017a6 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a95:	8b 45 08             	mov    0x8(%ebp),%eax
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	52                   	push   %edx
  801a9f:	50                   	push   %eax
  801aa0:	6a 19                	push   $0x19
  801aa2:	e8 ff fc ff ff       	call   8017a6 <syscall>
  801aa7:	83 c4 18             	add    $0x18,%esp
}
  801aaa:	90                   	nop
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ab0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	52                   	push   %edx
  801abd:	50                   	push   %eax
  801abe:	6a 1a                	push   $0x1a
  801ac0:	e8 e1 fc ff ff       	call   8017a6 <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
}
  801ac8:	90                   	nop
  801ac9:	c9                   	leave  
  801aca:	c3                   	ret    

00801acb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
  801ace:	83 ec 04             	sub    $0x4,%esp
  801ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ad7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ada:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ade:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae1:	6a 00                	push   $0x0
  801ae3:	51                   	push   %ecx
  801ae4:	52                   	push   %edx
  801ae5:	ff 75 0c             	pushl  0xc(%ebp)
  801ae8:	50                   	push   %eax
  801ae9:	6a 1c                	push   $0x1c
  801aeb:	e8 b6 fc ff ff       	call   8017a6 <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
}
  801af3:	c9                   	leave  
  801af4:	c3                   	ret    

00801af5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801af5:	55                   	push   %ebp
  801af6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801af8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801afb:	8b 45 08             	mov    0x8(%ebp),%eax
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	52                   	push   %edx
  801b05:	50                   	push   %eax
  801b06:	6a 1d                	push   $0x1d
  801b08:	e8 99 fc ff ff       	call   8017a6 <syscall>
  801b0d:	83 c4 18             	add    $0x18,%esp
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b15:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	51                   	push   %ecx
  801b23:	52                   	push   %edx
  801b24:	50                   	push   %eax
  801b25:	6a 1e                	push   $0x1e
  801b27:	e8 7a fc ff ff       	call   8017a6 <syscall>
  801b2c:	83 c4 18             	add    $0x18,%esp
}
  801b2f:	c9                   	leave  
  801b30:	c3                   	ret    

00801b31 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	52                   	push   %edx
  801b41:	50                   	push   %eax
  801b42:	6a 1f                	push   $0x1f
  801b44:	e8 5d fc ff ff       	call   8017a6 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
}
  801b4c:	c9                   	leave  
  801b4d:	c3                   	ret    

00801b4e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 20                	push   $0x20
  801b5d:	e8 44 fc ff ff       	call   8017a6 <syscall>
  801b62:	83 c4 18             	add    $0x18,%esp
}
  801b65:	c9                   	leave  
  801b66:	c3                   	ret    

00801b67 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6d:	6a 00                	push   $0x0
  801b6f:	ff 75 14             	pushl  0x14(%ebp)
  801b72:	ff 75 10             	pushl  0x10(%ebp)
  801b75:	ff 75 0c             	pushl  0xc(%ebp)
  801b78:	50                   	push   %eax
  801b79:	6a 21                	push   $0x21
  801b7b:	e8 26 fc ff ff       	call   8017a6 <syscall>
  801b80:	83 c4 18             	add    $0x18,%esp
}
  801b83:	c9                   	leave  
  801b84:	c3                   	ret    

00801b85 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b88:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	50                   	push   %eax
  801b94:	6a 22                	push   $0x22
  801b96:	e8 0b fc ff ff       	call   8017a6 <syscall>
  801b9b:	83 c4 18             	add    $0x18,%esp
}
  801b9e:	90                   	nop
  801b9f:	c9                   	leave  
  801ba0:	c3                   	ret    

00801ba1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ba1:	55                   	push   %ebp
  801ba2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	50                   	push   %eax
  801bb0:	6a 23                	push   $0x23
  801bb2:	e8 ef fb ff ff       	call   8017a6 <syscall>
  801bb7:	83 c4 18             	add    $0x18,%esp
}
  801bba:	90                   	nop
  801bbb:	c9                   	leave  
  801bbc:	c3                   	ret    

00801bbd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801bbd:	55                   	push   %ebp
  801bbe:	89 e5                	mov    %esp,%ebp
  801bc0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801bc3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bc6:	8d 50 04             	lea    0x4(%eax),%edx
  801bc9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	52                   	push   %edx
  801bd3:	50                   	push   %eax
  801bd4:	6a 24                	push   $0x24
  801bd6:	e8 cb fb ff ff       	call   8017a6 <syscall>
  801bdb:	83 c4 18             	add    $0x18,%esp
	return result;
  801bde:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801be1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801be4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be7:	89 01                	mov    %eax,(%ecx)
  801be9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801bec:	8b 45 08             	mov    0x8(%ebp),%eax
  801bef:	c9                   	leave  
  801bf0:	c2 04 00             	ret    $0x4

00801bf3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	ff 75 10             	pushl  0x10(%ebp)
  801bfd:	ff 75 0c             	pushl  0xc(%ebp)
  801c00:	ff 75 08             	pushl  0x8(%ebp)
  801c03:	6a 13                	push   $0x13
  801c05:	e8 9c fb ff ff       	call   8017a6 <syscall>
  801c0a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0d:	90                   	nop
}
  801c0e:	c9                   	leave  
  801c0f:	c3                   	ret    

00801c10 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c10:	55                   	push   %ebp
  801c11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 25                	push   $0x25
  801c1f:	e8 82 fb ff ff       	call   8017a6 <syscall>
  801c24:	83 c4 18             	add    $0x18,%esp
}
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
  801c2c:	83 ec 04             	sub    $0x4,%esp
  801c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c32:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c35:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	50                   	push   %eax
  801c42:	6a 26                	push   $0x26
  801c44:	e8 5d fb ff ff       	call   8017a6 <syscall>
  801c49:	83 c4 18             	add    $0x18,%esp
	return ;
  801c4c:	90                   	nop
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <rsttst>:
void rsttst()
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 28                	push   $0x28
  801c5e:	e8 43 fb ff ff       	call   8017a6 <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
	return ;
  801c66:	90                   	nop
}
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
  801c6c:	83 ec 04             	sub    $0x4,%esp
  801c6f:	8b 45 14             	mov    0x14(%ebp),%eax
  801c72:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c75:	8b 55 18             	mov    0x18(%ebp),%edx
  801c78:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c7c:	52                   	push   %edx
  801c7d:	50                   	push   %eax
  801c7e:	ff 75 10             	pushl  0x10(%ebp)
  801c81:	ff 75 0c             	pushl  0xc(%ebp)
  801c84:	ff 75 08             	pushl  0x8(%ebp)
  801c87:	6a 27                	push   $0x27
  801c89:	e8 18 fb ff ff       	call   8017a6 <syscall>
  801c8e:	83 c4 18             	add    $0x18,%esp
	return ;
  801c91:	90                   	nop
}
  801c92:	c9                   	leave  
  801c93:	c3                   	ret    

00801c94 <chktst>:
void chktst(uint32 n)
{
  801c94:	55                   	push   %ebp
  801c95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	ff 75 08             	pushl  0x8(%ebp)
  801ca2:	6a 29                	push   $0x29
  801ca4:	e8 fd fa ff ff       	call   8017a6 <syscall>
  801ca9:	83 c4 18             	add    $0x18,%esp
	return ;
  801cac:	90                   	nop
}
  801cad:	c9                   	leave  
  801cae:	c3                   	ret    

00801caf <inctst>:

void inctst()
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 2a                	push   $0x2a
  801cbe:	e8 e3 fa ff ff       	call   8017a6 <syscall>
  801cc3:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc6:	90                   	nop
}
  801cc7:	c9                   	leave  
  801cc8:	c3                   	ret    

00801cc9 <gettst>:
uint32 gettst()
{
  801cc9:	55                   	push   %ebp
  801cca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 2b                	push   $0x2b
  801cd8:	e8 c9 fa ff ff       	call   8017a6 <syscall>
  801cdd:	83 c4 18             	add    $0x18,%esp
}
  801ce0:	c9                   	leave  
  801ce1:	c3                   	ret    

00801ce2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
  801ce5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 2c                	push   $0x2c
  801cf4:	e8 ad fa ff ff       	call   8017a6 <syscall>
  801cf9:	83 c4 18             	add    $0x18,%esp
  801cfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801cff:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d03:	75 07                	jne    801d0c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d05:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0a:	eb 05                	jmp    801d11 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d11:	c9                   	leave  
  801d12:	c3                   	ret    

00801d13 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d13:	55                   	push   %ebp
  801d14:	89 e5                	mov    %esp,%ebp
  801d16:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 2c                	push   $0x2c
  801d25:	e8 7c fa ff ff       	call   8017a6 <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
  801d2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d30:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d34:	75 07                	jne    801d3d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d36:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3b:	eb 05                	jmp    801d42 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
  801d47:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	6a 2c                	push   $0x2c
  801d56:	e8 4b fa ff ff       	call   8017a6 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
  801d5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d61:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d65:	75 07                	jne    801d6e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d67:	b8 01 00 00 00       	mov    $0x1,%eax
  801d6c:	eb 05                	jmp    801d73 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d73:	c9                   	leave  
  801d74:	c3                   	ret    

00801d75 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d75:	55                   	push   %ebp
  801d76:	89 e5                	mov    %esp,%ebp
  801d78:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 2c                	push   $0x2c
  801d87:	e8 1a fa ff ff       	call   8017a6 <syscall>
  801d8c:	83 c4 18             	add    $0x18,%esp
  801d8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d92:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d96:	75 07                	jne    801d9f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d98:	b8 01 00 00 00       	mov    $0x1,%eax
  801d9d:	eb 05                	jmp    801da4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	ff 75 08             	pushl  0x8(%ebp)
  801db4:	6a 2d                	push   $0x2d
  801db6:	e8 eb f9 ff ff       	call   8017a6 <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
	return ;
  801dbe:	90                   	nop
}
  801dbf:	c9                   	leave  
  801dc0:	c3                   	ret    

00801dc1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801dc1:	55                   	push   %ebp
  801dc2:	89 e5                	mov    %esp,%ebp
  801dc4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801dc5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dc8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dce:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd1:	6a 00                	push   $0x0
  801dd3:	53                   	push   %ebx
  801dd4:	51                   	push   %ecx
  801dd5:	52                   	push   %edx
  801dd6:	50                   	push   %eax
  801dd7:	6a 2e                	push   $0x2e
  801dd9:	e8 c8 f9 ff ff       	call   8017a6 <syscall>
  801dde:	83 c4 18             	add    $0x18,%esp
}
  801de1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801de4:	c9                   	leave  
  801de5:	c3                   	ret    

00801de6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801de6:	55                   	push   %ebp
  801de7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801de9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dec:	8b 45 08             	mov    0x8(%ebp),%eax
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	52                   	push   %edx
  801df6:	50                   	push   %eax
  801df7:	6a 2f                	push   $0x2f
  801df9:	e8 a8 f9 ff ff       	call   8017a6 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    
  801e03:	90                   	nop

00801e04 <__udivdi3>:
  801e04:	55                   	push   %ebp
  801e05:	57                   	push   %edi
  801e06:	56                   	push   %esi
  801e07:	53                   	push   %ebx
  801e08:	83 ec 1c             	sub    $0x1c,%esp
  801e0b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e0f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e13:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e17:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e1b:	89 ca                	mov    %ecx,%edx
  801e1d:	89 f8                	mov    %edi,%eax
  801e1f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e23:	85 f6                	test   %esi,%esi
  801e25:	75 2d                	jne    801e54 <__udivdi3+0x50>
  801e27:	39 cf                	cmp    %ecx,%edi
  801e29:	77 65                	ja     801e90 <__udivdi3+0x8c>
  801e2b:	89 fd                	mov    %edi,%ebp
  801e2d:	85 ff                	test   %edi,%edi
  801e2f:	75 0b                	jne    801e3c <__udivdi3+0x38>
  801e31:	b8 01 00 00 00       	mov    $0x1,%eax
  801e36:	31 d2                	xor    %edx,%edx
  801e38:	f7 f7                	div    %edi
  801e3a:	89 c5                	mov    %eax,%ebp
  801e3c:	31 d2                	xor    %edx,%edx
  801e3e:	89 c8                	mov    %ecx,%eax
  801e40:	f7 f5                	div    %ebp
  801e42:	89 c1                	mov    %eax,%ecx
  801e44:	89 d8                	mov    %ebx,%eax
  801e46:	f7 f5                	div    %ebp
  801e48:	89 cf                	mov    %ecx,%edi
  801e4a:	89 fa                	mov    %edi,%edx
  801e4c:	83 c4 1c             	add    $0x1c,%esp
  801e4f:	5b                   	pop    %ebx
  801e50:	5e                   	pop    %esi
  801e51:	5f                   	pop    %edi
  801e52:	5d                   	pop    %ebp
  801e53:	c3                   	ret    
  801e54:	39 ce                	cmp    %ecx,%esi
  801e56:	77 28                	ja     801e80 <__udivdi3+0x7c>
  801e58:	0f bd fe             	bsr    %esi,%edi
  801e5b:	83 f7 1f             	xor    $0x1f,%edi
  801e5e:	75 40                	jne    801ea0 <__udivdi3+0x9c>
  801e60:	39 ce                	cmp    %ecx,%esi
  801e62:	72 0a                	jb     801e6e <__udivdi3+0x6a>
  801e64:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e68:	0f 87 9e 00 00 00    	ja     801f0c <__udivdi3+0x108>
  801e6e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e73:	89 fa                	mov    %edi,%edx
  801e75:	83 c4 1c             	add    $0x1c,%esp
  801e78:	5b                   	pop    %ebx
  801e79:	5e                   	pop    %esi
  801e7a:	5f                   	pop    %edi
  801e7b:	5d                   	pop    %ebp
  801e7c:	c3                   	ret    
  801e7d:	8d 76 00             	lea    0x0(%esi),%esi
  801e80:	31 ff                	xor    %edi,%edi
  801e82:	31 c0                	xor    %eax,%eax
  801e84:	89 fa                	mov    %edi,%edx
  801e86:	83 c4 1c             	add    $0x1c,%esp
  801e89:	5b                   	pop    %ebx
  801e8a:	5e                   	pop    %esi
  801e8b:	5f                   	pop    %edi
  801e8c:	5d                   	pop    %ebp
  801e8d:	c3                   	ret    
  801e8e:	66 90                	xchg   %ax,%ax
  801e90:	89 d8                	mov    %ebx,%eax
  801e92:	f7 f7                	div    %edi
  801e94:	31 ff                	xor    %edi,%edi
  801e96:	89 fa                	mov    %edi,%edx
  801e98:	83 c4 1c             	add    $0x1c,%esp
  801e9b:	5b                   	pop    %ebx
  801e9c:	5e                   	pop    %esi
  801e9d:	5f                   	pop    %edi
  801e9e:	5d                   	pop    %ebp
  801e9f:	c3                   	ret    
  801ea0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ea5:	89 eb                	mov    %ebp,%ebx
  801ea7:	29 fb                	sub    %edi,%ebx
  801ea9:	89 f9                	mov    %edi,%ecx
  801eab:	d3 e6                	shl    %cl,%esi
  801ead:	89 c5                	mov    %eax,%ebp
  801eaf:	88 d9                	mov    %bl,%cl
  801eb1:	d3 ed                	shr    %cl,%ebp
  801eb3:	89 e9                	mov    %ebp,%ecx
  801eb5:	09 f1                	or     %esi,%ecx
  801eb7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ebb:	89 f9                	mov    %edi,%ecx
  801ebd:	d3 e0                	shl    %cl,%eax
  801ebf:	89 c5                	mov    %eax,%ebp
  801ec1:	89 d6                	mov    %edx,%esi
  801ec3:	88 d9                	mov    %bl,%cl
  801ec5:	d3 ee                	shr    %cl,%esi
  801ec7:	89 f9                	mov    %edi,%ecx
  801ec9:	d3 e2                	shl    %cl,%edx
  801ecb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ecf:	88 d9                	mov    %bl,%cl
  801ed1:	d3 e8                	shr    %cl,%eax
  801ed3:	09 c2                	or     %eax,%edx
  801ed5:	89 d0                	mov    %edx,%eax
  801ed7:	89 f2                	mov    %esi,%edx
  801ed9:	f7 74 24 0c          	divl   0xc(%esp)
  801edd:	89 d6                	mov    %edx,%esi
  801edf:	89 c3                	mov    %eax,%ebx
  801ee1:	f7 e5                	mul    %ebp
  801ee3:	39 d6                	cmp    %edx,%esi
  801ee5:	72 19                	jb     801f00 <__udivdi3+0xfc>
  801ee7:	74 0b                	je     801ef4 <__udivdi3+0xf0>
  801ee9:	89 d8                	mov    %ebx,%eax
  801eeb:	31 ff                	xor    %edi,%edi
  801eed:	e9 58 ff ff ff       	jmp    801e4a <__udivdi3+0x46>
  801ef2:	66 90                	xchg   %ax,%ax
  801ef4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ef8:	89 f9                	mov    %edi,%ecx
  801efa:	d3 e2                	shl    %cl,%edx
  801efc:	39 c2                	cmp    %eax,%edx
  801efe:	73 e9                	jae    801ee9 <__udivdi3+0xe5>
  801f00:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f03:	31 ff                	xor    %edi,%edi
  801f05:	e9 40 ff ff ff       	jmp    801e4a <__udivdi3+0x46>
  801f0a:	66 90                	xchg   %ax,%ax
  801f0c:	31 c0                	xor    %eax,%eax
  801f0e:	e9 37 ff ff ff       	jmp    801e4a <__udivdi3+0x46>
  801f13:	90                   	nop

00801f14 <__umoddi3>:
  801f14:	55                   	push   %ebp
  801f15:	57                   	push   %edi
  801f16:	56                   	push   %esi
  801f17:	53                   	push   %ebx
  801f18:	83 ec 1c             	sub    $0x1c,%esp
  801f1b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f1f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f27:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f2f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f33:	89 f3                	mov    %esi,%ebx
  801f35:	89 fa                	mov    %edi,%edx
  801f37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f3b:	89 34 24             	mov    %esi,(%esp)
  801f3e:	85 c0                	test   %eax,%eax
  801f40:	75 1a                	jne    801f5c <__umoddi3+0x48>
  801f42:	39 f7                	cmp    %esi,%edi
  801f44:	0f 86 a2 00 00 00    	jbe    801fec <__umoddi3+0xd8>
  801f4a:	89 c8                	mov    %ecx,%eax
  801f4c:	89 f2                	mov    %esi,%edx
  801f4e:	f7 f7                	div    %edi
  801f50:	89 d0                	mov    %edx,%eax
  801f52:	31 d2                	xor    %edx,%edx
  801f54:	83 c4 1c             	add    $0x1c,%esp
  801f57:	5b                   	pop    %ebx
  801f58:	5e                   	pop    %esi
  801f59:	5f                   	pop    %edi
  801f5a:	5d                   	pop    %ebp
  801f5b:	c3                   	ret    
  801f5c:	39 f0                	cmp    %esi,%eax
  801f5e:	0f 87 ac 00 00 00    	ja     802010 <__umoddi3+0xfc>
  801f64:	0f bd e8             	bsr    %eax,%ebp
  801f67:	83 f5 1f             	xor    $0x1f,%ebp
  801f6a:	0f 84 ac 00 00 00    	je     80201c <__umoddi3+0x108>
  801f70:	bf 20 00 00 00       	mov    $0x20,%edi
  801f75:	29 ef                	sub    %ebp,%edi
  801f77:	89 fe                	mov    %edi,%esi
  801f79:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f7d:	89 e9                	mov    %ebp,%ecx
  801f7f:	d3 e0                	shl    %cl,%eax
  801f81:	89 d7                	mov    %edx,%edi
  801f83:	89 f1                	mov    %esi,%ecx
  801f85:	d3 ef                	shr    %cl,%edi
  801f87:	09 c7                	or     %eax,%edi
  801f89:	89 e9                	mov    %ebp,%ecx
  801f8b:	d3 e2                	shl    %cl,%edx
  801f8d:	89 14 24             	mov    %edx,(%esp)
  801f90:	89 d8                	mov    %ebx,%eax
  801f92:	d3 e0                	shl    %cl,%eax
  801f94:	89 c2                	mov    %eax,%edx
  801f96:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f9a:	d3 e0                	shl    %cl,%eax
  801f9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fa0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fa4:	89 f1                	mov    %esi,%ecx
  801fa6:	d3 e8                	shr    %cl,%eax
  801fa8:	09 d0                	or     %edx,%eax
  801faa:	d3 eb                	shr    %cl,%ebx
  801fac:	89 da                	mov    %ebx,%edx
  801fae:	f7 f7                	div    %edi
  801fb0:	89 d3                	mov    %edx,%ebx
  801fb2:	f7 24 24             	mull   (%esp)
  801fb5:	89 c6                	mov    %eax,%esi
  801fb7:	89 d1                	mov    %edx,%ecx
  801fb9:	39 d3                	cmp    %edx,%ebx
  801fbb:	0f 82 87 00 00 00    	jb     802048 <__umoddi3+0x134>
  801fc1:	0f 84 91 00 00 00    	je     802058 <__umoddi3+0x144>
  801fc7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fcb:	29 f2                	sub    %esi,%edx
  801fcd:	19 cb                	sbb    %ecx,%ebx
  801fcf:	89 d8                	mov    %ebx,%eax
  801fd1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fd5:	d3 e0                	shl    %cl,%eax
  801fd7:	89 e9                	mov    %ebp,%ecx
  801fd9:	d3 ea                	shr    %cl,%edx
  801fdb:	09 d0                	or     %edx,%eax
  801fdd:	89 e9                	mov    %ebp,%ecx
  801fdf:	d3 eb                	shr    %cl,%ebx
  801fe1:	89 da                	mov    %ebx,%edx
  801fe3:	83 c4 1c             	add    $0x1c,%esp
  801fe6:	5b                   	pop    %ebx
  801fe7:	5e                   	pop    %esi
  801fe8:	5f                   	pop    %edi
  801fe9:	5d                   	pop    %ebp
  801fea:	c3                   	ret    
  801feb:	90                   	nop
  801fec:	89 fd                	mov    %edi,%ebp
  801fee:	85 ff                	test   %edi,%edi
  801ff0:	75 0b                	jne    801ffd <__umoddi3+0xe9>
  801ff2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ff7:	31 d2                	xor    %edx,%edx
  801ff9:	f7 f7                	div    %edi
  801ffb:	89 c5                	mov    %eax,%ebp
  801ffd:	89 f0                	mov    %esi,%eax
  801fff:	31 d2                	xor    %edx,%edx
  802001:	f7 f5                	div    %ebp
  802003:	89 c8                	mov    %ecx,%eax
  802005:	f7 f5                	div    %ebp
  802007:	89 d0                	mov    %edx,%eax
  802009:	e9 44 ff ff ff       	jmp    801f52 <__umoddi3+0x3e>
  80200e:	66 90                	xchg   %ax,%ax
  802010:	89 c8                	mov    %ecx,%eax
  802012:	89 f2                	mov    %esi,%edx
  802014:	83 c4 1c             	add    $0x1c,%esp
  802017:	5b                   	pop    %ebx
  802018:	5e                   	pop    %esi
  802019:	5f                   	pop    %edi
  80201a:	5d                   	pop    %ebp
  80201b:	c3                   	ret    
  80201c:	3b 04 24             	cmp    (%esp),%eax
  80201f:	72 06                	jb     802027 <__umoddi3+0x113>
  802021:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802025:	77 0f                	ja     802036 <__umoddi3+0x122>
  802027:	89 f2                	mov    %esi,%edx
  802029:	29 f9                	sub    %edi,%ecx
  80202b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80202f:	89 14 24             	mov    %edx,(%esp)
  802032:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802036:	8b 44 24 04          	mov    0x4(%esp),%eax
  80203a:	8b 14 24             	mov    (%esp),%edx
  80203d:	83 c4 1c             	add    $0x1c,%esp
  802040:	5b                   	pop    %ebx
  802041:	5e                   	pop    %esi
  802042:	5f                   	pop    %edi
  802043:	5d                   	pop    %ebp
  802044:	c3                   	ret    
  802045:	8d 76 00             	lea    0x0(%esi),%esi
  802048:	2b 04 24             	sub    (%esp),%eax
  80204b:	19 fa                	sbb    %edi,%edx
  80204d:	89 d1                	mov    %edx,%ecx
  80204f:	89 c6                	mov    %eax,%esi
  802051:	e9 71 ff ff ff       	jmp    801fc7 <__umoddi3+0xb3>
  802056:	66 90                	xchg   %ax,%ax
  802058:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80205c:	72 ea                	jb     802048 <__umoddi3+0x134>
  80205e:	89 d9                	mov    %ebx,%ecx
  802060:	e9 62 ff ff ff       	jmp    801fc7 <__umoddi3+0xb3>
