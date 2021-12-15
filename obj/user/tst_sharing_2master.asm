
obj/user/tst_sharing_2master:     file format elf32-i386


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
  800031:	e8 22 03 00 00       	call   800358 <libmain>
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
  800087:	68 e0 20 80 00       	push   $0x8020e0
  80008c:	6a 13                	push   $0x13
  80008e:	68 fc 20 80 00       	push   $0x8020fc
  800093:	e8 05 04 00 00       	call   80049d <_panic>
	}
	uint32 *x, *y, *z ;

	//x: Readonly
	int freeFrames = sys_calculate_free_frames() ;
  800098:	e8 39 18 00 00       	call   8018d6 <sys_calculate_free_frames>
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	x = smalloc("x", 4, 0);
  8000a0:	83 ec 04             	sub    $0x4,%esp
  8000a3:	6a 00                	push   $0x0
  8000a5:	6a 04                	push   $0x4
  8000a7:	68 17 21 80 00       	push   $0x802117
  8000ac:	e8 e8 15 00 00       	call   801699 <smalloc>
  8000b1:	83 c4 10             	add    $0x10,%esp
  8000b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
	if (x != (uint32*)USER_HEAP_START) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  8000b7:	81 7d e8 00 00 00 80 	cmpl   $0x80000000,-0x18(%ebp)
  8000be:	74 14                	je     8000d4 <_main+0x9c>
  8000c0:	83 ec 04             	sub    $0x4,%esp
  8000c3:	68 1c 21 80 00       	push   $0x80211c
  8000c8:	6a 1a                	push   $0x1a
  8000ca:	68 fc 20 80 00       	push   $0x8020fc
  8000cf:	e8 c9 03 00 00       	call   80049d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8000d4:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000d7:	e8 fa 17 00 00       	call   8018d6 <sys_calculate_free_frames>
  8000dc:	29 c3                	sub    %eax,%ebx
  8000de:	89 d8                	mov    %ebx,%eax
  8000e0:	83 f8 04             	cmp    $0x4,%eax
  8000e3:	74 14                	je     8000f9 <_main+0xc1>
  8000e5:	83 ec 04             	sub    $0x4,%esp
  8000e8:	68 80 21 80 00       	push   $0x802180
  8000ed:	6a 1b                	push   $0x1b
  8000ef:	68 fc 20 80 00       	push   $0x8020fc
  8000f4:	e8 a4 03 00 00       	call   80049d <_panic>

	//y: Readonly
	freeFrames = sys_calculate_free_frames() ;
  8000f9:	e8 d8 17 00 00       	call   8018d6 <sys_calculate_free_frames>
  8000fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
	y = smalloc("y", 4, 0);
  800101:	83 ec 04             	sub    $0x4,%esp
  800104:	6a 00                	push   $0x0
  800106:	6a 04                	push   $0x4
  800108:	68 08 22 80 00       	push   $0x802208
  80010d:	e8 87 15 00 00       	call   801699 <smalloc>
  800112:	83 c4 10             	add    $0x10,%esp
  800115:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if (y != (uint32*)(USER_HEAP_START + 1 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  800118:	81 7d e4 00 10 00 80 	cmpl   $0x80001000,-0x1c(%ebp)
  80011f:	74 14                	je     800135 <_main+0xfd>
  800121:	83 ec 04             	sub    $0x4,%esp
  800124:	68 1c 21 80 00       	push   $0x80211c
  800129:	6a 20                	push   $0x20
  80012b:	68 fc 20 80 00       	push   $0x8020fc
  800130:	e8 68 03 00 00       	call   80049d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800135:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800138:	e8 99 17 00 00       	call   8018d6 <sys_calculate_free_frames>
  80013d:	29 c3                	sub    %eax,%ebx
  80013f:	89 d8                	mov    %ebx,%eax
  800141:	83 f8 03             	cmp    $0x3,%eax
  800144:	74 14                	je     80015a <_main+0x122>
  800146:	83 ec 04             	sub    $0x4,%esp
  800149:	68 80 21 80 00       	push   $0x802180
  80014e:	6a 21                	push   $0x21
  800150:	68 fc 20 80 00       	push   $0x8020fc
  800155:	e8 43 03 00 00       	call   80049d <_panic>

	//z: Writable
	freeFrames = sys_calculate_free_frames() ;
  80015a:	e8 77 17 00 00       	call   8018d6 <sys_calculate_free_frames>
  80015f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	z = smalloc("z", 4, 1);
  800162:	83 ec 04             	sub    $0x4,%esp
  800165:	6a 01                	push   $0x1
  800167:	6a 04                	push   $0x4
  800169:	68 0a 22 80 00       	push   $0x80220a
  80016e:	e8 26 15 00 00       	call   801699 <smalloc>
  800173:	83 c4 10             	add    $0x10,%esp
  800176:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (z != (uint32*)(USER_HEAP_START + 2 * PAGE_SIZE)) panic("Create(): Returned address is not correct. make sure that you align the allocation on 4KB boundary");
  800179:	81 7d e0 00 20 00 80 	cmpl   $0x80002000,-0x20(%ebp)
  800180:	74 14                	je     800196 <_main+0x15e>
  800182:	83 ec 04             	sub    $0x4,%esp
  800185:	68 1c 21 80 00       	push   $0x80211c
  80018a:	6a 26                	push   $0x26
  80018c:	68 fc 20 80 00       	push   $0x8020fc
  800191:	e8 07 03 00 00       	call   80049d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) !=  1+0+2) panic("Create(): Wrong allocation- make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800196:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800199:	e8 38 17 00 00       	call   8018d6 <sys_calculate_free_frames>
  80019e:	29 c3                	sub    %eax,%ebx
  8001a0:	89 d8                	mov    %ebx,%eax
  8001a2:	83 f8 03             	cmp    $0x3,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 80 21 80 00       	push   $0x802180
  8001af:	6a 27                	push   $0x27
  8001b1:	68 fc 20 80 00       	push   $0x8020fc
  8001b6:	e8 e2 02 00 00       	call   80049d <_panic>

	*x = 10 ;
  8001bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001be:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
	*y = 20 ;
  8001c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001c7:	c7 00 14 00 00 00    	movl   $0x14,(%eax)

	int id1, id2, id3;
	id1 = sys_create_env("shr2Slave1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8001cd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d2:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8001e3:	89 c1                	mov    %eax,%ecx
  8001e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ea:	8b 40 74             	mov    0x74(%eax),%eax
  8001ed:	52                   	push   %edx
  8001ee:	51                   	push   %ecx
  8001ef:	50                   	push   %eax
  8001f0:	68 0c 22 80 00       	push   $0x80220c
  8001f5:	e8 31 19 00 00       	call   801b2b <sys_create_env>
  8001fa:	83 c4 10             	add    $0x10,%esp
  8001fd:	89 45 dc             	mov    %eax,-0x24(%ebp)
	id2 = sys_create_env("shr2Slave1", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800200:	a1 20 30 80 00       	mov    0x803020,%eax
  800205:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80020b:	a1 20 30 80 00       	mov    0x803020,%eax
  800210:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800216:	89 c1                	mov    %eax,%ecx
  800218:	a1 20 30 80 00       	mov    0x803020,%eax
  80021d:	8b 40 74             	mov    0x74(%eax),%eax
  800220:	52                   	push   %edx
  800221:	51                   	push   %ecx
  800222:	50                   	push   %eax
  800223:	68 0c 22 80 00       	push   $0x80220c
  800228:	e8 fe 18 00 00       	call   801b2b <sys_create_env>
  80022d:	83 c4 10             	add    $0x10,%esp
  800230:	89 45 d8             	mov    %eax,-0x28(%ebp)
	id3 = sys_create_env("shr2Slave1", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800233:	a1 20 30 80 00       	mov    0x803020,%eax
  800238:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80023e:	a1 20 30 80 00       	mov    0x803020,%eax
  800243:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800249:	89 c1                	mov    %eax,%ecx
  80024b:	a1 20 30 80 00       	mov    0x803020,%eax
  800250:	8b 40 74             	mov    0x74(%eax),%eax
  800253:	52                   	push   %edx
  800254:	51                   	push   %ecx
  800255:	50                   	push   %eax
  800256:	68 0c 22 80 00       	push   $0x80220c
  80025b:	e8 cb 18 00 00       	call   801b2b <sys_create_env>
  800260:	83 c4 10             	add    $0x10,%esp
  800263:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//to check that the slave environments completed successfully
	rsttst();
  800266:	e8 a8 19 00 00       	call   801c13 <rsttst>

	sys_run_env(id1);
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	ff 75 dc             	pushl  -0x24(%ebp)
  800271:	e8 d3 18 00 00       	call   801b49 <sys_run_env>
  800276:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  800279:	83 ec 0c             	sub    $0xc,%esp
  80027c:	ff 75 d8             	pushl  -0x28(%ebp)
  80027f:	e8 c5 18 00 00       	call   801b49 <sys_run_env>
  800284:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	ff 75 d4             	pushl  -0x2c(%ebp)
  80028d:	e8 b7 18 00 00       	call   801b49 <sys_run_env>
  800292:	83 c4 10             	add    $0x10,%esp

	env_sleep(12000) ;
  800295:	83 ec 0c             	sub    $0xc,%esp
  800298:	68 e0 2e 00 00       	push   $0x2ee0
  80029d:	e8 25 1b 00 00       	call   801dc7 <env_sleep>
  8002a2:	83 c4 10             	add    $0x10,%esp

	//to ensure that the slave environments completed successfully
	if (gettst()!=3) panic("test failed");
  8002a5:	e8 e3 19 00 00       	call   801c8d <gettst>
  8002aa:	83 f8 03             	cmp    $0x3,%eax
  8002ad:	74 14                	je     8002c3 <_main+0x28b>
  8002af:	83 ec 04             	sub    $0x4,%esp
  8002b2:	68 17 22 80 00       	push   $0x802217
  8002b7:	6a 3b                	push   $0x3b
  8002b9:	68 fc 20 80 00       	push   $0x8020fc
  8002be:	e8 da 01 00 00       	call   80049d <_panic>


	if (*z != 30)
  8002c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002c6:	8b 00                	mov    (%eax),%eax
  8002c8:	83 f8 1e             	cmp    $0x1e,%eax
  8002cb:	74 14                	je     8002e1 <_main+0x2a9>
		panic("Error!! Please check the creation (or the getting) of shared variables!!\n\n\n");
  8002cd:	83 ec 04             	sub    $0x4,%esp
  8002d0:	68 24 22 80 00       	push   $0x802224
  8002d5:	6a 3f                	push   $0x3f
  8002d7:	68 fc 20 80 00       	push   $0x8020fc
  8002dc:	e8 bc 01 00 00       	call   80049d <_panic>
	else
		cprintf("Congratulations!! Test of Shared Variables [Create & Get] [2] completed successfully!!\n\n\n");
  8002e1:	83 ec 0c             	sub    $0xc,%esp
  8002e4:	68 70 22 80 00       	push   $0x802270
  8002e9:	e8 51 04 00 00       	call   80073f <cprintf>
  8002ee:	83 c4 10             	add    $0x10,%esp

	cprintf("Now, ILLEGAL MEM ACCESS should be occur, due to attempting to write a ReadOnly variable\n\n\n");
  8002f1:	83 ec 0c             	sub    $0xc,%esp
  8002f4:	68 cc 22 80 00       	push   $0x8022cc
  8002f9:	e8 41 04 00 00       	call   80073f <cprintf>
  8002fe:	83 c4 10             	add    $0x10,%esp

	id1 = sys_create_env("shr2Slave2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800301:	a1 20 30 80 00       	mov    0x803020,%eax
  800306:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80030c:	a1 20 30 80 00       	mov    0x803020,%eax
  800311:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800317:	89 c1                	mov    %eax,%ecx
  800319:	a1 20 30 80 00       	mov    0x803020,%eax
  80031e:	8b 40 74             	mov    0x74(%eax),%eax
  800321:	52                   	push   %edx
  800322:	51                   	push   %ecx
  800323:	50                   	push   %eax
  800324:	68 27 23 80 00       	push   $0x802327
  800329:	e8 fd 17 00 00       	call   801b2b <sys_create_env>
  80032e:	83 c4 10             	add    $0x10,%esp
  800331:	89 45 dc             	mov    %eax,-0x24(%ebp)

	env_sleep(3000) ;
  800334:	83 ec 0c             	sub    $0xc,%esp
  800337:	68 b8 0b 00 00       	push   $0xbb8
  80033c:	e8 86 1a 00 00       	call   801dc7 <env_sleep>
  800341:	83 c4 10             	add    $0x10,%esp

	sys_run_env(id1);
  800344:	83 ec 0c             	sub    $0xc,%esp
  800347:	ff 75 dc             	pushl  -0x24(%ebp)
  80034a:	e8 fa 17 00 00       	call   801b49 <sys_run_env>
  80034f:	83 c4 10             	add    $0x10,%esp

	return;
  800352:	90                   	nop
}
  800353:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800356:	c9                   	leave  
  800357:	c3                   	ret    

00800358 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800358:	55                   	push   %ebp
  800359:	89 e5                	mov    %esp,%ebp
  80035b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80035e:	e8 a8 14 00 00       	call   80180b <sys_getenvindex>
  800363:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800366:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800369:	89 d0                	mov    %edx,%eax
  80036b:	c1 e0 03             	shl    $0x3,%eax
  80036e:	01 d0                	add    %edx,%eax
  800370:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800377:	01 c8                	add    %ecx,%eax
  800379:	01 c0                	add    %eax,%eax
  80037b:	01 d0                	add    %edx,%eax
  80037d:	01 c0                	add    %eax,%eax
  80037f:	01 d0                	add    %edx,%eax
  800381:	89 c2                	mov    %eax,%edx
  800383:	c1 e2 05             	shl    $0x5,%edx
  800386:	29 c2                	sub    %eax,%edx
  800388:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80038f:	89 c2                	mov    %eax,%edx
  800391:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800397:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80039c:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a1:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003a7:	84 c0                	test   %al,%al
  8003a9:	74 0f                	je     8003ba <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b0:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003b5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003be:	7e 0a                	jle    8003ca <libmain+0x72>
		binaryname = argv[0];
  8003c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c3:	8b 00                	mov    (%eax),%eax
  8003c5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003ca:	83 ec 08             	sub    $0x8,%esp
  8003cd:	ff 75 0c             	pushl  0xc(%ebp)
  8003d0:	ff 75 08             	pushl  0x8(%ebp)
  8003d3:	e8 60 fc ff ff       	call   800038 <_main>
  8003d8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003db:	e8 c6 15 00 00       	call   8019a6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003e0:	83 ec 0c             	sub    $0xc,%esp
  8003e3:	68 4c 23 80 00       	push   $0x80234c
  8003e8:	e8 52 03 00 00       	call   80073f <cprintf>
  8003ed:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f5:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800400:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800406:	83 ec 04             	sub    $0x4,%esp
  800409:	52                   	push   %edx
  80040a:	50                   	push   %eax
  80040b:	68 74 23 80 00       	push   $0x802374
  800410:	e8 2a 03 00 00       	call   80073f <cprintf>
  800415:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800418:	a1 20 30 80 00       	mov    0x803020,%eax
  80041d:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800423:	a1 20 30 80 00       	mov    0x803020,%eax
  800428:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80042e:	83 ec 04             	sub    $0x4,%esp
  800431:	52                   	push   %edx
  800432:	50                   	push   %eax
  800433:	68 9c 23 80 00       	push   $0x80239c
  800438:	e8 02 03 00 00       	call   80073f <cprintf>
  80043d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800440:	a1 20 30 80 00       	mov    0x803020,%eax
  800445:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80044b:	83 ec 08             	sub    $0x8,%esp
  80044e:	50                   	push   %eax
  80044f:	68 dd 23 80 00       	push   $0x8023dd
  800454:	e8 e6 02 00 00       	call   80073f <cprintf>
  800459:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80045c:	83 ec 0c             	sub    $0xc,%esp
  80045f:	68 4c 23 80 00       	push   $0x80234c
  800464:	e8 d6 02 00 00       	call   80073f <cprintf>
  800469:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80046c:	e8 4f 15 00 00       	call   8019c0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800471:	e8 19 00 00 00       	call   80048f <exit>
}
  800476:	90                   	nop
  800477:	c9                   	leave  
  800478:	c3                   	ret    

00800479 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800479:	55                   	push   %ebp
  80047a:	89 e5                	mov    %esp,%ebp
  80047c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80047f:	83 ec 0c             	sub    $0xc,%esp
  800482:	6a 00                	push   $0x0
  800484:	e8 4e 13 00 00       	call   8017d7 <sys_env_destroy>
  800489:	83 c4 10             	add    $0x10,%esp
}
  80048c:	90                   	nop
  80048d:	c9                   	leave  
  80048e:	c3                   	ret    

0080048f <exit>:

void
exit(void)
{
  80048f:	55                   	push   %ebp
  800490:	89 e5                	mov    %esp,%ebp
  800492:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800495:	e8 a3 13 00 00       	call   80183d <sys_env_exit>
}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004a3:	8d 45 10             	lea    0x10(%ebp),%eax
  8004a6:	83 c0 04             	add    $0x4,%eax
  8004a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004ac:	a1 18 31 80 00       	mov    0x803118,%eax
  8004b1:	85 c0                	test   %eax,%eax
  8004b3:	74 16                	je     8004cb <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004b5:	a1 18 31 80 00       	mov    0x803118,%eax
  8004ba:	83 ec 08             	sub    $0x8,%esp
  8004bd:	50                   	push   %eax
  8004be:	68 f4 23 80 00       	push   $0x8023f4
  8004c3:	e8 77 02 00 00       	call   80073f <cprintf>
  8004c8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004cb:	a1 00 30 80 00       	mov    0x803000,%eax
  8004d0:	ff 75 0c             	pushl  0xc(%ebp)
  8004d3:	ff 75 08             	pushl  0x8(%ebp)
  8004d6:	50                   	push   %eax
  8004d7:	68 f9 23 80 00       	push   $0x8023f9
  8004dc:	e8 5e 02 00 00       	call   80073f <cprintf>
  8004e1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e7:	83 ec 08             	sub    $0x8,%esp
  8004ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ed:	50                   	push   %eax
  8004ee:	e8 e1 01 00 00       	call   8006d4 <vcprintf>
  8004f3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004f6:	83 ec 08             	sub    $0x8,%esp
  8004f9:	6a 00                	push   $0x0
  8004fb:	68 15 24 80 00       	push   $0x802415
  800500:	e8 cf 01 00 00       	call   8006d4 <vcprintf>
  800505:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800508:	e8 82 ff ff ff       	call   80048f <exit>

	// should not return here
	while (1) ;
  80050d:	eb fe                	jmp    80050d <_panic+0x70>

0080050f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80050f:	55                   	push   %ebp
  800510:	89 e5                	mov    %esp,%ebp
  800512:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800515:	a1 20 30 80 00       	mov    0x803020,%eax
  80051a:	8b 50 74             	mov    0x74(%eax),%edx
  80051d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800520:	39 c2                	cmp    %eax,%edx
  800522:	74 14                	je     800538 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800524:	83 ec 04             	sub    $0x4,%esp
  800527:	68 18 24 80 00       	push   $0x802418
  80052c:	6a 26                	push   $0x26
  80052e:	68 64 24 80 00       	push   $0x802464
  800533:	e8 65 ff ff ff       	call   80049d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800538:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80053f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800546:	e9 b6 00 00 00       	jmp    800601 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80054b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80054e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800555:	8b 45 08             	mov    0x8(%ebp),%eax
  800558:	01 d0                	add    %edx,%eax
  80055a:	8b 00                	mov    (%eax),%eax
  80055c:	85 c0                	test   %eax,%eax
  80055e:	75 08                	jne    800568 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800560:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800563:	e9 96 00 00 00       	jmp    8005fe <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800568:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80056f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800576:	eb 5d                	jmp    8005d5 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800578:	a1 20 30 80 00       	mov    0x803020,%eax
  80057d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800583:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800586:	c1 e2 04             	shl    $0x4,%edx
  800589:	01 d0                	add    %edx,%eax
  80058b:	8a 40 04             	mov    0x4(%eax),%al
  80058e:	84 c0                	test   %al,%al
  800590:	75 40                	jne    8005d2 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800592:	a1 20 30 80 00       	mov    0x803020,%eax
  800597:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80059d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005a0:	c1 e2 04             	shl    $0x4,%edx
  8005a3:	01 d0                	add    %edx,%eax
  8005a5:	8b 00                	mov    (%eax),%eax
  8005a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005aa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005b2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005b7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005be:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c1:	01 c8                	add    %ecx,%eax
  8005c3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005c5:	39 c2                	cmp    %eax,%edx
  8005c7:	75 09                	jne    8005d2 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005c9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005d0:	eb 12                	jmp    8005e4 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005d2:	ff 45 e8             	incl   -0x18(%ebp)
  8005d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005da:	8b 50 74             	mov    0x74(%eax),%edx
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	39 c2                	cmp    %eax,%edx
  8005e2:	77 94                	ja     800578 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005e8:	75 14                	jne    8005fe <CheckWSWithoutLastIndex+0xef>
			panic(
  8005ea:	83 ec 04             	sub    $0x4,%esp
  8005ed:	68 70 24 80 00       	push   $0x802470
  8005f2:	6a 3a                	push   $0x3a
  8005f4:	68 64 24 80 00       	push   $0x802464
  8005f9:	e8 9f fe ff ff       	call   80049d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005fe:	ff 45 f0             	incl   -0x10(%ebp)
  800601:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800604:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800607:	0f 8c 3e ff ff ff    	jl     80054b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80060d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800614:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80061b:	eb 20                	jmp    80063d <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80061d:	a1 20 30 80 00       	mov    0x803020,%eax
  800622:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800628:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80062b:	c1 e2 04             	shl    $0x4,%edx
  80062e:	01 d0                	add    %edx,%eax
  800630:	8a 40 04             	mov    0x4(%eax),%al
  800633:	3c 01                	cmp    $0x1,%al
  800635:	75 03                	jne    80063a <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800637:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80063a:	ff 45 e0             	incl   -0x20(%ebp)
  80063d:	a1 20 30 80 00       	mov    0x803020,%eax
  800642:	8b 50 74             	mov    0x74(%eax),%edx
  800645:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800648:	39 c2                	cmp    %eax,%edx
  80064a:	77 d1                	ja     80061d <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80064c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80064f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800652:	74 14                	je     800668 <CheckWSWithoutLastIndex+0x159>
		panic(
  800654:	83 ec 04             	sub    $0x4,%esp
  800657:	68 c4 24 80 00       	push   $0x8024c4
  80065c:	6a 44                	push   $0x44
  80065e:	68 64 24 80 00       	push   $0x802464
  800663:	e8 35 fe ff ff       	call   80049d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800668:	90                   	nop
  800669:	c9                   	leave  
  80066a:	c3                   	ret    

0080066b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80066b:	55                   	push   %ebp
  80066c:	89 e5                	mov    %esp,%ebp
  80066e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800671:	8b 45 0c             	mov    0xc(%ebp),%eax
  800674:	8b 00                	mov    (%eax),%eax
  800676:	8d 48 01             	lea    0x1(%eax),%ecx
  800679:	8b 55 0c             	mov    0xc(%ebp),%edx
  80067c:	89 0a                	mov    %ecx,(%edx)
  80067e:	8b 55 08             	mov    0x8(%ebp),%edx
  800681:	88 d1                	mov    %dl,%cl
  800683:	8b 55 0c             	mov    0xc(%ebp),%edx
  800686:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800694:	75 2c                	jne    8006c2 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800696:	a0 24 30 80 00       	mov    0x803024,%al
  80069b:	0f b6 c0             	movzbl %al,%eax
  80069e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a1:	8b 12                	mov    (%edx),%edx
  8006a3:	89 d1                	mov    %edx,%ecx
  8006a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a8:	83 c2 08             	add    $0x8,%edx
  8006ab:	83 ec 04             	sub    $0x4,%esp
  8006ae:	50                   	push   %eax
  8006af:	51                   	push   %ecx
  8006b0:	52                   	push   %edx
  8006b1:	e8 df 10 00 00       	call   801795 <sys_cputs>
  8006b6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c5:	8b 40 04             	mov    0x4(%eax),%eax
  8006c8:	8d 50 01             	lea    0x1(%eax),%edx
  8006cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ce:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006d1:	90                   	nop
  8006d2:	c9                   	leave  
  8006d3:	c3                   	ret    

008006d4 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006d4:	55                   	push   %ebp
  8006d5:	89 e5                	mov    %esp,%ebp
  8006d7:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006dd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006e4:	00 00 00 
	b.cnt = 0;
  8006e7:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006ee:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006f1:	ff 75 0c             	pushl  0xc(%ebp)
  8006f4:	ff 75 08             	pushl  0x8(%ebp)
  8006f7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006fd:	50                   	push   %eax
  8006fe:	68 6b 06 80 00       	push   $0x80066b
  800703:	e8 11 02 00 00       	call   800919 <vprintfmt>
  800708:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80070b:	a0 24 30 80 00       	mov    0x803024,%al
  800710:	0f b6 c0             	movzbl %al,%eax
  800713:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800719:	83 ec 04             	sub    $0x4,%esp
  80071c:	50                   	push   %eax
  80071d:	52                   	push   %edx
  80071e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800724:	83 c0 08             	add    $0x8,%eax
  800727:	50                   	push   %eax
  800728:	e8 68 10 00 00       	call   801795 <sys_cputs>
  80072d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800730:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800737:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80073d:	c9                   	leave  
  80073e:	c3                   	ret    

0080073f <cprintf>:

int cprintf(const char *fmt, ...) {
  80073f:	55                   	push   %ebp
  800740:	89 e5                	mov    %esp,%ebp
  800742:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800745:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80074c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80074f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	ff 75 f4             	pushl  -0xc(%ebp)
  80075b:	50                   	push   %eax
  80075c:	e8 73 ff ff ff       	call   8006d4 <vcprintf>
  800761:	83 c4 10             	add    $0x10,%esp
  800764:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800767:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80076a:	c9                   	leave  
  80076b:	c3                   	ret    

0080076c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80076c:	55                   	push   %ebp
  80076d:	89 e5                	mov    %esp,%ebp
  80076f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800772:	e8 2f 12 00 00       	call   8019a6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800777:	8d 45 0c             	lea    0xc(%ebp),%eax
  80077a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 f4             	pushl  -0xc(%ebp)
  800786:	50                   	push   %eax
  800787:	e8 48 ff ff ff       	call   8006d4 <vcprintf>
  80078c:	83 c4 10             	add    $0x10,%esp
  80078f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800792:	e8 29 12 00 00       	call   8019c0 <sys_enable_interrupt>
	return cnt;
  800797:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80079a:	c9                   	leave  
  80079b:	c3                   	ret    

0080079c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80079c:	55                   	push   %ebp
  80079d:	89 e5                	mov    %esp,%ebp
  80079f:	53                   	push   %ebx
  8007a0:	83 ec 14             	sub    $0x14,%esp
  8007a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007af:	8b 45 18             	mov    0x18(%ebp),%eax
  8007b2:	ba 00 00 00 00       	mov    $0x0,%edx
  8007b7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007ba:	77 55                	ja     800811 <printnum+0x75>
  8007bc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007bf:	72 05                	jb     8007c6 <printnum+0x2a>
  8007c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007c4:	77 4b                	ja     800811 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007c6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007c9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007cc:	8b 45 18             	mov    0x18(%ebp),%eax
  8007cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d4:	52                   	push   %edx
  8007d5:	50                   	push   %eax
  8007d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d9:	ff 75 f0             	pushl  -0x10(%ebp)
  8007dc:	e8 9b 16 00 00       	call   801e7c <__udivdi3>
  8007e1:	83 c4 10             	add    $0x10,%esp
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	ff 75 20             	pushl  0x20(%ebp)
  8007ea:	53                   	push   %ebx
  8007eb:	ff 75 18             	pushl  0x18(%ebp)
  8007ee:	52                   	push   %edx
  8007ef:	50                   	push   %eax
  8007f0:	ff 75 0c             	pushl  0xc(%ebp)
  8007f3:	ff 75 08             	pushl  0x8(%ebp)
  8007f6:	e8 a1 ff ff ff       	call   80079c <printnum>
  8007fb:	83 c4 20             	add    $0x20,%esp
  8007fe:	eb 1a                	jmp    80081a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800800:	83 ec 08             	sub    $0x8,%esp
  800803:	ff 75 0c             	pushl  0xc(%ebp)
  800806:	ff 75 20             	pushl  0x20(%ebp)
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	ff d0                	call   *%eax
  80080e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800811:	ff 4d 1c             	decl   0x1c(%ebp)
  800814:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800818:	7f e6                	jg     800800 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80081a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80081d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800822:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800825:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800828:	53                   	push   %ebx
  800829:	51                   	push   %ecx
  80082a:	52                   	push   %edx
  80082b:	50                   	push   %eax
  80082c:	e8 5b 17 00 00       	call   801f8c <__umoddi3>
  800831:	83 c4 10             	add    $0x10,%esp
  800834:	05 34 27 80 00       	add    $0x802734,%eax
  800839:	8a 00                	mov    (%eax),%al
  80083b:	0f be c0             	movsbl %al,%eax
  80083e:	83 ec 08             	sub    $0x8,%esp
  800841:	ff 75 0c             	pushl  0xc(%ebp)
  800844:	50                   	push   %eax
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	ff d0                	call   *%eax
  80084a:	83 c4 10             	add    $0x10,%esp
}
  80084d:	90                   	nop
  80084e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800851:	c9                   	leave  
  800852:	c3                   	ret    

00800853 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800853:	55                   	push   %ebp
  800854:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800856:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80085a:	7e 1c                	jle    800878 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80085c:	8b 45 08             	mov    0x8(%ebp),%eax
  80085f:	8b 00                	mov    (%eax),%eax
  800861:	8d 50 08             	lea    0x8(%eax),%edx
  800864:	8b 45 08             	mov    0x8(%ebp),%eax
  800867:	89 10                	mov    %edx,(%eax)
  800869:	8b 45 08             	mov    0x8(%ebp),%eax
  80086c:	8b 00                	mov    (%eax),%eax
  80086e:	83 e8 08             	sub    $0x8,%eax
  800871:	8b 50 04             	mov    0x4(%eax),%edx
  800874:	8b 00                	mov    (%eax),%eax
  800876:	eb 40                	jmp    8008b8 <getuint+0x65>
	else if (lflag)
  800878:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80087c:	74 1e                	je     80089c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80087e:	8b 45 08             	mov    0x8(%ebp),%eax
  800881:	8b 00                	mov    (%eax),%eax
  800883:	8d 50 04             	lea    0x4(%eax),%edx
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	89 10                	mov    %edx,(%eax)
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	8b 00                	mov    (%eax),%eax
  800890:	83 e8 04             	sub    $0x4,%eax
  800893:	8b 00                	mov    (%eax),%eax
  800895:	ba 00 00 00 00       	mov    $0x0,%edx
  80089a:	eb 1c                	jmp    8008b8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80089c:	8b 45 08             	mov    0x8(%ebp),%eax
  80089f:	8b 00                	mov    (%eax),%eax
  8008a1:	8d 50 04             	lea    0x4(%eax),%edx
  8008a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a7:	89 10                	mov    %edx,(%eax)
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	83 e8 04             	sub    $0x4,%eax
  8008b1:	8b 00                	mov    (%eax),%eax
  8008b3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008b8:	5d                   	pop    %ebp
  8008b9:	c3                   	ret    

008008ba <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008ba:	55                   	push   %ebp
  8008bb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008bd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008c1:	7e 1c                	jle    8008df <getint+0x25>
		return va_arg(*ap, long long);
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	8d 50 08             	lea    0x8(%eax),%edx
  8008cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ce:	89 10                	mov    %edx,(%eax)
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	8b 00                	mov    (%eax),%eax
  8008d5:	83 e8 08             	sub    $0x8,%eax
  8008d8:	8b 50 04             	mov    0x4(%eax),%edx
  8008db:	8b 00                	mov    (%eax),%eax
  8008dd:	eb 38                	jmp    800917 <getint+0x5d>
	else if (lflag)
  8008df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e3:	74 1a                	je     8008ff <getint+0x45>
		return va_arg(*ap, long);
  8008e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e8:	8b 00                	mov    (%eax),%eax
  8008ea:	8d 50 04             	lea    0x4(%eax),%edx
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	89 10                	mov    %edx,(%eax)
  8008f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f5:	8b 00                	mov    (%eax),%eax
  8008f7:	83 e8 04             	sub    $0x4,%eax
  8008fa:	8b 00                	mov    (%eax),%eax
  8008fc:	99                   	cltd   
  8008fd:	eb 18                	jmp    800917 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	8b 00                	mov    (%eax),%eax
  800904:	8d 50 04             	lea    0x4(%eax),%edx
  800907:	8b 45 08             	mov    0x8(%ebp),%eax
  80090a:	89 10                	mov    %edx,(%eax)
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	83 e8 04             	sub    $0x4,%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	99                   	cltd   
}
  800917:	5d                   	pop    %ebp
  800918:	c3                   	ret    

00800919 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800919:	55                   	push   %ebp
  80091a:	89 e5                	mov    %esp,%ebp
  80091c:	56                   	push   %esi
  80091d:	53                   	push   %ebx
  80091e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800921:	eb 17                	jmp    80093a <vprintfmt+0x21>
			if (ch == '\0')
  800923:	85 db                	test   %ebx,%ebx
  800925:	0f 84 af 03 00 00    	je     800cda <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80092b:	83 ec 08             	sub    $0x8,%esp
  80092e:	ff 75 0c             	pushl  0xc(%ebp)
  800931:	53                   	push   %ebx
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	ff d0                	call   *%eax
  800937:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80093a:	8b 45 10             	mov    0x10(%ebp),%eax
  80093d:	8d 50 01             	lea    0x1(%eax),%edx
  800940:	89 55 10             	mov    %edx,0x10(%ebp)
  800943:	8a 00                	mov    (%eax),%al
  800945:	0f b6 d8             	movzbl %al,%ebx
  800948:	83 fb 25             	cmp    $0x25,%ebx
  80094b:	75 d6                	jne    800923 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80094d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800951:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800958:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80095f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800966:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80096d:	8b 45 10             	mov    0x10(%ebp),%eax
  800970:	8d 50 01             	lea    0x1(%eax),%edx
  800973:	89 55 10             	mov    %edx,0x10(%ebp)
  800976:	8a 00                	mov    (%eax),%al
  800978:	0f b6 d8             	movzbl %al,%ebx
  80097b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80097e:	83 f8 55             	cmp    $0x55,%eax
  800981:	0f 87 2b 03 00 00    	ja     800cb2 <vprintfmt+0x399>
  800987:	8b 04 85 58 27 80 00 	mov    0x802758(,%eax,4),%eax
  80098e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800990:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800994:	eb d7                	jmp    80096d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800996:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80099a:	eb d1                	jmp    80096d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80099c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009a3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009a6:	89 d0                	mov    %edx,%eax
  8009a8:	c1 e0 02             	shl    $0x2,%eax
  8009ab:	01 d0                	add    %edx,%eax
  8009ad:	01 c0                	add    %eax,%eax
  8009af:	01 d8                	add    %ebx,%eax
  8009b1:	83 e8 30             	sub    $0x30,%eax
  8009b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ba:	8a 00                	mov    (%eax),%al
  8009bc:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009bf:	83 fb 2f             	cmp    $0x2f,%ebx
  8009c2:	7e 3e                	jle    800a02 <vprintfmt+0xe9>
  8009c4:	83 fb 39             	cmp    $0x39,%ebx
  8009c7:	7f 39                	jg     800a02 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009c9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009cc:	eb d5                	jmp    8009a3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d1:	83 c0 04             	add    $0x4,%eax
  8009d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009da:	83 e8 04             	sub    $0x4,%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009e2:	eb 1f                	jmp    800a03 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009e4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e8:	79 83                	jns    80096d <vprintfmt+0x54>
				width = 0;
  8009ea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009f1:	e9 77 ff ff ff       	jmp    80096d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009f6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009fd:	e9 6b ff ff ff       	jmp    80096d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a02:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a03:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a07:	0f 89 60 ff ff ff    	jns    80096d <vprintfmt+0x54>
				width = precision, precision = -1;
  800a0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a13:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a1a:	e9 4e ff ff ff       	jmp    80096d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a1f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a22:	e9 46 ff ff ff       	jmp    80096d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	83 c0 04             	add    $0x4,%eax
  800a2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a30:	8b 45 14             	mov    0x14(%ebp),%eax
  800a33:	83 e8 04             	sub    $0x4,%eax
  800a36:	8b 00                	mov    (%eax),%eax
  800a38:	83 ec 08             	sub    $0x8,%esp
  800a3b:	ff 75 0c             	pushl  0xc(%ebp)
  800a3e:	50                   	push   %eax
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	ff d0                	call   *%eax
  800a44:	83 c4 10             	add    $0x10,%esp
			break;
  800a47:	e9 89 02 00 00       	jmp    800cd5 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4f:	83 c0 04             	add    $0x4,%eax
  800a52:	89 45 14             	mov    %eax,0x14(%ebp)
  800a55:	8b 45 14             	mov    0x14(%ebp),%eax
  800a58:	83 e8 04             	sub    $0x4,%eax
  800a5b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a5d:	85 db                	test   %ebx,%ebx
  800a5f:	79 02                	jns    800a63 <vprintfmt+0x14a>
				err = -err;
  800a61:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a63:	83 fb 64             	cmp    $0x64,%ebx
  800a66:	7f 0b                	jg     800a73 <vprintfmt+0x15a>
  800a68:	8b 34 9d a0 25 80 00 	mov    0x8025a0(,%ebx,4),%esi
  800a6f:	85 f6                	test   %esi,%esi
  800a71:	75 19                	jne    800a8c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a73:	53                   	push   %ebx
  800a74:	68 45 27 80 00       	push   $0x802745
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	ff 75 08             	pushl  0x8(%ebp)
  800a7f:	e8 5e 02 00 00       	call   800ce2 <printfmt>
  800a84:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a87:	e9 49 02 00 00       	jmp    800cd5 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a8c:	56                   	push   %esi
  800a8d:	68 4e 27 80 00       	push   $0x80274e
  800a92:	ff 75 0c             	pushl  0xc(%ebp)
  800a95:	ff 75 08             	pushl  0x8(%ebp)
  800a98:	e8 45 02 00 00       	call   800ce2 <printfmt>
  800a9d:	83 c4 10             	add    $0x10,%esp
			break;
  800aa0:	e9 30 02 00 00       	jmp    800cd5 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800aa5:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa8:	83 c0 04             	add    $0x4,%eax
  800aab:	89 45 14             	mov    %eax,0x14(%ebp)
  800aae:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab1:	83 e8 04             	sub    $0x4,%eax
  800ab4:	8b 30                	mov    (%eax),%esi
  800ab6:	85 f6                	test   %esi,%esi
  800ab8:	75 05                	jne    800abf <vprintfmt+0x1a6>
				p = "(null)";
  800aba:	be 51 27 80 00       	mov    $0x802751,%esi
			if (width > 0 && padc != '-')
  800abf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ac3:	7e 6d                	jle    800b32 <vprintfmt+0x219>
  800ac5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ac9:	74 67                	je     800b32 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800acb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ace:	83 ec 08             	sub    $0x8,%esp
  800ad1:	50                   	push   %eax
  800ad2:	56                   	push   %esi
  800ad3:	e8 0c 03 00 00       	call   800de4 <strnlen>
  800ad8:	83 c4 10             	add    $0x10,%esp
  800adb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ade:	eb 16                	jmp    800af6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ae0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	50                   	push   %eax
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	ff d0                	call   *%eax
  800af0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800af3:	ff 4d e4             	decl   -0x1c(%ebp)
  800af6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800afa:	7f e4                	jg     800ae0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800afc:	eb 34                	jmp    800b32 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800afe:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b02:	74 1c                	je     800b20 <vprintfmt+0x207>
  800b04:	83 fb 1f             	cmp    $0x1f,%ebx
  800b07:	7e 05                	jle    800b0e <vprintfmt+0x1f5>
  800b09:	83 fb 7e             	cmp    $0x7e,%ebx
  800b0c:	7e 12                	jle    800b20 <vprintfmt+0x207>
					putch('?', putdat);
  800b0e:	83 ec 08             	sub    $0x8,%esp
  800b11:	ff 75 0c             	pushl  0xc(%ebp)
  800b14:	6a 3f                	push   $0x3f
  800b16:	8b 45 08             	mov    0x8(%ebp),%eax
  800b19:	ff d0                	call   *%eax
  800b1b:	83 c4 10             	add    $0x10,%esp
  800b1e:	eb 0f                	jmp    800b2f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b20:	83 ec 08             	sub    $0x8,%esp
  800b23:	ff 75 0c             	pushl  0xc(%ebp)
  800b26:	53                   	push   %ebx
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	ff d0                	call   *%eax
  800b2c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b2f:	ff 4d e4             	decl   -0x1c(%ebp)
  800b32:	89 f0                	mov    %esi,%eax
  800b34:	8d 70 01             	lea    0x1(%eax),%esi
  800b37:	8a 00                	mov    (%eax),%al
  800b39:	0f be d8             	movsbl %al,%ebx
  800b3c:	85 db                	test   %ebx,%ebx
  800b3e:	74 24                	je     800b64 <vprintfmt+0x24b>
  800b40:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b44:	78 b8                	js     800afe <vprintfmt+0x1e5>
  800b46:	ff 4d e0             	decl   -0x20(%ebp)
  800b49:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b4d:	79 af                	jns    800afe <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b4f:	eb 13                	jmp    800b64 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b51:	83 ec 08             	sub    $0x8,%esp
  800b54:	ff 75 0c             	pushl  0xc(%ebp)
  800b57:	6a 20                	push   $0x20
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	ff d0                	call   *%eax
  800b5e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b61:	ff 4d e4             	decl   -0x1c(%ebp)
  800b64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b68:	7f e7                	jg     800b51 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b6a:	e9 66 01 00 00       	jmp    800cd5 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b6f:	83 ec 08             	sub    $0x8,%esp
  800b72:	ff 75 e8             	pushl  -0x18(%ebp)
  800b75:	8d 45 14             	lea    0x14(%ebp),%eax
  800b78:	50                   	push   %eax
  800b79:	e8 3c fd ff ff       	call   8008ba <getint>
  800b7e:	83 c4 10             	add    $0x10,%esp
  800b81:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b84:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b8d:	85 d2                	test   %edx,%edx
  800b8f:	79 23                	jns    800bb4 <vprintfmt+0x29b>
				putch('-', putdat);
  800b91:	83 ec 08             	sub    $0x8,%esp
  800b94:	ff 75 0c             	pushl  0xc(%ebp)
  800b97:	6a 2d                	push   $0x2d
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	ff d0                	call   *%eax
  800b9e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ba1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ba4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ba7:	f7 d8                	neg    %eax
  800ba9:	83 d2 00             	adc    $0x0,%edx
  800bac:	f7 da                	neg    %edx
  800bae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bb4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bbb:	e9 bc 00 00 00       	jmp    800c7c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bc0:	83 ec 08             	sub    $0x8,%esp
  800bc3:	ff 75 e8             	pushl  -0x18(%ebp)
  800bc6:	8d 45 14             	lea    0x14(%ebp),%eax
  800bc9:	50                   	push   %eax
  800bca:	e8 84 fc ff ff       	call   800853 <getuint>
  800bcf:	83 c4 10             	add    $0x10,%esp
  800bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bd8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bdf:	e9 98 00 00 00       	jmp    800c7c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800be4:	83 ec 08             	sub    $0x8,%esp
  800be7:	ff 75 0c             	pushl  0xc(%ebp)
  800bea:	6a 58                	push   $0x58
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	ff d0                	call   *%eax
  800bf1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bf4:	83 ec 08             	sub    $0x8,%esp
  800bf7:	ff 75 0c             	pushl  0xc(%ebp)
  800bfa:	6a 58                	push   $0x58
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	ff d0                	call   *%eax
  800c01:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 0c             	pushl  0xc(%ebp)
  800c0a:	6a 58                	push   $0x58
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	ff d0                	call   *%eax
  800c11:	83 c4 10             	add    $0x10,%esp
			break;
  800c14:	e9 bc 00 00 00       	jmp    800cd5 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c19:	83 ec 08             	sub    $0x8,%esp
  800c1c:	ff 75 0c             	pushl  0xc(%ebp)
  800c1f:	6a 30                	push   $0x30
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	ff d0                	call   *%eax
  800c26:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c29:	83 ec 08             	sub    $0x8,%esp
  800c2c:	ff 75 0c             	pushl  0xc(%ebp)
  800c2f:	6a 78                	push   $0x78
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	ff d0                	call   *%eax
  800c36:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c39:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3c:	83 c0 04             	add    $0x4,%eax
  800c3f:	89 45 14             	mov    %eax,0x14(%ebp)
  800c42:	8b 45 14             	mov    0x14(%ebp),%eax
  800c45:	83 e8 04             	sub    $0x4,%eax
  800c48:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c54:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c5b:	eb 1f                	jmp    800c7c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c5d:	83 ec 08             	sub    $0x8,%esp
  800c60:	ff 75 e8             	pushl  -0x18(%ebp)
  800c63:	8d 45 14             	lea    0x14(%ebp),%eax
  800c66:	50                   	push   %eax
  800c67:	e8 e7 fb ff ff       	call   800853 <getuint>
  800c6c:	83 c4 10             	add    $0x10,%esp
  800c6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c72:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c7c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c80:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c83:	83 ec 04             	sub    $0x4,%esp
  800c86:	52                   	push   %edx
  800c87:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c8a:	50                   	push   %eax
  800c8b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c8e:	ff 75 f0             	pushl  -0x10(%ebp)
  800c91:	ff 75 0c             	pushl  0xc(%ebp)
  800c94:	ff 75 08             	pushl  0x8(%ebp)
  800c97:	e8 00 fb ff ff       	call   80079c <printnum>
  800c9c:	83 c4 20             	add    $0x20,%esp
			break;
  800c9f:	eb 34                	jmp    800cd5 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ca1:	83 ec 08             	sub    $0x8,%esp
  800ca4:	ff 75 0c             	pushl  0xc(%ebp)
  800ca7:	53                   	push   %ebx
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	ff d0                	call   *%eax
  800cad:	83 c4 10             	add    $0x10,%esp
			break;
  800cb0:	eb 23                	jmp    800cd5 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cb2:	83 ec 08             	sub    $0x8,%esp
  800cb5:	ff 75 0c             	pushl  0xc(%ebp)
  800cb8:	6a 25                	push   $0x25
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	ff d0                	call   *%eax
  800cbf:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cc2:	ff 4d 10             	decl   0x10(%ebp)
  800cc5:	eb 03                	jmp    800cca <vprintfmt+0x3b1>
  800cc7:	ff 4d 10             	decl   0x10(%ebp)
  800cca:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccd:	48                   	dec    %eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	3c 25                	cmp    $0x25,%al
  800cd2:	75 f3                	jne    800cc7 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cd4:	90                   	nop
		}
	}
  800cd5:	e9 47 fc ff ff       	jmp    800921 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cda:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cdb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cde:	5b                   	pop    %ebx
  800cdf:	5e                   	pop    %esi
  800ce0:	5d                   	pop    %ebp
  800ce1:	c3                   	ret    

00800ce2 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ce2:	55                   	push   %ebp
  800ce3:	89 e5                	mov    %esp,%ebp
  800ce5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ce8:	8d 45 10             	lea    0x10(%ebp),%eax
  800ceb:	83 c0 04             	add    $0x4,%eax
  800cee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cf1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf7:	50                   	push   %eax
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	ff 75 08             	pushl  0x8(%ebp)
  800cfe:	e8 16 fc ff ff       	call   800919 <vprintfmt>
  800d03:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d06:	90                   	nop
  800d07:	c9                   	leave  
  800d08:	c3                   	ret    

00800d09 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0f:	8b 40 08             	mov    0x8(%eax),%eax
  800d12:	8d 50 01             	lea    0x1(%eax),%edx
  800d15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d18:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1e:	8b 10                	mov    (%eax),%edx
  800d20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d23:	8b 40 04             	mov    0x4(%eax),%eax
  800d26:	39 c2                	cmp    %eax,%edx
  800d28:	73 12                	jae    800d3c <sprintputch+0x33>
		*b->buf++ = ch;
  800d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2d:	8b 00                	mov    (%eax),%eax
  800d2f:	8d 48 01             	lea    0x1(%eax),%ecx
  800d32:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d35:	89 0a                	mov    %ecx,(%edx)
  800d37:	8b 55 08             	mov    0x8(%ebp),%edx
  800d3a:	88 10                	mov    %dl,(%eax)
}
  800d3c:	90                   	nop
  800d3d:	5d                   	pop    %ebp
  800d3e:	c3                   	ret    

00800d3f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d3f:	55                   	push   %ebp
  800d40:	89 e5                	mov    %esp,%ebp
  800d42:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	01 d0                	add    %edx,%eax
  800d56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d59:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d60:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d64:	74 06                	je     800d6c <vsnprintf+0x2d>
  800d66:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d6a:	7f 07                	jg     800d73 <vsnprintf+0x34>
		return -E_INVAL;
  800d6c:	b8 03 00 00 00       	mov    $0x3,%eax
  800d71:	eb 20                	jmp    800d93 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d73:	ff 75 14             	pushl  0x14(%ebp)
  800d76:	ff 75 10             	pushl  0x10(%ebp)
  800d79:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d7c:	50                   	push   %eax
  800d7d:	68 09 0d 80 00       	push   $0x800d09
  800d82:	e8 92 fb ff ff       	call   800919 <vprintfmt>
  800d87:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d8d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d90:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d93:	c9                   	leave  
  800d94:	c3                   	ret    

00800d95 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d95:	55                   	push   %ebp
  800d96:	89 e5                	mov    %esp,%ebp
  800d98:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d9b:	8d 45 10             	lea    0x10(%ebp),%eax
  800d9e:	83 c0 04             	add    $0x4,%eax
  800da1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800da4:	8b 45 10             	mov    0x10(%ebp),%eax
  800da7:	ff 75 f4             	pushl  -0xc(%ebp)
  800daa:	50                   	push   %eax
  800dab:	ff 75 0c             	pushl  0xc(%ebp)
  800dae:	ff 75 08             	pushl  0x8(%ebp)
  800db1:	e8 89 ff ff ff       	call   800d3f <vsnprintf>
  800db6:	83 c4 10             	add    $0x10,%esp
  800db9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dbf:	c9                   	leave  
  800dc0:	c3                   	ret    

00800dc1 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dc1:	55                   	push   %ebp
  800dc2:	89 e5                	mov    %esp,%ebp
  800dc4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800dc7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dce:	eb 06                	jmp    800dd6 <strlen+0x15>
		n++;
  800dd0:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dd3:	ff 45 08             	incl   0x8(%ebp)
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	84 c0                	test   %al,%al
  800ddd:	75 f1                	jne    800dd0 <strlen+0xf>
		n++;
	return n;
  800ddf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de2:	c9                   	leave  
  800de3:	c3                   	ret    

00800de4 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df1:	eb 09                	jmp    800dfc <strnlen+0x18>
		n++;
  800df3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800df6:	ff 45 08             	incl   0x8(%ebp)
  800df9:	ff 4d 0c             	decl   0xc(%ebp)
  800dfc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e00:	74 09                	je     800e0b <strnlen+0x27>
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	8a 00                	mov    (%eax),%al
  800e07:	84 c0                	test   %al,%al
  800e09:	75 e8                	jne    800df3 <strnlen+0xf>
		n++;
	return n;
  800e0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e0e:	c9                   	leave  
  800e0f:	c3                   	ret    

00800e10 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e10:	55                   	push   %ebp
  800e11:	89 e5                	mov    %esp,%ebp
  800e13:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
  800e19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e1c:	90                   	nop
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8d 50 01             	lea    0x1(%eax),%edx
  800e23:	89 55 08             	mov    %edx,0x8(%ebp)
  800e26:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e29:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e2c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e2f:	8a 12                	mov    (%edx),%dl
  800e31:	88 10                	mov    %dl,(%eax)
  800e33:	8a 00                	mov    (%eax),%al
  800e35:	84 c0                	test   %al,%al
  800e37:	75 e4                	jne    800e1d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e39:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e3c:	c9                   	leave  
  800e3d:	c3                   	ret    

00800e3e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e3e:	55                   	push   %ebp
  800e3f:	89 e5                	mov    %esp,%ebp
  800e41:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e4a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e51:	eb 1f                	jmp    800e72 <strncpy+0x34>
		*dst++ = *src;
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	8d 50 01             	lea    0x1(%eax),%edx
  800e59:	89 55 08             	mov    %edx,0x8(%ebp)
  800e5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5f:	8a 12                	mov    (%edx),%dl
  800e61:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	84 c0                	test   %al,%al
  800e6a:	74 03                	je     800e6f <strncpy+0x31>
			src++;
  800e6c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e6f:	ff 45 fc             	incl   -0x4(%ebp)
  800e72:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e75:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e78:	72 d9                	jb     800e53 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e7d:	c9                   	leave  
  800e7e:	c3                   	ret    

00800e7f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e7f:	55                   	push   %ebp
  800e80:	89 e5                	mov    %esp,%ebp
  800e82:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e8f:	74 30                	je     800ec1 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e91:	eb 16                	jmp    800ea9 <strlcpy+0x2a>
			*dst++ = *src++;
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	8d 50 01             	lea    0x1(%eax),%edx
  800e99:	89 55 08             	mov    %edx,0x8(%ebp)
  800e9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ea2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ea5:	8a 12                	mov    (%edx),%dl
  800ea7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ea9:	ff 4d 10             	decl   0x10(%ebp)
  800eac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb0:	74 09                	je     800ebb <strlcpy+0x3c>
  800eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb5:	8a 00                	mov    (%eax),%al
  800eb7:	84 c0                	test   %al,%al
  800eb9:	75 d8                	jne    800e93 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ec1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec7:	29 c2                	sub    %eax,%edx
  800ec9:	89 d0                	mov    %edx,%eax
}
  800ecb:	c9                   	leave  
  800ecc:	c3                   	ret    

00800ecd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ecd:	55                   	push   %ebp
  800ece:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ed0:	eb 06                	jmp    800ed8 <strcmp+0xb>
		p++, q++;
  800ed2:	ff 45 08             	incl   0x8(%ebp)
  800ed5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	84 c0                	test   %al,%al
  800edf:	74 0e                	je     800eef <strcmp+0x22>
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 10                	mov    (%eax),%dl
  800ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee9:	8a 00                	mov    (%eax),%al
  800eeb:	38 c2                	cmp    %al,%dl
  800eed:	74 e3                	je     800ed2 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	8a 00                	mov    (%eax),%al
  800ef4:	0f b6 d0             	movzbl %al,%edx
  800ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	0f b6 c0             	movzbl %al,%eax
  800eff:	29 c2                	sub    %eax,%edx
  800f01:	89 d0                	mov    %edx,%eax
}
  800f03:	5d                   	pop    %ebp
  800f04:	c3                   	ret    

00800f05 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f05:	55                   	push   %ebp
  800f06:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f08:	eb 09                	jmp    800f13 <strncmp+0xe>
		n--, p++, q++;
  800f0a:	ff 4d 10             	decl   0x10(%ebp)
  800f0d:	ff 45 08             	incl   0x8(%ebp)
  800f10:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f13:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f17:	74 17                	je     800f30 <strncmp+0x2b>
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	84 c0                	test   %al,%al
  800f20:	74 0e                	je     800f30 <strncmp+0x2b>
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	8a 10                	mov    (%eax),%dl
  800f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2a:	8a 00                	mov    (%eax),%al
  800f2c:	38 c2                	cmp    %al,%dl
  800f2e:	74 da                	je     800f0a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f30:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f34:	75 07                	jne    800f3d <strncmp+0x38>
		return 0;
  800f36:	b8 00 00 00 00       	mov    $0x0,%eax
  800f3b:	eb 14                	jmp    800f51 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	0f b6 d0             	movzbl %al,%edx
  800f45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	0f b6 c0             	movzbl %al,%eax
  800f4d:	29 c2                	sub    %eax,%edx
  800f4f:	89 d0                	mov    %edx,%eax
}
  800f51:	5d                   	pop    %ebp
  800f52:	c3                   	ret    

00800f53 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f53:	55                   	push   %ebp
  800f54:	89 e5                	mov    %esp,%ebp
  800f56:	83 ec 04             	sub    $0x4,%esp
  800f59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f5f:	eb 12                	jmp    800f73 <strchr+0x20>
		if (*s == c)
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f69:	75 05                	jne    800f70 <strchr+0x1d>
			return (char *) s;
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	eb 11                	jmp    800f81 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f70:	ff 45 08             	incl   0x8(%ebp)
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	84 c0                	test   %al,%al
  800f7a:	75 e5                	jne    800f61 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f7c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f81:	c9                   	leave  
  800f82:	c3                   	ret    

00800f83 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
  800f86:	83 ec 04             	sub    $0x4,%esp
  800f89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f8f:	eb 0d                	jmp    800f9e <strfind+0x1b>
		if (*s == c)
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	8a 00                	mov    (%eax),%al
  800f96:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f99:	74 0e                	je     800fa9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f9b:	ff 45 08             	incl   0x8(%ebp)
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	8a 00                	mov    (%eax),%al
  800fa3:	84 c0                	test   %al,%al
  800fa5:	75 ea                	jne    800f91 <strfind+0xe>
  800fa7:	eb 01                	jmp    800faa <strfind+0x27>
		if (*s == c)
			break;
  800fa9:	90                   	nop
	return (char *) s;
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fad:	c9                   	leave  
  800fae:	c3                   	ret    

00800faf <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800faf:	55                   	push   %ebp
  800fb0:	89 e5                	mov    %esp,%ebp
  800fb2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fc1:	eb 0e                	jmp    800fd1 <memset+0x22>
		*p++ = c;
  800fc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc6:	8d 50 01             	lea    0x1(%eax),%edx
  800fc9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fcc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fcf:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fd1:	ff 4d f8             	decl   -0x8(%ebp)
  800fd4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fd8:	79 e9                	jns    800fc3 <memset+0x14>
		*p++ = c;

	return v;
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fdd:	c9                   	leave  
  800fde:	c3                   	ret    

00800fdf <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
  800fe2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ff1:	eb 16                	jmp    801009 <memcpy+0x2a>
		*d++ = *s++;
  800ff3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff6:	8d 50 01             	lea    0x1(%eax),%edx
  800ff9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ffc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fff:	8d 4a 01             	lea    0x1(%edx),%ecx
  801002:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801005:	8a 12                	mov    (%edx),%dl
  801007:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801009:	8b 45 10             	mov    0x10(%ebp),%eax
  80100c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100f:	89 55 10             	mov    %edx,0x10(%ebp)
  801012:	85 c0                	test   %eax,%eax
  801014:	75 dd                	jne    800ff3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801019:	c9                   	leave  
  80101a:	c3                   	ret    

0080101b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
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
	if (s < d && s + n > d) {
  80102d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801030:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801033:	73 50                	jae    801085 <memmove+0x6a>
  801035:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801038:	8b 45 10             	mov    0x10(%ebp),%eax
  80103b:	01 d0                	add    %edx,%eax
  80103d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801040:	76 43                	jbe    801085 <memmove+0x6a>
		s += n;
  801042:	8b 45 10             	mov    0x10(%ebp),%eax
  801045:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801048:	8b 45 10             	mov    0x10(%ebp),%eax
  80104b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80104e:	eb 10                	jmp    801060 <memmove+0x45>
			*--d = *--s;
  801050:	ff 4d f8             	decl   -0x8(%ebp)
  801053:	ff 4d fc             	decl   -0x4(%ebp)
  801056:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801059:	8a 10                	mov    (%eax),%dl
  80105b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801060:	8b 45 10             	mov    0x10(%ebp),%eax
  801063:	8d 50 ff             	lea    -0x1(%eax),%edx
  801066:	89 55 10             	mov    %edx,0x10(%ebp)
  801069:	85 c0                	test   %eax,%eax
  80106b:	75 e3                	jne    801050 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80106d:	eb 23                	jmp    801092 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80106f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801072:	8d 50 01             	lea    0x1(%eax),%edx
  801075:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801078:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80107b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80107e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801081:	8a 12                	mov    (%edx),%dl
  801083:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801085:	8b 45 10             	mov    0x10(%ebp),%eax
  801088:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108b:	89 55 10             	mov    %edx,0x10(%ebp)
  80108e:	85 c0                	test   %eax,%eax
  801090:	75 dd                	jne    80106f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
  80109a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010a9:	eb 2a                	jmp    8010d5 <memcmp+0x3e>
		if (*s1 != *s2)
  8010ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ae:	8a 10                	mov    (%eax),%dl
  8010b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b3:	8a 00                	mov    (%eax),%al
  8010b5:	38 c2                	cmp    %al,%dl
  8010b7:	74 16                	je     8010cf <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bc:	8a 00                	mov    (%eax),%al
  8010be:	0f b6 d0             	movzbl %al,%edx
  8010c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c4:	8a 00                	mov    (%eax),%al
  8010c6:	0f b6 c0             	movzbl %al,%eax
  8010c9:	29 c2                	sub    %eax,%edx
  8010cb:	89 d0                	mov    %edx,%eax
  8010cd:	eb 18                	jmp    8010e7 <memcmp+0x50>
		s1++, s2++;
  8010cf:	ff 45 fc             	incl   -0x4(%ebp)
  8010d2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010db:	89 55 10             	mov    %edx,0x10(%ebp)
  8010de:	85 c0                	test   %eax,%eax
  8010e0:	75 c9                	jne    8010ab <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010e7:	c9                   	leave  
  8010e8:	c3                   	ret    

008010e9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010e9:	55                   	push   %ebp
  8010ea:	89 e5                	mov    %esp,%ebp
  8010ec:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f5:	01 d0                	add    %edx,%eax
  8010f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010fa:	eb 15                	jmp    801111 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	8a 00                	mov    (%eax),%al
  801101:	0f b6 d0             	movzbl %al,%edx
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	0f b6 c0             	movzbl %al,%eax
  80110a:	39 c2                	cmp    %eax,%edx
  80110c:	74 0d                	je     80111b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80110e:	ff 45 08             	incl   0x8(%ebp)
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801117:	72 e3                	jb     8010fc <memfind+0x13>
  801119:	eb 01                	jmp    80111c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80111b:	90                   	nop
	return (void *) s;
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111f:	c9                   	leave  
  801120:	c3                   	ret    

00801121 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801121:	55                   	push   %ebp
  801122:	89 e5                	mov    %esp,%ebp
  801124:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80112e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801135:	eb 03                	jmp    80113a <strtol+0x19>
		s++;
  801137:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80113a:	8b 45 08             	mov    0x8(%ebp),%eax
  80113d:	8a 00                	mov    (%eax),%al
  80113f:	3c 20                	cmp    $0x20,%al
  801141:	74 f4                	je     801137 <strtol+0x16>
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	3c 09                	cmp    $0x9,%al
  80114a:	74 eb                	je     801137 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
  80114f:	8a 00                	mov    (%eax),%al
  801151:	3c 2b                	cmp    $0x2b,%al
  801153:	75 05                	jne    80115a <strtol+0x39>
		s++;
  801155:	ff 45 08             	incl   0x8(%ebp)
  801158:	eb 13                	jmp    80116d <strtol+0x4c>
	else if (*s == '-')
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	3c 2d                	cmp    $0x2d,%al
  801161:	75 0a                	jne    80116d <strtol+0x4c>
		s++, neg = 1;
  801163:	ff 45 08             	incl   0x8(%ebp)
  801166:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80116d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801171:	74 06                	je     801179 <strtol+0x58>
  801173:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801177:	75 20                	jne    801199 <strtol+0x78>
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	3c 30                	cmp    $0x30,%al
  801180:	75 17                	jne    801199 <strtol+0x78>
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	40                   	inc    %eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	3c 78                	cmp    $0x78,%al
  80118a:	75 0d                	jne    801199 <strtol+0x78>
		s += 2, base = 16;
  80118c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801190:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801197:	eb 28                	jmp    8011c1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801199:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80119d:	75 15                	jne    8011b4 <strtol+0x93>
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	8a 00                	mov    (%eax),%al
  8011a4:	3c 30                	cmp    $0x30,%al
  8011a6:	75 0c                	jne    8011b4 <strtol+0x93>
		s++, base = 8;
  8011a8:	ff 45 08             	incl   0x8(%ebp)
  8011ab:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011b2:	eb 0d                	jmp    8011c1 <strtol+0xa0>
	else if (base == 0)
  8011b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b8:	75 07                	jne    8011c1 <strtol+0xa0>
		base = 10;
  8011ba:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	3c 2f                	cmp    $0x2f,%al
  8011c8:	7e 19                	jle    8011e3 <strtol+0xc2>
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	3c 39                	cmp    $0x39,%al
  8011d1:	7f 10                	jg     8011e3 <strtol+0xc2>
			dig = *s - '0';
  8011d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d6:	8a 00                	mov    (%eax),%al
  8011d8:	0f be c0             	movsbl %al,%eax
  8011db:	83 e8 30             	sub    $0x30,%eax
  8011de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011e1:	eb 42                	jmp    801225 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8a 00                	mov    (%eax),%al
  8011e8:	3c 60                	cmp    $0x60,%al
  8011ea:	7e 19                	jle    801205 <strtol+0xe4>
  8011ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ef:	8a 00                	mov    (%eax),%al
  8011f1:	3c 7a                	cmp    $0x7a,%al
  8011f3:	7f 10                	jg     801205 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	0f be c0             	movsbl %al,%eax
  8011fd:	83 e8 57             	sub    $0x57,%eax
  801200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801203:	eb 20                	jmp    801225 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8a 00                	mov    (%eax),%al
  80120a:	3c 40                	cmp    $0x40,%al
  80120c:	7e 39                	jle    801247 <strtol+0x126>
  80120e:	8b 45 08             	mov    0x8(%ebp),%eax
  801211:	8a 00                	mov    (%eax),%al
  801213:	3c 5a                	cmp    $0x5a,%al
  801215:	7f 30                	jg     801247 <strtol+0x126>
			dig = *s - 'A' + 10;
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	8a 00                	mov    (%eax),%al
  80121c:	0f be c0             	movsbl %al,%eax
  80121f:	83 e8 37             	sub    $0x37,%eax
  801222:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801225:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801228:	3b 45 10             	cmp    0x10(%ebp),%eax
  80122b:	7d 19                	jge    801246 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80122d:	ff 45 08             	incl   0x8(%ebp)
  801230:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801233:	0f af 45 10          	imul   0x10(%ebp),%eax
  801237:	89 c2                	mov    %eax,%edx
  801239:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123c:	01 d0                	add    %edx,%eax
  80123e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801241:	e9 7b ff ff ff       	jmp    8011c1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801246:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801247:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80124b:	74 08                	je     801255 <strtol+0x134>
		*endptr = (char *) s;
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	8b 55 08             	mov    0x8(%ebp),%edx
  801253:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801255:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801259:	74 07                	je     801262 <strtol+0x141>
  80125b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125e:	f7 d8                	neg    %eax
  801260:	eb 03                	jmp    801265 <strtol+0x144>
  801262:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801265:	c9                   	leave  
  801266:	c3                   	ret    

00801267 <ltostr>:

void
ltostr(long value, char *str)
{
  801267:	55                   	push   %ebp
  801268:	89 e5                	mov    %esp,%ebp
  80126a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80126d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801274:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80127b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80127f:	79 13                	jns    801294 <ltostr+0x2d>
	{
		neg = 1;
  801281:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80128e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801291:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80129c:	99                   	cltd   
  80129d:	f7 f9                	idiv   %ecx
  80129f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a5:	8d 50 01             	lea    0x1(%eax),%edx
  8012a8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012ab:	89 c2                	mov    %eax,%edx
  8012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b0:	01 d0                	add    %edx,%eax
  8012b2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b5:	83 c2 30             	add    $0x30,%edx
  8012b8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012bd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012c2:	f7 e9                	imul   %ecx
  8012c4:	c1 fa 02             	sar    $0x2,%edx
  8012c7:	89 c8                	mov    %ecx,%eax
  8012c9:	c1 f8 1f             	sar    $0x1f,%eax
  8012cc:	29 c2                	sub    %eax,%edx
  8012ce:	89 d0                	mov    %edx,%eax
  8012d0:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012d6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012db:	f7 e9                	imul   %ecx
  8012dd:	c1 fa 02             	sar    $0x2,%edx
  8012e0:	89 c8                	mov    %ecx,%eax
  8012e2:	c1 f8 1f             	sar    $0x1f,%eax
  8012e5:	29 c2                	sub    %eax,%edx
  8012e7:	89 d0                	mov    %edx,%eax
  8012e9:	c1 e0 02             	shl    $0x2,%eax
  8012ec:	01 d0                	add    %edx,%eax
  8012ee:	01 c0                	add    %eax,%eax
  8012f0:	29 c1                	sub    %eax,%ecx
  8012f2:	89 ca                	mov    %ecx,%edx
  8012f4:	85 d2                	test   %edx,%edx
  8012f6:	75 9c                	jne    801294 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801302:	48                   	dec    %eax
  801303:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801306:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80130a:	74 3d                	je     801349 <ltostr+0xe2>
		start = 1 ;
  80130c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801313:	eb 34                	jmp    801349 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801315:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801318:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131b:	01 d0                	add    %edx,%eax
  80131d:	8a 00                	mov    (%eax),%al
  80131f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801322:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	01 c2                	add    %eax,%edx
  80132a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80132d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801330:	01 c8                	add    %ecx,%eax
  801332:	8a 00                	mov    (%eax),%al
  801334:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801336:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801339:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133c:	01 c2                	add    %eax,%edx
  80133e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801341:	88 02                	mov    %al,(%edx)
		start++ ;
  801343:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801346:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801349:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80134c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80134f:	7c c4                	jl     801315 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801351:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801354:	8b 45 0c             	mov    0xc(%ebp),%eax
  801357:	01 d0                	add    %edx,%eax
  801359:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80135c:	90                   	nop
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
  801362:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801365:	ff 75 08             	pushl  0x8(%ebp)
  801368:	e8 54 fa ff ff       	call   800dc1 <strlen>
  80136d:	83 c4 04             	add    $0x4,%esp
  801370:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801373:	ff 75 0c             	pushl  0xc(%ebp)
  801376:	e8 46 fa ff ff       	call   800dc1 <strlen>
  80137b:	83 c4 04             	add    $0x4,%esp
  80137e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801381:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80138f:	eb 17                	jmp    8013a8 <strcconcat+0x49>
		final[s] = str1[s] ;
  801391:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801394:	8b 45 10             	mov    0x10(%ebp),%eax
  801397:	01 c2                	add    %eax,%edx
  801399:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	01 c8                	add    %ecx,%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013a5:	ff 45 fc             	incl   -0x4(%ebp)
  8013a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013ae:	7c e1                	jl     801391 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013be:	eb 1f                	jmp    8013df <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c3:	8d 50 01             	lea    0x1(%eax),%edx
  8013c6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013c9:	89 c2                	mov    %eax,%edx
  8013cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ce:	01 c2                	add    %eax,%edx
  8013d0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d6:	01 c8                	add    %ecx,%eax
  8013d8:	8a 00                	mov    (%eax),%al
  8013da:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013dc:	ff 45 f8             	incl   -0x8(%ebp)
  8013df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013e5:	7c d9                	jl     8013c0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ed:	01 d0                	add    %edx,%eax
  8013ef:	c6 00 00             	movb   $0x0,(%eax)
}
  8013f2:	90                   	nop
  8013f3:	c9                   	leave  
  8013f4:	c3                   	ret    

008013f5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013f5:	55                   	push   %ebp
  8013f6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801401:	8b 45 14             	mov    0x14(%ebp),%eax
  801404:	8b 00                	mov    (%eax),%eax
  801406:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80140d:	8b 45 10             	mov    0x10(%ebp),%eax
  801410:	01 d0                	add    %edx,%eax
  801412:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801418:	eb 0c                	jmp    801426 <strsplit+0x31>
			*string++ = 0;
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8d 50 01             	lea    0x1(%eax),%edx
  801420:	89 55 08             	mov    %edx,0x8(%ebp)
  801423:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	8a 00                	mov    (%eax),%al
  80142b:	84 c0                	test   %al,%al
  80142d:	74 18                	je     801447 <strsplit+0x52>
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	0f be c0             	movsbl %al,%eax
  801437:	50                   	push   %eax
  801438:	ff 75 0c             	pushl  0xc(%ebp)
  80143b:	e8 13 fb ff ff       	call   800f53 <strchr>
  801440:	83 c4 08             	add    $0x8,%esp
  801443:	85 c0                	test   %eax,%eax
  801445:	75 d3                	jne    80141a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	84 c0                	test   %al,%al
  80144e:	74 5a                	je     8014aa <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801450:	8b 45 14             	mov    0x14(%ebp),%eax
  801453:	8b 00                	mov    (%eax),%eax
  801455:	83 f8 0f             	cmp    $0xf,%eax
  801458:	75 07                	jne    801461 <strsplit+0x6c>
		{
			return 0;
  80145a:	b8 00 00 00 00       	mov    $0x0,%eax
  80145f:	eb 66                	jmp    8014c7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801461:	8b 45 14             	mov    0x14(%ebp),%eax
  801464:	8b 00                	mov    (%eax),%eax
  801466:	8d 48 01             	lea    0x1(%eax),%ecx
  801469:	8b 55 14             	mov    0x14(%ebp),%edx
  80146c:	89 0a                	mov    %ecx,(%edx)
  80146e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801475:	8b 45 10             	mov    0x10(%ebp),%eax
  801478:	01 c2                	add    %eax,%edx
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80147f:	eb 03                	jmp    801484 <strsplit+0x8f>
			string++;
  801481:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	8a 00                	mov    (%eax),%al
  801489:	84 c0                	test   %al,%al
  80148b:	74 8b                	je     801418 <strsplit+0x23>
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	8a 00                	mov    (%eax),%al
  801492:	0f be c0             	movsbl %al,%eax
  801495:	50                   	push   %eax
  801496:	ff 75 0c             	pushl  0xc(%ebp)
  801499:	e8 b5 fa ff ff       	call   800f53 <strchr>
  80149e:	83 c4 08             	add    $0x8,%esp
  8014a1:	85 c0                	test   %eax,%eax
  8014a3:	74 dc                	je     801481 <strsplit+0x8c>
			string++;
	}
  8014a5:	e9 6e ff ff ff       	jmp    801418 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014aa:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ae:	8b 00                	mov    (%eax),%eax
  8014b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ba:	01 d0                	add    %edx,%eax
  8014bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014c2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014c7:	c9                   	leave  
  8014c8:	c3                   	ret    

008014c9 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  8014c9:	55                   	push   %ebp
  8014ca:	89 e5                	mov    %esp,%ebp
  8014cc:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d2:	c1 e8 0c             	shr    $0xc,%eax
  8014d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	25 ff 0f 00 00       	and    $0xfff,%eax
  8014e0:	85 c0                	test   %eax,%eax
  8014e2:	74 03                	je     8014e7 <malloc+0x1e>
			num++;
  8014e4:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8014e7:	a1 04 30 80 00       	mov    0x803004,%eax
  8014ec:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8014f1:	75 64                	jne    801557 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8014f3:	83 ec 08             	sub    $0x8,%esp
  8014f6:	ff 75 08             	pushl  0x8(%ebp)
  8014f9:	68 00 00 00 80       	push   $0x80000000
  8014fe:	e8 3a 04 00 00       	call   80193d <sys_allocateMem>
  801503:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801506:	a1 04 30 80 00       	mov    0x803004,%eax
  80150b:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80150e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801511:	c1 e0 0c             	shl    $0xc,%eax
  801514:	89 c2                	mov    %eax,%edx
  801516:	a1 04 30 80 00       	mov    0x803004,%eax
  80151b:	01 d0                	add    %edx,%eax
  80151d:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  801522:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801527:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80152d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801534:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801539:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801540:	01 00 00 00 
			sizeofarray++;
  801544:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801549:	40                   	inc    %eax
  80154a:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80154f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801552:	e9 26 01 00 00       	jmp    80167d <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  801557:	a1 28 30 80 00       	mov    0x803028,%eax
  80155c:	85 c0                	test   %eax,%eax
  80155e:	75 62                	jne    8015c2 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  801560:	a1 04 30 80 00       	mov    0x803004,%eax
  801565:	83 ec 08             	sub    $0x8,%esp
  801568:	ff 75 08             	pushl  0x8(%ebp)
  80156b:	50                   	push   %eax
  80156c:	e8 cc 03 00 00       	call   80193d <sys_allocateMem>
  801571:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801574:	a1 04 30 80 00       	mov    0x803004,%eax
  801579:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80157c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80157f:	c1 e0 0c             	shl    $0xc,%eax
  801582:	89 c2                	mov    %eax,%edx
  801584:	a1 04 30 80 00       	mov    0x803004,%eax
  801589:	01 d0                	add    %edx,%eax
  80158b:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  801590:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801595:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801598:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80159f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015a4:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8015ab:	01 00 00 00 
				sizeofarray++;
  8015af:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015b4:	40                   	inc    %eax
  8015b5:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8015ba:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8015bd:	e9 bb 00 00 00       	jmp    80167d <malloc+0x1b4>
			}
			else{
				int count=0;
  8015c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8015c9:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8015d0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8015d7:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8015de:	eb 7c                	jmp    80165c <malloc+0x193>
				{
					uint32 *pg=NULL;
  8015e0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8015e7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8015ee:	eb 1a                	jmp    80160a <malloc+0x141>
					{
						if(addresses[j]==i)
  8015f0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015f3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015fa:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8015fd:	75 08                	jne    801607 <malloc+0x13e>
						{
							index=j;
  8015ff:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801602:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801605:	eb 0d                	jmp    801614 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801607:	ff 45 dc             	incl   -0x24(%ebp)
  80160a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80160f:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801612:	7c dc                	jl     8015f0 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  801614:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801618:	75 05                	jne    80161f <malloc+0x156>
					{
						count++;
  80161a:	ff 45 f0             	incl   -0x10(%ebp)
  80161d:	eb 36                	jmp    801655 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  80161f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801622:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801629:	85 c0                	test   %eax,%eax
  80162b:	75 05                	jne    801632 <malloc+0x169>
						{
							count++;
  80162d:	ff 45 f0             	incl   -0x10(%ebp)
  801630:	eb 23                	jmp    801655 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  801632:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801635:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801638:	7d 14                	jge    80164e <malloc+0x185>
  80163a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80163d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801640:	7c 0c                	jl     80164e <malloc+0x185>
							{
								min=count;
  801642:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801645:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801648:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80164b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80164e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801655:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80165c:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801663:	0f 86 77 ff ff ff    	jbe    8015e0 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  801669:	83 ec 08             	sub    $0x8,%esp
  80166c:	ff 75 08             	pushl  0x8(%ebp)
  80166f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801672:	e8 c6 02 00 00       	call   80193d <sys_allocateMem>
  801677:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  80167a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
  801682:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801685:	83 ec 04             	sub    $0x4,%esp
  801688:	68 b0 28 80 00       	push   $0x8028b0
  80168d:	6a 7b                	push   $0x7b
  80168f:	68 d3 28 80 00       	push   $0x8028d3
  801694:	e8 04 ee ff ff       	call   80049d <_panic>

00801699 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
  80169c:	83 ec 18             	sub    $0x18,%esp
  80169f:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a2:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8016a5:	83 ec 04             	sub    $0x4,%esp
  8016a8:	68 e0 28 80 00       	push   $0x8028e0
  8016ad:	68 88 00 00 00       	push   $0x88
  8016b2:	68 d3 28 80 00       	push   $0x8028d3
  8016b7:	e8 e1 ed ff ff       	call   80049d <_panic>

008016bc <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
  8016bf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016c2:	83 ec 04             	sub    $0x4,%esp
  8016c5:	68 e0 28 80 00       	push   $0x8028e0
  8016ca:	68 8e 00 00 00       	push   $0x8e
  8016cf:	68 d3 28 80 00       	push   $0x8028d3
  8016d4:	e8 c4 ed ff ff       	call   80049d <_panic>

008016d9 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
  8016dc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016df:	83 ec 04             	sub    $0x4,%esp
  8016e2:	68 e0 28 80 00       	push   $0x8028e0
  8016e7:	68 94 00 00 00       	push   $0x94
  8016ec:	68 d3 28 80 00       	push   $0x8028d3
  8016f1:	e8 a7 ed ff ff       	call   80049d <_panic>

008016f6 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
  8016f9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016fc:	83 ec 04             	sub    $0x4,%esp
  8016ff:	68 e0 28 80 00       	push   $0x8028e0
  801704:	68 99 00 00 00       	push   $0x99
  801709:	68 d3 28 80 00       	push   $0x8028d3
  80170e:	e8 8a ed ff ff       	call   80049d <_panic>

00801713 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
  801716:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801719:	83 ec 04             	sub    $0x4,%esp
  80171c:	68 e0 28 80 00       	push   $0x8028e0
  801721:	68 9f 00 00 00       	push   $0x9f
  801726:	68 d3 28 80 00       	push   $0x8028d3
  80172b:	e8 6d ed ff ff       	call   80049d <_panic>

00801730 <shrink>:
}
void shrink(uint32 newSize)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
  801733:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801736:	83 ec 04             	sub    $0x4,%esp
  801739:	68 e0 28 80 00       	push   $0x8028e0
  80173e:	68 a3 00 00 00       	push   $0xa3
  801743:	68 d3 28 80 00       	push   $0x8028d3
  801748:	e8 50 ed ff ff       	call   80049d <_panic>

0080174d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
  801750:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801753:	83 ec 04             	sub    $0x4,%esp
  801756:	68 e0 28 80 00       	push   $0x8028e0
  80175b:	68 a8 00 00 00       	push   $0xa8
  801760:	68 d3 28 80 00       	push   $0x8028d3
  801765:	e8 33 ed ff ff       	call   80049d <_panic>

0080176a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	57                   	push   %edi
  80176e:	56                   	push   %esi
  80176f:	53                   	push   %ebx
  801770:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	8b 55 0c             	mov    0xc(%ebp),%edx
  801779:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80177c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80177f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801782:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801785:	cd 30                	int    $0x30
  801787:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80178a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80178d:	83 c4 10             	add    $0x10,%esp
  801790:	5b                   	pop    %ebx
  801791:	5e                   	pop    %esi
  801792:	5f                   	pop    %edi
  801793:	5d                   	pop    %ebp
  801794:	c3                   	ret    

00801795 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
  801798:	83 ec 04             	sub    $0x4,%esp
  80179b:	8b 45 10             	mov    0x10(%ebp),%eax
  80179e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017a1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	52                   	push   %edx
  8017ad:	ff 75 0c             	pushl  0xc(%ebp)
  8017b0:	50                   	push   %eax
  8017b1:	6a 00                	push   $0x0
  8017b3:	e8 b2 ff ff ff       	call   80176a <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
}
  8017bb:	90                   	nop
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_cgetc>:

int
sys_cgetc(void)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 01                	push   $0x1
  8017cd:	e8 98 ff ff ff       	call   80176a <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017da:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	50                   	push   %eax
  8017e6:	6a 05                	push   $0x5
  8017e8:	e8 7d ff ff ff       	call   80176a <syscall>
  8017ed:	83 c4 18             	add    $0x18,%esp
}
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 02                	push   $0x2
  801801:	e8 64 ff ff ff       	call   80176a <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 03                	push   $0x3
  80181a:	e8 4b ff ff ff       	call   80176a <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	c9                   	leave  
  801823:	c3                   	ret    

00801824 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 04                	push   $0x4
  801833:	e8 32 ff ff ff       	call   80176a <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	c9                   	leave  
  80183c:	c3                   	ret    

0080183d <sys_env_exit>:


void sys_env_exit(void)
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 06                	push   $0x6
  80184c:	e8 19 ff ff ff       	call   80176a <syscall>
  801851:	83 c4 18             	add    $0x18,%esp
}
  801854:	90                   	nop
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80185a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	52                   	push   %edx
  801867:	50                   	push   %eax
  801868:	6a 07                	push   $0x7
  80186a:	e8 fb fe ff ff       	call   80176a <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
  801877:	56                   	push   %esi
  801878:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801879:	8b 75 18             	mov    0x18(%ebp),%esi
  80187c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80187f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801882:	8b 55 0c             	mov    0xc(%ebp),%edx
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	56                   	push   %esi
  801889:	53                   	push   %ebx
  80188a:	51                   	push   %ecx
  80188b:	52                   	push   %edx
  80188c:	50                   	push   %eax
  80188d:	6a 08                	push   $0x8
  80188f:	e8 d6 fe ff ff       	call   80176a <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80189a:	5b                   	pop    %ebx
  80189b:	5e                   	pop    %esi
  80189c:	5d                   	pop    %ebp
  80189d:	c3                   	ret    

0080189e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	52                   	push   %edx
  8018ae:	50                   	push   %eax
  8018af:	6a 09                	push   $0x9
  8018b1:	e8 b4 fe ff ff       	call   80176a <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	ff 75 0c             	pushl  0xc(%ebp)
  8018c7:	ff 75 08             	pushl  0x8(%ebp)
  8018ca:	6a 0a                	push   $0xa
  8018cc:	e8 99 fe ff ff       	call   80176a <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 0b                	push   $0xb
  8018e5:	e8 80 fe ff ff       	call   80176a <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 0c                	push   $0xc
  8018fe:	e8 67 fe ff ff       	call   80176a <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 0d                	push   $0xd
  801917:	e8 4e fe ff ff       	call   80176a <syscall>
  80191c:	83 c4 18             	add    $0x18,%esp
}
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	ff 75 0c             	pushl  0xc(%ebp)
  80192d:	ff 75 08             	pushl  0x8(%ebp)
  801930:	6a 11                	push   $0x11
  801932:	e8 33 fe ff ff       	call   80176a <syscall>
  801937:	83 c4 18             	add    $0x18,%esp
	return;
  80193a:	90                   	nop
}
  80193b:	c9                   	leave  
  80193c:	c3                   	ret    

0080193d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80193d:	55                   	push   %ebp
  80193e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 00                	push   $0x0
  801946:	ff 75 0c             	pushl  0xc(%ebp)
  801949:	ff 75 08             	pushl  0x8(%ebp)
  80194c:	6a 12                	push   $0x12
  80194e:	e8 17 fe ff ff       	call   80176a <syscall>
  801953:	83 c4 18             	add    $0x18,%esp
	return ;
  801956:	90                   	nop
}
  801957:	c9                   	leave  
  801958:	c3                   	ret    

00801959 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 0e                	push   $0xe
  801968:	e8 fd fd ff ff       	call   80176a <syscall>
  80196d:	83 c4 18             	add    $0x18,%esp
}
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	ff 75 08             	pushl  0x8(%ebp)
  801980:	6a 0f                	push   $0xf
  801982:	e8 e3 fd ff ff       	call   80176a <syscall>
  801987:	83 c4 18             	add    $0x18,%esp
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 10                	push   $0x10
  80199b:	e8 ca fd ff ff       	call   80176a <syscall>
  8019a0:	83 c4 18             	add    $0x18,%esp
}
  8019a3:	90                   	nop
  8019a4:	c9                   	leave  
  8019a5:	c3                   	ret    

008019a6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8019a6:	55                   	push   %ebp
  8019a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 14                	push   $0x14
  8019b5:	e8 b0 fd ff ff       	call   80176a <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
}
  8019bd:	90                   	nop
  8019be:	c9                   	leave  
  8019bf:	c3                   	ret    

008019c0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 15                	push   $0x15
  8019cf:	e8 96 fd ff ff       	call   80176a <syscall>
  8019d4:	83 c4 18             	add    $0x18,%esp
}
  8019d7:	90                   	nop
  8019d8:	c9                   	leave  
  8019d9:	c3                   	ret    

008019da <sys_cputc>:


void
sys_cputc(const char c)
{
  8019da:	55                   	push   %ebp
  8019db:	89 e5                	mov    %esp,%ebp
  8019dd:	83 ec 04             	sub    $0x4,%esp
  8019e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019e6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	50                   	push   %eax
  8019f3:	6a 16                	push   $0x16
  8019f5:	e8 70 fd ff ff       	call   80176a <syscall>
  8019fa:	83 c4 18             	add    $0x18,%esp
}
  8019fd:	90                   	nop
  8019fe:	c9                   	leave  
  8019ff:	c3                   	ret    

00801a00 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a00:	55                   	push   %ebp
  801a01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 17                	push   $0x17
  801a0f:	e8 56 fd ff ff       	call   80176a <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	90                   	nop
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	ff 75 0c             	pushl  0xc(%ebp)
  801a29:	50                   	push   %eax
  801a2a:	6a 18                	push   $0x18
  801a2c:	e8 39 fd ff ff       	call   80176a <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
}
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	52                   	push   %edx
  801a46:	50                   	push   %eax
  801a47:	6a 1b                	push   $0x1b
  801a49:	e8 1c fd ff ff       	call   80176a <syscall>
  801a4e:	83 c4 18             	add    $0x18,%esp
}
  801a51:	c9                   	leave  
  801a52:	c3                   	ret    

00801a53 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a59:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	52                   	push   %edx
  801a63:	50                   	push   %eax
  801a64:	6a 19                	push   $0x19
  801a66:	e8 ff fc ff ff       	call   80176a <syscall>
  801a6b:	83 c4 18             	add    $0x18,%esp
}
  801a6e:	90                   	nop
  801a6f:	c9                   	leave  
  801a70:	c3                   	ret    

00801a71 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a71:	55                   	push   %ebp
  801a72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a74:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a77:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	52                   	push   %edx
  801a81:	50                   	push   %eax
  801a82:	6a 1a                	push   $0x1a
  801a84:	e8 e1 fc ff ff       	call   80176a <syscall>
  801a89:	83 c4 18             	add    $0x18,%esp
}
  801a8c:	90                   	nop
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
  801a92:	83 ec 04             	sub    $0x4,%esp
  801a95:	8b 45 10             	mov    0x10(%ebp),%eax
  801a98:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a9b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a9e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa5:	6a 00                	push   $0x0
  801aa7:	51                   	push   %ecx
  801aa8:	52                   	push   %edx
  801aa9:	ff 75 0c             	pushl  0xc(%ebp)
  801aac:	50                   	push   %eax
  801aad:	6a 1c                	push   $0x1c
  801aaf:	e8 b6 fc ff ff       	call   80176a <syscall>
  801ab4:	83 c4 18             	add    $0x18,%esp
}
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    

00801ab9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ab9:	55                   	push   %ebp
  801aba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801abc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801abf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	52                   	push   %edx
  801ac9:	50                   	push   %eax
  801aca:	6a 1d                	push   $0x1d
  801acc:	e8 99 fc ff ff       	call   80176a <syscall>
  801ad1:	83 c4 18             	add    $0x18,%esp
}
  801ad4:	c9                   	leave  
  801ad5:	c3                   	ret    

00801ad6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ad9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801adc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801adf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	51                   	push   %ecx
  801ae7:	52                   	push   %edx
  801ae8:	50                   	push   %eax
  801ae9:	6a 1e                	push   $0x1e
  801aeb:	e8 7a fc ff ff       	call   80176a <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
}
  801af3:	c9                   	leave  
  801af4:	c3                   	ret    

00801af5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801af5:	55                   	push   %ebp
  801af6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801af8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801afb:	8b 45 08             	mov    0x8(%ebp),%eax
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	52                   	push   %edx
  801b05:	50                   	push   %eax
  801b06:	6a 1f                	push   $0x1f
  801b08:	e8 5d fc ff ff       	call   80176a <syscall>
  801b0d:	83 c4 18             	add    $0x18,%esp
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 20                	push   $0x20
  801b21:	e8 44 fc ff ff       	call   80176a <syscall>
  801b26:	83 c4 18             	add    $0x18,%esp
}
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	6a 00                	push   $0x0
  801b33:	ff 75 14             	pushl  0x14(%ebp)
  801b36:	ff 75 10             	pushl  0x10(%ebp)
  801b39:	ff 75 0c             	pushl  0xc(%ebp)
  801b3c:	50                   	push   %eax
  801b3d:	6a 21                	push   $0x21
  801b3f:	e8 26 fc ff ff       	call   80176a <syscall>
  801b44:	83 c4 18             	add    $0x18,%esp
}
  801b47:	c9                   	leave  
  801b48:	c3                   	ret    

00801b49 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	50                   	push   %eax
  801b58:	6a 22                	push   $0x22
  801b5a:	e8 0b fc ff ff       	call   80176a <syscall>
  801b5f:	83 c4 18             	add    $0x18,%esp
}
  801b62:	90                   	nop
  801b63:	c9                   	leave  
  801b64:	c3                   	ret    

00801b65 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b68:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	50                   	push   %eax
  801b74:	6a 23                	push   $0x23
  801b76:	e8 ef fb ff ff       	call   80176a <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
}
  801b7e:	90                   	nop
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    

00801b81 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
  801b84:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b87:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b8a:	8d 50 04             	lea    0x4(%eax),%edx
  801b8d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	52                   	push   %edx
  801b97:	50                   	push   %eax
  801b98:	6a 24                	push   $0x24
  801b9a:	e8 cb fb ff ff       	call   80176a <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return result;
  801ba2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ba5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ba8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bab:	89 01                	mov    %eax,(%ecx)
  801bad:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb3:	c9                   	leave  
  801bb4:	c2 04 00             	ret    $0x4

00801bb7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	ff 75 10             	pushl  0x10(%ebp)
  801bc1:	ff 75 0c             	pushl  0xc(%ebp)
  801bc4:	ff 75 08             	pushl  0x8(%ebp)
  801bc7:	6a 13                	push   $0x13
  801bc9:	e8 9c fb ff ff       	call   80176a <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd1:	90                   	nop
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <sys_rcr2>:
uint32 sys_rcr2()
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 25                	push   $0x25
  801be3:	e8 82 fb ff ff       	call   80176a <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
}
  801beb:	c9                   	leave  
  801bec:	c3                   	ret    

00801bed <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 04             	sub    $0x4,%esp
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bf9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	50                   	push   %eax
  801c06:	6a 26                	push   $0x26
  801c08:	e8 5d fb ff ff       	call   80176a <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c10:	90                   	nop
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <rsttst>:
void rsttst()
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 28                	push   $0x28
  801c22:	e8 43 fb ff ff       	call   80176a <syscall>
  801c27:	83 c4 18             	add    $0x18,%esp
	return ;
  801c2a:	90                   	nop
}
  801c2b:	c9                   	leave  
  801c2c:	c3                   	ret    

00801c2d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
  801c30:	83 ec 04             	sub    $0x4,%esp
  801c33:	8b 45 14             	mov    0x14(%ebp),%eax
  801c36:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c39:	8b 55 18             	mov    0x18(%ebp),%edx
  801c3c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c40:	52                   	push   %edx
  801c41:	50                   	push   %eax
  801c42:	ff 75 10             	pushl  0x10(%ebp)
  801c45:	ff 75 0c             	pushl  0xc(%ebp)
  801c48:	ff 75 08             	pushl  0x8(%ebp)
  801c4b:	6a 27                	push   $0x27
  801c4d:	e8 18 fb ff ff       	call   80176a <syscall>
  801c52:	83 c4 18             	add    $0x18,%esp
	return ;
  801c55:	90                   	nop
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <chktst>:
void chktst(uint32 n)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	ff 75 08             	pushl  0x8(%ebp)
  801c66:	6a 29                	push   $0x29
  801c68:	e8 fd fa ff ff       	call   80176a <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c70:	90                   	nop
}
  801c71:	c9                   	leave  
  801c72:	c3                   	ret    

00801c73 <inctst>:

void inctst()
{
  801c73:	55                   	push   %ebp
  801c74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 2a                	push   $0x2a
  801c82:	e8 e3 fa ff ff       	call   80176a <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
	return ;
  801c8a:	90                   	nop
}
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <gettst>:
uint32 gettst()
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 2b                	push   $0x2b
  801c9c:	e8 c9 fa ff ff       	call   80176a <syscall>
  801ca1:	83 c4 18             	add    $0x18,%esp
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
  801ca9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 2c                	push   $0x2c
  801cb8:	e8 ad fa ff ff       	call   80176a <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
  801cc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801cc3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801cc7:	75 07                	jne    801cd0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801cc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cce:	eb 05                	jmp    801cd5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801cd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
  801cda:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 2c                	push   $0x2c
  801ce9:	e8 7c fa ff ff       	call   80176a <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
  801cf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cf4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cf8:	75 07                	jne    801d01 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cfa:	b8 01 00 00 00       	mov    $0x1,%eax
  801cff:	eb 05                	jmp    801d06 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d01:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
  801d0b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 2c                	push   $0x2c
  801d1a:	e8 4b fa ff ff       	call   80176a <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
  801d22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d25:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d29:	75 07                	jne    801d32 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d2b:	b8 01 00 00 00       	mov    $0x1,%eax
  801d30:	eb 05                	jmp    801d37 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d32:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d37:	c9                   	leave  
  801d38:	c3                   	ret    

00801d39 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
  801d3c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 2c                	push   $0x2c
  801d4b:	e8 1a fa ff ff       	call   80176a <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
  801d53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d56:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d5a:	75 07                	jne    801d63 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d5c:	b8 01 00 00 00       	mov    $0x1,%eax
  801d61:	eb 05                	jmp    801d68 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d63:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d68:	c9                   	leave  
  801d69:	c3                   	ret    

00801d6a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d6a:	55                   	push   %ebp
  801d6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	ff 75 08             	pushl  0x8(%ebp)
  801d78:	6a 2d                	push   $0x2d
  801d7a:	e8 eb f9 ff ff       	call   80176a <syscall>
  801d7f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d82:	90                   	nop
}
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
  801d88:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d89:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d8c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d92:	8b 45 08             	mov    0x8(%ebp),%eax
  801d95:	6a 00                	push   $0x0
  801d97:	53                   	push   %ebx
  801d98:	51                   	push   %ecx
  801d99:	52                   	push   %edx
  801d9a:	50                   	push   %eax
  801d9b:	6a 2e                	push   $0x2e
  801d9d:	e8 c8 f9 ff ff       	call   80176a <syscall>
  801da2:	83 c4 18             	add    $0x18,%esp
}
  801da5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801dad:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db0:	8b 45 08             	mov    0x8(%ebp),%eax
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	52                   	push   %edx
  801dba:	50                   	push   %eax
  801dbb:	6a 2f                	push   $0x2f
  801dbd:	e8 a8 f9 ff ff       	call   80176a <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
  801dca:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801dcd:	8b 55 08             	mov    0x8(%ebp),%edx
  801dd0:	89 d0                	mov    %edx,%eax
  801dd2:	c1 e0 02             	shl    $0x2,%eax
  801dd5:	01 d0                	add    %edx,%eax
  801dd7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dde:	01 d0                	add    %edx,%eax
  801de0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801de7:	01 d0                	add    %edx,%eax
  801de9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801df0:	01 d0                	add    %edx,%eax
  801df2:	c1 e0 04             	shl    $0x4,%eax
  801df5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801df8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801dff:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801e02:	83 ec 0c             	sub    $0xc,%esp
  801e05:	50                   	push   %eax
  801e06:	e8 76 fd ff ff       	call   801b81 <sys_get_virtual_time>
  801e0b:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801e0e:	eb 41                	jmp    801e51 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801e10:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801e13:	83 ec 0c             	sub    $0xc,%esp
  801e16:	50                   	push   %eax
  801e17:	e8 65 fd ff ff       	call   801b81 <sys_get_virtual_time>
  801e1c:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801e1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e22:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e25:	29 c2                	sub    %eax,%edx
  801e27:	89 d0                	mov    %edx,%eax
  801e29:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801e2c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e32:	89 d1                	mov    %edx,%ecx
  801e34:	29 c1                	sub    %eax,%ecx
  801e36:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801e39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e3c:	39 c2                	cmp    %eax,%edx
  801e3e:	0f 97 c0             	seta   %al
  801e41:	0f b6 c0             	movzbl %al,%eax
  801e44:	29 c1                	sub    %eax,%ecx
  801e46:	89 c8                	mov    %ecx,%eax
  801e48:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801e4b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801e4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e54:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e57:	72 b7                	jb     801e10 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801e59:	90                   	nop
  801e5a:	c9                   	leave  
  801e5b:	c3                   	ret    

00801e5c <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801e5c:	55                   	push   %ebp
  801e5d:	89 e5                	mov    %esp,%ebp
  801e5f:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801e62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801e69:	eb 03                	jmp    801e6e <busy_wait+0x12>
  801e6b:	ff 45 fc             	incl   -0x4(%ebp)
  801e6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e71:	3b 45 08             	cmp    0x8(%ebp),%eax
  801e74:	72 f5                	jb     801e6b <busy_wait+0xf>
	return i;
  801e76:	8b 45 fc             	mov    -0x4(%ebp),%eax
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
