
obj/user/tst_freeing_stack:     file format elf32-i386


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
  800031:	e8 65 02 00 00       	call   80029b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>

int RecursiveFn(int numOfRec);
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 38             	sub    $0x38,%esp
	int res, numOfRec, expectedResult, r, i, j, freeFrames, usedDiskPages ;
	uint32 vaOf1stStackPage = USTACKTOP - PAGE_SIZE;
  80003e:	c7 45 dc 00 d0 bf ee 	movl   $0xeebfd000,-0x24(%ebp)

	int initNumOfEmptyWSEntries, curNumOfEmptyWSEntries ;

	/*Different number of recursive calls (each call takes 1 PAGE)*/
	for (r = 1; r <= 10; ++r)
  800045:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  80004c:	e9 b3 01 00 00       	jmp    800204 <_main+0x1cc>
	{
		numOfRec = r;
  800051:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800054:	89 45 d8             	mov    %eax,-0x28(%ebp)

		initNumOfEmptyWSEntries = 0;
  800057:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80005e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800065:	eb 20                	jmp    800087 <_main+0x4f>
		{
			if (myEnv->__uptr_pws[j].empty==1)
  800067:	a1 20 30 80 00       	mov    0x803020,%eax
  80006c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800072:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800075:	c1 e2 04             	shl    $0x4,%edx
  800078:	01 d0                	add    %edx,%eax
  80007a:	8a 40 04             	mov    0x4(%eax),%al
  80007d:	3c 01                	cmp    $0x1,%al
  80007f:	75 03                	jne    800084 <_main+0x4c>
				initNumOfEmptyWSEntries++;
  800081:	ff 45 e4             	incl   -0x1c(%ebp)
	for (r = 1; r <= 10; ++r)
	{
		numOfRec = r;

		initNumOfEmptyWSEntries = 0;
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  800084:	ff 45 e8             	incl   -0x18(%ebp)
  800087:	a1 20 30 80 00       	mov    0x803020,%eax
  80008c:	8b 50 74             	mov    0x74(%eax),%edx
  80008f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800092:	39 c2                	cmp    %eax,%edx
  800094:	77 d1                	ja     800067 <_main+0x2f>
		{
			if (myEnv->__uptr_pws[j].empty==1)
				initNumOfEmptyWSEntries++;
		}

		freeFrames = sys_calculate_free_frames() ;
  800096:	e8 dd 14 00 00       	call   801578 <sys_calculate_free_frames>
  80009b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80009e:	e8 58 15 00 00       	call   8015fb <sys_pf_calculate_allocated_pages>
  8000a3:	89 45 d0             	mov    %eax,-0x30(%ebp)

		res = RecursiveFn(numOfRec);
  8000a6:	83 ec 0c             	sub    $0xc,%esp
  8000a9:	ff 75 d8             	pushl  -0x28(%ebp)
  8000ac:	e8 70 01 00 00       	call   800221 <RecursiveFn>
  8000b1:	83 c4 10             	add    $0x10,%esp
  8000b4:	89 45 cc             	mov    %eax,-0x34(%ebp)
		env_sleep(1) ;
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	6a 01                	push   $0x1
  8000bc:	e8 a8 19 00 00       	call   801a69 <env_sleep>
  8000c1:	83 c4 10             	add    $0x10,%esp
		expectedResult = 0;
  8000c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for (i = 1; i <= numOfRec; ++i) {
  8000cb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  8000d2:	eb 0c                	jmp    8000e0 <_main+0xa8>
			expectedResult += i * 1024;
  8000d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000d7:	c1 e0 0a             	shl    $0xa,%eax
  8000da:	01 45 f4             	add    %eax,-0xc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;

		res = RecursiveFn(numOfRec);
		env_sleep(1) ;
		expectedResult = 0;
		for (i = 1; i <= numOfRec; ++i) {
  8000dd:	ff 45 ec             	incl   -0x14(%ebp)
  8000e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e3:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8000e6:	7e ec                	jle    8000d4 <_main+0x9c>
			expectedResult += i * 1024;
		}
		//check correct answer & page file
		if (res != expectedResult) panic("Wrong result of the recursive function!\n");
  8000e8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000eb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000ee:	74 14                	je     800104 <_main+0xcc>
  8000f0:	83 ec 04             	sub    $0x4,%esp
  8000f3:	68 a0 1d 80 00       	push   $0x801da0
  8000f8:	6a 28                	push   $0x28
  8000fa:	68 c9 1d 80 00       	push   $0x801dc9
  8000ff:	e8 dc 02 00 00       	call   8003e0 <_panic>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");
  800104:	e8 f2 14 00 00       	call   8015fb <sys_pf_calculate_allocated_pages>
  800109:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  80010c:	74 14                	je     800122 <_main+0xea>
  80010e:	83 ec 04             	sub    $0x4,%esp
  800111:	68 e4 1d 80 00       	push   $0x801de4
  800116:	6a 29                	push   $0x29
  800118:	68 c9 1d 80 00       	push   $0x801dc9
  80011d:	e8 be 02 00 00       	call   8003e0 <_panic>

		//check WS
		for (i = 1; i <= numOfRec; ++i)
  800122:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  800129:	eb 65                	jmp    800190 <_main+0x158>
		{
			for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80012b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800132:	eb 4a                	jmp    80017e <_main+0x146>
			{
				if (ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address, PAGE_SIZE) == vaOf1stStackPage - i*PAGE_SIZE)
  800134:	a1 20 30 80 00       	mov    0x803020,%eax
  800139:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80013f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800142:	c1 e2 04             	shl    $0x4,%edx
  800145:	01 d0                	add    %edx,%eax
  800147:	8b 00                	mov    (%eax),%eax
  800149:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80014c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80014f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800154:	89 c2                	mov    %eax,%edx
  800156:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800159:	c1 e0 0c             	shl    $0xc,%eax
  80015c:	89 c1                	mov    %eax,%ecx
  80015e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800161:	29 c8                	sub    %ecx,%eax
  800163:	39 c2                	cmp    %eax,%edx
  800165:	75 14                	jne    80017b <_main+0x143>
					panic("Wrong freeing the stack pages from the working set!\n");
  800167:	83 ec 04             	sub    $0x4,%esp
  80016a:	68 18 1e 80 00       	push   $0x801e18
  80016f:	6a 31                	push   $0x31
  800171:	68 c9 1d 80 00       	push   $0x801dc9
  800176:	e8 65 02 00 00       	call   8003e0 <_panic>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");

		//check WS
		for (i = 1; i <= numOfRec; ++i)
		{
			for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80017b:	ff 45 e8             	incl   -0x18(%ebp)
  80017e:	a1 20 30 80 00       	mov    0x803020,%eax
  800183:	8b 50 74             	mov    0x74(%eax),%edx
  800186:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800189:	39 c2                	cmp    %eax,%edx
  80018b:	77 a7                	ja     800134 <_main+0xfc>
		//check correct answer & page file
		if (res != expectedResult) panic("Wrong result of the recursive function!\n");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 0) panic("Wrong freeing the stack pages from the page file!\n");

		//check WS
		for (i = 1; i <= numOfRec; ++i)
  80018d:	ff 45 ec             	incl   -0x14(%ebp)
  800190:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800193:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800196:	7e 93                	jle    80012b <_main+0xf3>
					panic("Wrong freeing the stack pages from the working set!\n");
			}
		}

		//check free frames
		curNumOfEmptyWSEntries = 0;
  800198:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  80019f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8001a6:	eb 20                	jmp    8001c8 <_main+0x190>
		{
			if (myEnv->__uptr_pws[j].empty==1)
  8001a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ad:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001b3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001b6:	c1 e2 04             	shl    $0x4,%edx
  8001b9:	01 d0                	add    %edx,%eax
  8001bb:	8a 40 04             	mov    0x4(%eax),%al
  8001be:	3c 01                	cmp    $0x1,%al
  8001c0:	75 03                	jne    8001c5 <_main+0x18d>
				curNumOfEmptyWSEntries++;
  8001c2:	ff 45 e0             	incl   -0x20(%ebp)
			}
		}

		//check free frames
		curNumOfEmptyWSEntries = 0;
		for (j = 0; j < myEnv->page_WS_max_size; ++j)
  8001c5:	ff 45 e8             	incl   -0x18(%ebp)
  8001c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001cd:	8b 50 74             	mov    0x74(%eax),%edx
  8001d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001d3:	39 c2                	cmp    %eax,%edx
  8001d5:	77 d1                	ja     8001a8 <_main+0x170>
			if (myEnv->__uptr_pws[j].empty==1)
				curNumOfEmptyWSEntries++;
		}

		//cprintf("diff in RAM = %d\n", sys_calculate_free_frames() - freeFrames);
		if ((sys_calculate_free_frames() - freeFrames) != curNumOfEmptyWSEntries - initNumOfEmptyWSEntries)
  8001d7:	e8 9c 13 00 00       	call   801578 <sys_calculate_free_frames>
  8001dc:	89 c2                	mov    %eax,%edx
  8001de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001e1:	29 c2                	sub    %eax,%edx
  8001e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001e6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001e9:	39 c2                	cmp    %eax,%edx
  8001eb:	74 14                	je     800201 <_main+0x1c9>
			panic("Wrong freeing the stack pages from memory!\n");
  8001ed:	83 ec 04             	sub    $0x4,%esp
  8001f0:	68 50 1e 80 00       	push   $0x801e50
  8001f5:	6a 3f                	push   $0x3f
  8001f7:	68 c9 1d 80 00       	push   $0x801dc9
  8001fc:	e8 df 01 00 00       	call   8003e0 <_panic>
	uint32 vaOf1stStackPage = USTACKTOP - PAGE_SIZE;

	int initNumOfEmptyWSEntries, curNumOfEmptyWSEntries ;

	/*Different number of recursive calls (each call takes 1 PAGE)*/
	for (r = 1; r <= 10; ++r)
  800201:	ff 45 f0             	incl   -0x10(%ebp)
  800204:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  800208:	0f 8e 43 fe ff ff    	jle    800051 <_main+0x19>
		//cprintf("diff in RAM = %d\n", sys_calculate_free_frames() - freeFrames);
		if ((sys_calculate_free_frames() - freeFrames) != curNumOfEmptyWSEntries - initNumOfEmptyWSEntries)
			panic("Wrong freeing the stack pages from memory!\n");
	}

	cprintf("Congratulations!! test freeing the stack pages is completed successfully.\n");
  80020e:	83 ec 0c             	sub    $0xc,%esp
  800211:	68 7c 1e 80 00       	push   $0x801e7c
  800216:	e8 67 04 00 00       	call   800682 <cprintf>
  80021b:	83 c4 10             	add    $0x10,%esp

	return;
  80021e:	90                   	nop
}
  80021f:	c9                   	leave  
  800220:	c3                   	ret    

00800221 <RecursiveFn>:

int RecursiveFn(int numOfRec)
{
  800221:	55                   	push   %ebp
  800222:	89 e5                	mov    %esp,%ebp
  800224:	81 ec 18 10 00 00    	sub    $0x1018,%esp
	if (numOfRec == 0)
  80022a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80022e:	75 07                	jne    800237 <RecursiveFn+0x16>
		return 0;
  800230:	b8 00 00 00 00       	mov    $0x0,%eax
  800235:	eb 62                	jmp    800299 <RecursiveFn+0x78>

	int A[1024] ;
	int i, sum = 0 ;
  800237:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	for (i = 0; i < 1024; ++i) {
  80023e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800245:	eb 10                	jmp    800257 <RecursiveFn+0x36>
		A[i] = numOfRec;
  800247:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80024a:	8b 55 08             	mov    0x8(%ebp),%edx
  80024d:	89 94 85 f0 ef ff ff 	mov    %edx,-0x1010(%ebp,%eax,4)
	if (numOfRec == 0)
		return 0;

	int A[1024] ;
	int i, sum = 0 ;
	for (i = 0; i < 1024; ++i) {
  800254:	ff 45 f4             	incl   -0xc(%ebp)
  800257:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
  80025e:	7e e7                	jle    800247 <RecursiveFn+0x26>
		A[i] = numOfRec;
	}
	for (i = 0; i < 1024; ++i) {
  800260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800267:	eb 10                	jmp    800279 <RecursiveFn+0x58>
		sum += A[i] ;
  800269:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80026c:	8b 84 85 f0 ef ff ff 	mov    -0x1010(%ebp,%eax,4),%eax
  800273:	01 45 f0             	add    %eax,-0x10(%ebp)
	int A[1024] ;
	int i, sum = 0 ;
	for (i = 0; i < 1024; ++i) {
		A[i] = numOfRec;
	}
	for (i = 0; i < 1024; ++i) {
  800276:	ff 45 f4             	incl   -0xc(%ebp)
  800279:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
  800280:	7e e7                	jle    800269 <RecursiveFn+0x48>
		sum += A[i] ;
	}
	return sum + RecursiveFn(numOfRec-1);
  800282:	8b 45 08             	mov    0x8(%ebp),%eax
  800285:	48                   	dec    %eax
  800286:	83 ec 0c             	sub    $0xc,%esp
  800289:	50                   	push   %eax
  80028a:	e8 92 ff ff ff       	call   800221 <RecursiveFn>
  80028f:	83 c4 10             	add    $0x10,%esp
  800292:	89 c2                	mov    %eax,%edx
  800294:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800297:	01 d0                	add    %edx,%eax
}
  800299:	c9                   	leave  
  80029a:	c3                   	ret    

0080029b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80029b:	55                   	push   %ebp
  80029c:	89 e5                	mov    %esp,%ebp
  80029e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002a1:	e8 07 12 00 00       	call   8014ad <sys_getenvindex>
  8002a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002ac:	89 d0                	mov    %edx,%eax
  8002ae:	c1 e0 03             	shl    $0x3,%eax
  8002b1:	01 d0                	add    %edx,%eax
  8002b3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8002ba:	01 c8                	add    %ecx,%eax
  8002bc:	01 c0                	add    %eax,%eax
  8002be:	01 d0                	add    %edx,%eax
  8002c0:	01 c0                	add    %eax,%eax
  8002c2:	01 d0                	add    %edx,%eax
  8002c4:	89 c2                	mov    %eax,%edx
  8002c6:	c1 e2 05             	shl    $0x5,%edx
  8002c9:	29 c2                	sub    %eax,%edx
  8002cb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8002d2:	89 c2                	mov    %eax,%edx
  8002d4:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8002da:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002df:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e4:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8002ea:	84 c0                	test   %al,%al
  8002ec:	74 0f                	je     8002fd <libmain+0x62>
		binaryname = myEnv->prog_name;
  8002ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f3:	05 40 3c 01 00       	add    $0x13c40,%eax
  8002f8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800301:	7e 0a                	jle    80030d <libmain+0x72>
		binaryname = argv[0];
  800303:	8b 45 0c             	mov    0xc(%ebp),%eax
  800306:	8b 00                	mov    (%eax),%eax
  800308:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80030d:	83 ec 08             	sub    $0x8,%esp
  800310:	ff 75 0c             	pushl  0xc(%ebp)
  800313:	ff 75 08             	pushl  0x8(%ebp)
  800316:	e8 1d fd ff ff       	call   800038 <_main>
  80031b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80031e:	e8 25 13 00 00       	call   801648 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	68 e0 1e 80 00       	push   $0x801ee0
  80032b:	e8 52 03 00 00       	call   800682 <cprintf>
  800330:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800333:	a1 20 30 80 00       	mov    0x803020,%eax
  800338:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80033e:	a1 20 30 80 00       	mov    0x803020,%eax
  800343:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800349:	83 ec 04             	sub    $0x4,%esp
  80034c:	52                   	push   %edx
  80034d:	50                   	push   %eax
  80034e:	68 08 1f 80 00       	push   $0x801f08
  800353:	e8 2a 03 00 00       	call   800682 <cprintf>
  800358:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80035b:	a1 20 30 80 00       	mov    0x803020,%eax
  800360:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800366:	a1 20 30 80 00       	mov    0x803020,%eax
  80036b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800371:	83 ec 04             	sub    $0x4,%esp
  800374:	52                   	push   %edx
  800375:	50                   	push   %eax
  800376:	68 30 1f 80 00       	push   $0x801f30
  80037b:	e8 02 03 00 00       	call   800682 <cprintf>
  800380:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800383:	a1 20 30 80 00       	mov    0x803020,%eax
  800388:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80038e:	83 ec 08             	sub    $0x8,%esp
  800391:	50                   	push   %eax
  800392:	68 71 1f 80 00       	push   $0x801f71
  800397:	e8 e6 02 00 00       	call   800682 <cprintf>
  80039c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80039f:	83 ec 0c             	sub    $0xc,%esp
  8003a2:	68 e0 1e 80 00       	push   $0x801ee0
  8003a7:	e8 d6 02 00 00       	call   800682 <cprintf>
  8003ac:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003af:	e8 ae 12 00 00       	call   801662 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003b4:	e8 19 00 00 00       	call   8003d2 <exit>
}
  8003b9:	90                   	nop
  8003ba:	c9                   	leave  
  8003bb:	c3                   	ret    

008003bc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003bc:	55                   	push   %ebp
  8003bd:	89 e5                	mov    %esp,%ebp
  8003bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003c2:	83 ec 0c             	sub    $0xc,%esp
  8003c5:	6a 00                	push   $0x0
  8003c7:	e8 ad 10 00 00       	call   801479 <sys_env_destroy>
  8003cc:	83 c4 10             	add    $0x10,%esp
}
  8003cf:	90                   	nop
  8003d0:	c9                   	leave  
  8003d1:	c3                   	ret    

008003d2 <exit>:

void
exit(void)
{
  8003d2:	55                   	push   %ebp
  8003d3:	89 e5                	mov    %esp,%ebp
  8003d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003d8:	e8 02 11 00 00       	call   8014df <sys_env_exit>
}
  8003dd:	90                   	nop
  8003de:	c9                   	leave  
  8003df:	c3                   	ret    

008003e0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003e0:	55                   	push   %ebp
  8003e1:	89 e5                	mov    %esp,%ebp
  8003e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8003e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8003e9:	83 c0 04             	add    $0x4,%eax
  8003ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8003ef:	a1 18 31 80 00       	mov    0x803118,%eax
  8003f4:	85 c0                	test   %eax,%eax
  8003f6:	74 16                	je     80040e <_panic+0x2e>
		cprintf("%s: ", argv0);
  8003f8:	a1 18 31 80 00       	mov    0x803118,%eax
  8003fd:	83 ec 08             	sub    $0x8,%esp
  800400:	50                   	push   %eax
  800401:	68 88 1f 80 00       	push   $0x801f88
  800406:	e8 77 02 00 00       	call   800682 <cprintf>
  80040b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80040e:	a1 00 30 80 00       	mov    0x803000,%eax
  800413:	ff 75 0c             	pushl  0xc(%ebp)
  800416:	ff 75 08             	pushl  0x8(%ebp)
  800419:	50                   	push   %eax
  80041a:	68 8d 1f 80 00       	push   $0x801f8d
  80041f:	e8 5e 02 00 00       	call   800682 <cprintf>
  800424:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800427:	8b 45 10             	mov    0x10(%ebp),%eax
  80042a:	83 ec 08             	sub    $0x8,%esp
  80042d:	ff 75 f4             	pushl  -0xc(%ebp)
  800430:	50                   	push   %eax
  800431:	e8 e1 01 00 00       	call   800617 <vcprintf>
  800436:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800439:	83 ec 08             	sub    $0x8,%esp
  80043c:	6a 00                	push   $0x0
  80043e:	68 a9 1f 80 00       	push   $0x801fa9
  800443:	e8 cf 01 00 00       	call   800617 <vcprintf>
  800448:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80044b:	e8 82 ff ff ff       	call   8003d2 <exit>

	// should not return here
	while (1) ;
  800450:	eb fe                	jmp    800450 <_panic+0x70>

00800452 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800452:	55                   	push   %ebp
  800453:	89 e5                	mov    %esp,%ebp
  800455:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800458:	a1 20 30 80 00       	mov    0x803020,%eax
  80045d:	8b 50 74             	mov    0x74(%eax),%edx
  800460:	8b 45 0c             	mov    0xc(%ebp),%eax
  800463:	39 c2                	cmp    %eax,%edx
  800465:	74 14                	je     80047b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800467:	83 ec 04             	sub    $0x4,%esp
  80046a:	68 ac 1f 80 00       	push   $0x801fac
  80046f:	6a 26                	push   $0x26
  800471:	68 f8 1f 80 00       	push   $0x801ff8
  800476:	e8 65 ff ff ff       	call   8003e0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80047b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800482:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800489:	e9 b6 00 00 00       	jmp    800544 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80048e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800491:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800498:	8b 45 08             	mov    0x8(%ebp),%eax
  80049b:	01 d0                	add    %edx,%eax
  80049d:	8b 00                	mov    (%eax),%eax
  80049f:	85 c0                	test   %eax,%eax
  8004a1:	75 08                	jne    8004ab <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004a3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004a6:	e9 96 00 00 00       	jmp    800541 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8004ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004b9:	eb 5d                	jmp    800518 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004c9:	c1 e2 04             	shl    $0x4,%edx
  8004cc:	01 d0                	add    %edx,%eax
  8004ce:	8a 40 04             	mov    0x4(%eax),%al
  8004d1:	84 c0                	test   %al,%al
  8004d3:	75 40                	jne    800515 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004da:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004e3:	c1 e2 04             	shl    $0x4,%edx
  8004e6:	01 d0                	add    %edx,%eax
  8004e8:	8b 00                	mov    (%eax),%eax
  8004ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8004ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004f5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8004f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004fa:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	01 c8                	add    %ecx,%eax
  800506:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800508:	39 c2                	cmp    %eax,%edx
  80050a:	75 09                	jne    800515 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80050c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800513:	eb 12                	jmp    800527 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800515:	ff 45 e8             	incl   -0x18(%ebp)
  800518:	a1 20 30 80 00       	mov    0x803020,%eax
  80051d:	8b 50 74             	mov    0x74(%eax),%edx
  800520:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800523:	39 c2                	cmp    %eax,%edx
  800525:	77 94                	ja     8004bb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800527:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80052b:	75 14                	jne    800541 <CheckWSWithoutLastIndex+0xef>
			panic(
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 04 20 80 00       	push   $0x802004
  800535:	6a 3a                	push   $0x3a
  800537:	68 f8 1f 80 00       	push   $0x801ff8
  80053c:	e8 9f fe ff ff       	call   8003e0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800541:	ff 45 f0             	incl   -0x10(%ebp)
  800544:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800547:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80054a:	0f 8c 3e ff ff ff    	jl     80048e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800550:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800557:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80055e:	eb 20                	jmp    800580 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800560:	a1 20 30 80 00       	mov    0x803020,%eax
  800565:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80056b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80056e:	c1 e2 04             	shl    $0x4,%edx
  800571:	01 d0                	add    %edx,%eax
  800573:	8a 40 04             	mov    0x4(%eax),%al
  800576:	3c 01                	cmp    $0x1,%al
  800578:	75 03                	jne    80057d <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80057a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80057d:	ff 45 e0             	incl   -0x20(%ebp)
  800580:	a1 20 30 80 00       	mov    0x803020,%eax
  800585:	8b 50 74             	mov    0x74(%eax),%edx
  800588:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80058b:	39 c2                	cmp    %eax,%edx
  80058d:	77 d1                	ja     800560 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80058f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800592:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800595:	74 14                	je     8005ab <CheckWSWithoutLastIndex+0x159>
		panic(
  800597:	83 ec 04             	sub    $0x4,%esp
  80059a:	68 58 20 80 00       	push   $0x802058
  80059f:	6a 44                	push   $0x44
  8005a1:	68 f8 1f 80 00       	push   $0x801ff8
  8005a6:	e8 35 fe ff ff       	call   8003e0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005ab:	90                   	nop
  8005ac:	c9                   	leave  
  8005ad:	c3                   	ret    

008005ae <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005ae:	55                   	push   %ebp
  8005af:	89 e5                	mov    %esp,%ebp
  8005b1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b7:	8b 00                	mov    (%eax),%eax
  8005b9:	8d 48 01             	lea    0x1(%eax),%ecx
  8005bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005bf:	89 0a                	mov    %ecx,(%edx)
  8005c1:	8b 55 08             	mov    0x8(%ebp),%edx
  8005c4:	88 d1                	mov    %dl,%cl
  8005c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005d7:	75 2c                	jne    800605 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005d9:	a0 24 30 80 00       	mov    0x803024,%al
  8005de:	0f b6 c0             	movzbl %al,%eax
  8005e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005e4:	8b 12                	mov    (%edx),%edx
  8005e6:	89 d1                	mov    %edx,%ecx
  8005e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005eb:	83 c2 08             	add    $0x8,%edx
  8005ee:	83 ec 04             	sub    $0x4,%esp
  8005f1:	50                   	push   %eax
  8005f2:	51                   	push   %ecx
  8005f3:	52                   	push   %edx
  8005f4:	e8 3e 0e 00 00       	call   801437 <sys_cputs>
  8005f9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800605:	8b 45 0c             	mov    0xc(%ebp),%eax
  800608:	8b 40 04             	mov    0x4(%eax),%eax
  80060b:	8d 50 01             	lea    0x1(%eax),%edx
  80060e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800611:	89 50 04             	mov    %edx,0x4(%eax)
}
  800614:	90                   	nop
  800615:	c9                   	leave  
  800616:	c3                   	ret    

00800617 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800617:	55                   	push   %ebp
  800618:	89 e5                	mov    %esp,%ebp
  80061a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800620:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800627:	00 00 00 
	b.cnt = 0;
  80062a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800631:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800634:	ff 75 0c             	pushl  0xc(%ebp)
  800637:	ff 75 08             	pushl  0x8(%ebp)
  80063a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800640:	50                   	push   %eax
  800641:	68 ae 05 80 00       	push   $0x8005ae
  800646:	e8 11 02 00 00       	call   80085c <vprintfmt>
  80064b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80064e:	a0 24 30 80 00       	mov    0x803024,%al
  800653:	0f b6 c0             	movzbl %al,%eax
  800656:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80065c:	83 ec 04             	sub    $0x4,%esp
  80065f:	50                   	push   %eax
  800660:	52                   	push   %edx
  800661:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800667:	83 c0 08             	add    $0x8,%eax
  80066a:	50                   	push   %eax
  80066b:	e8 c7 0d 00 00       	call   801437 <sys_cputs>
  800670:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800673:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80067a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800680:	c9                   	leave  
  800681:	c3                   	ret    

00800682 <cprintf>:

int cprintf(const char *fmt, ...) {
  800682:	55                   	push   %ebp
  800683:	89 e5                	mov    %esp,%ebp
  800685:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800688:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80068f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800692:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800695:	8b 45 08             	mov    0x8(%ebp),%eax
  800698:	83 ec 08             	sub    $0x8,%esp
  80069b:	ff 75 f4             	pushl  -0xc(%ebp)
  80069e:	50                   	push   %eax
  80069f:	e8 73 ff ff ff       	call   800617 <vcprintf>
  8006a4:	83 c4 10             	add    $0x10,%esp
  8006a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006b5:	e8 8e 0f 00 00       	call   801648 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006ba:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c3:	83 ec 08             	sub    $0x8,%esp
  8006c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c9:	50                   	push   %eax
  8006ca:	e8 48 ff ff ff       	call   800617 <vcprintf>
  8006cf:	83 c4 10             	add    $0x10,%esp
  8006d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006d5:	e8 88 0f 00 00       	call   801662 <sys_enable_interrupt>
	return cnt;
  8006da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006dd:	c9                   	leave  
  8006de:	c3                   	ret    

008006df <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006df:	55                   	push   %ebp
  8006e0:	89 e5                	mov    %esp,%ebp
  8006e2:	53                   	push   %ebx
  8006e3:	83 ec 14             	sub    $0x14,%esp
  8006e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006f2:	8b 45 18             	mov    0x18(%ebp),%eax
  8006f5:	ba 00 00 00 00       	mov    $0x0,%edx
  8006fa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006fd:	77 55                	ja     800754 <printnum+0x75>
  8006ff:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800702:	72 05                	jb     800709 <printnum+0x2a>
  800704:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800707:	77 4b                	ja     800754 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800709:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80070c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80070f:	8b 45 18             	mov    0x18(%ebp),%eax
  800712:	ba 00 00 00 00       	mov    $0x0,%edx
  800717:	52                   	push   %edx
  800718:	50                   	push   %eax
  800719:	ff 75 f4             	pushl  -0xc(%ebp)
  80071c:	ff 75 f0             	pushl  -0x10(%ebp)
  80071f:	e8 fc 13 00 00       	call   801b20 <__udivdi3>
  800724:	83 c4 10             	add    $0x10,%esp
  800727:	83 ec 04             	sub    $0x4,%esp
  80072a:	ff 75 20             	pushl  0x20(%ebp)
  80072d:	53                   	push   %ebx
  80072e:	ff 75 18             	pushl  0x18(%ebp)
  800731:	52                   	push   %edx
  800732:	50                   	push   %eax
  800733:	ff 75 0c             	pushl  0xc(%ebp)
  800736:	ff 75 08             	pushl  0x8(%ebp)
  800739:	e8 a1 ff ff ff       	call   8006df <printnum>
  80073e:	83 c4 20             	add    $0x20,%esp
  800741:	eb 1a                	jmp    80075d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800743:	83 ec 08             	sub    $0x8,%esp
  800746:	ff 75 0c             	pushl  0xc(%ebp)
  800749:	ff 75 20             	pushl  0x20(%ebp)
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	ff d0                	call   *%eax
  800751:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800754:	ff 4d 1c             	decl   0x1c(%ebp)
  800757:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80075b:	7f e6                	jg     800743 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80075d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800760:	bb 00 00 00 00       	mov    $0x0,%ebx
  800765:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800768:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80076b:	53                   	push   %ebx
  80076c:	51                   	push   %ecx
  80076d:	52                   	push   %edx
  80076e:	50                   	push   %eax
  80076f:	e8 bc 14 00 00       	call   801c30 <__umoddi3>
  800774:	83 c4 10             	add    $0x10,%esp
  800777:	05 d4 22 80 00       	add    $0x8022d4,%eax
  80077c:	8a 00                	mov    (%eax),%al
  80077e:	0f be c0             	movsbl %al,%eax
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	ff 75 0c             	pushl  0xc(%ebp)
  800787:	50                   	push   %eax
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	ff d0                	call   *%eax
  80078d:	83 c4 10             	add    $0x10,%esp
}
  800790:	90                   	nop
  800791:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800794:	c9                   	leave  
  800795:	c3                   	ret    

00800796 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800796:	55                   	push   %ebp
  800797:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800799:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80079d:	7e 1c                	jle    8007bb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	8d 50 08             	lea    0x8(%eax),%edx
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	89 10                	mov    %edx,(%eax)
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	83 e8 08             	sub    $0x8,%eax
  8007b4:	8b 50 04             	mov    0x4(%eax),%edx
  8007b7:	8b 00                	mov    (%eax),%eax
  8007b9:	eb 40                	jmp    8007fb <getuint+0x65>
	else if (lflag)
  8007bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007bf:	74 1e                	je     8007df <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c4:	8b 00                	mov    (%eax),%eax
  8007c6:	8d 50 04             	lea    0x4(%eax),%edx
  8007c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cc:	89 10                	mov    %edx,(%eax)
  8007ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d1:	8b 00                	mov    (%eax),%eax
  8007d3:	83 e8 04             	sub    $0x4,%eax
  8007d6:	8b 00                	mov    (%eax),%eax
  8007d8:	ba 00 00 00 00       	mov    $0x0,%edx
  8007dd:	eb 1c                	jmp    8007fb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	8b 00                	mov    (%eax),%eax
  8007e4:	8d 50 04             	lea    0x4(%eax),%edx
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	89 10                	mov    %edx,(%eax)
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	8b 00                	mov    (%eax),%eax
  8007f1:	83 e8 04             	sub    $0x4,%eax
  8007f4:	8b 00                	mov    (%eax),%eax
  8007f6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007fb:	5d                   	pop    %ebp
  8007fc:	c3                   	ret    

008007fd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007fd:	55                   	push   %ebp
  8007fe:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800800:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800804:	7e 1c                	jle    800822 <getint+0x25>
		return va_arg(*ap, long long);
  800806:	8b 45 08             	mov    0x8(%ebp),%eax
  800809:	8b 00                	mov    (%eax),%eax
  80080b:	8d 50 08             	lea    0x8(%eax),%edx
  80080e:	8b 45 08             	mov    0x8(%ebp),%eax
  800811:	89 10                	mov    %edx,(%eax)
  800813:	8b 45 08             	mov    0x8(%ebp),%eax
  800816:	8b 00                	mov    (%eax),%eax
  800818:	83 e8 08             	sub    $0x8,%eax
  80081b:	8b 50 04             	mov    0x4(%eax),%edx
  80081e:	8b 00                	mov    (%eax),%eax
  800820:	eb 38                	jmp    80085a <getint+0x5d>
	else if (lflag)
  800822:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800826:	74 1a                	je     800842 <getint+0x45>
		return va_arg(*ap, long);
  800828:	8b 45 08             	mov    0x8(%ebp),%eax
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	8d 50 04             	lea    0x4(%eax),%edx
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	89 10                	mov    %edx,(%eax)
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	8b 00                	mov    (%eax),%eax
  80083a:	83 e8 04             	sub    $0x4,%eax
  80083d:	8b 00                	mov    (%eax),%eax
  80083f:	99                   	cltd   
  800840:	eb 18                	jmp    80085a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	8d 50 04             	lea    0x4(%eax),%edx
  80084a:	8b 45 08             	mov    0x8(%ebp),%eax
  80084d:	89 10                	mov    %edx,(%eax)
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	8b 00                	mov    (%eax),%eax
  800854:	83 e8 04             	sub    $0x4,%eax
  800857:	8b 00                	mov    (%eax),%eax
  800859:	99                   	cltd   
}
  80085a:	5d                   	pop    %ebp
  80085b:	c3                   	ret    

0080085c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80085c:	55                   	push   %ebp
  80085d:	89 e5                	mov    %esp,%ebp
  80085f:	56                   	push   %esi
  800860:	53                   	push   %ebx
  800861:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800864:	eb 17                	jmp    80087d <vprintfmt+0x21>
			if (ch == '\0')
  800866:	85 db                	test   %ebx,%ebx
  800868:	0f 84 af 03 00 00    	je     800c1d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80086e:	83 ec 08             	sub    $0x8,%esp
  800871:	ff 75 0c             	pushl  0xc(%ebp)
  800874:	53                   	push   %ebx
  800875:	8b 45 08             	mov    0x8(%ebp),%eax
  800878:	ff d0                	call   *%eax
  80087a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80087d:	8b 45 10             	mov    0x10(%ebp),%eax
  800880:	8d 50 01             	lea    0x1(%eax),%edx
  800883:	89 55 10             	mov    %edx,0x10(%ebp)
  800886:	8a 00                	mov    (%eax),%al
  800888:	0f b6 d8             	movzbl %al,%ebx
  80088b:	83 fb 25             	cmp    $0x25,%ebx
  80088e:	75 d6                	jne    800866 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800890:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800894:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80089b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008a2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008a9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b3:	8d 50 01             	lea    0x1(%eax),%edx
  8008b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8008b9:	8a 00                	mov    (%eax),%al
  8008bb:	0f b6 d8             	movzbl %al,%ebx
  8008be:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008c1:	83 f8 55             	cmp    $0x55,%eax
  8008c4:	0f 87 2b 03 00 00    	ja     800bf5 <vprintfmt+0x399>
  8008ca:	8b 04 85 f8 22 80 00 	mov    0x8022f8(,%eax,4),%eax
  8008d1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008d3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008d7:	eb d7                	jmp    8008b0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008d9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008dd:	eb d1                	jmp    8008b0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008df:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008e6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008e9:	89 d0                	mov    %edx,%eax
  8008eb:	c1 e0 02             	shl    $0x2,%eax
  8008ee:	01 d0                	add    %edx,%eax
  8008f0:	01 c0                	add    %eax,%eax
  8008f2:	01 d8                	add    %ebx,%eax
  8008f4:	83 e8 30             	sub    $0x30,%eax
  8008f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8008fd:	8a 00                	mov    (%eax),%al
  8008ff:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800902:	83 fb 2f             	cmp    $0x2f,%ebx
  800905:	7e 3e                	jle    800945 <vprintfmt+0xe9>
  800907:	83 fb 39             	cmp    $0x39,%ebx
  80090a:	7f 39                	jg     800945 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80090c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80090f:	eb d5                	jmp    8008e6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800911:	8b 45 14             	mov    0x14(%ebp),%eax
  800914:	83 c0 04             	add    $0x4,%eax
  800917:	89 45 14             	mov    %eax,0x14(%ebp)
  80091a:	8b 45 14             	mov    0x14(%ebp),%eax
  80091d:	83 e8 04             	sub    $0x4,%eax
  800920:	8b 00                	mov    (%eax),%eax
  800922:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800925:	eb 1f                	jmp    800946 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800927:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092b:	79 83                	jns    8008b0 <vprintfmt+0x54>
				width = 0;
  80092d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800934:	e9 77 ff ff ff       	jmp    8008b0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800939:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800940:	e9 6b ff ff ff       	jmp    8008b0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800945:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800946:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80094a:	0f 89 60 ff ff ff    	jns    8008b0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800950:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800953:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800956:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80095d:	e9 4e ff ff ff       	jmp    8008b0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800962:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800965:	e9 46 ff ff ff       	jmp    8008b0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80096a:	8b 45 14             	mov    0x14(%ebp),%eax
  80096d:	83 c0 04             	add    $0x4,%eax
  800970:	89 45 14             	mov    %eax,0x14(%ebp)
  800973:	8b 45 14             	mov    0x14(%ebp),%eax
  800976:	83 e8 04             	sub    $0x4,%eax
  800979:	8b 00                	mov    (%eax),%eax
  80097b:	83 ec 08             	sub    $0x8,%esp
  80097e:	ff 75 0c             	pushl  0xc(%ebp)
  800981:	50                   	push   %eax
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
			break;
  80098a:	e9 89 02 00 00       	jmp    800c18 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80098f:	8b 45 14             	mov    0x14(%ebp),%eax
  800992:	83 c0 04             	add    $0x4,%eax
  800995:	89 45 14             	mov    %eax,0x14(%ebp)
  800998:	8b 45 14             	mov    0x14(%ebp),%eax
  80099b:	83 e8 04             	sub    $0x4,%eax
  80099e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009a0:	85 db                	test   %ebx,%ebx
  8009a2:	79 02                	jns    8009a6 <vprintfmt+0x14a>
				err = -err;
  8009a4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009a6:	83 fb 64             	cmp    $0x64,%ebx
  8009a9:	7f 0b                	jg     8009b6 <vprintfmt+0x15a>
  8009ab:	8b 34 9d 40 21 80 00 	mov    0x802140(,%ebx,4),%esi
  8009b2:	85 f6                	test   %esi,%esi
  8009b4:	75 19                	jne    8009cf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009b6:	53                   	push   %ebx
  8009b7:	68 e5 22 80 00       	push   $0x8022e5
  8009bc:	ff 75 0c             	pushl  0xc(%ebp)
  8009bf:	ff 75 08             	pushl  0x8(%ebp)
  8009c2:	e8 5e 02 00 00       	call   800c25 <printfmt>
  8009c7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009ca:	e9 49 02 00 00       	jmp    800c18 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009cf:	56                   	push   %esi
  8009d0:	68 ee 22 80 00       	push   $0x8022ee
  8009d5:	ff 75 0c             	pushl  0xc(%ebp)
  8009d8:	ff 75 08             	pushl  0x8(%ebp)
  8009db:	e8 45 02 00 00       	call   800c25 <printfmt>
  8009e0:	83 c4 10             	add    $0x10,%esp
			break;
  8009e3:	e9 30 02 00 00       	jmp    800c18 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009eb:	83 c0 04             	add    $0x4,%eax
  8009ee:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f4:	83 e8 04             	sub    $0x4,%eax
  8009f7:	8b 30                	mov    (%eax),%esi
  8009f9:	85 f6                	test   %esi,%esi
  8009fb:	75 05                	jne    800a02 <vprintfmt+0x1a6>
				p = "(null)";
  8009fd:	be f1 22 80 00       	mov    $0x8022f1,%esi
			if (width > 0 && padc != '-')
  800a02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a06:	7e 6d                	jle    800a75 <vprintfmt+0x219>
  800a08:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a0c:	74 67                	je     800a75 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a11:	83 ec 08             	sub    $0x8,%esp
  800a14:	50                   	push   %eax
  800a15:	56                   	push   %esi
  800a16:	e8 0c 03 00 00       	call   800d27 <strnlen>
  800a1b:	83 c4 10             	add    $0x10,%esp
  800a1e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a21:	eb 16                	jmp    800a39 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a23:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a27:	83 ec 08             	sub    $0x8,%esp
  800a2a:	ff 75 0c             	pushl  0xc(%ebp)
  800a2d:	50                   	push   %eax
  800a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a31:	ff d0                	call   *%eax
  800a33:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a36:	ff 4d e4             	decl   -0x1c(%ebp)
  800a39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a3d:	7f e4                	jg     800a23 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a3f:	eb 34                	jmp    800a75 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a41:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a45:	74 1c                	je     800a63 <vprintfmt+0x207>
  800a47:	83 fb 1f             	cmp    $0x1f,%ebx
  800a4a:	7e 05                	jle    800a51 <vprintfmt+0x1f5>
  800a4c:	83 fb 7e             	cmp    $0x7e,%ebx
  800a4f:	7e 12                	jle    800a63 <vprintfmt+0x207>
					putch('?', putdat);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	6a 3f                	push   $0x3f
  800a59:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5c:	ff d0                	call   *%eax
  800a5e:	83 c4 10             	add    $0x10,%esp
  800a61:	eb 0f                	jmp    800a72 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a63:	83 ec 08             	sub    $0x8,%esp
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	53                   	push   %ebx
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	ff d0                	call   *%eax
  800a6f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a72:	ff 4d e4             	decl   -0x1c(%ebp)
  800a75:	89 f0                	mov    %esi,%eax
  800a77:	8d 70 01             	lea    0x1(%eax),%esi
  800a7a:	8a 00                	mov    (%eax),%al
  800a7c:	0f be d8             	movsbl %al,%ebx
  800a7f:	85 db                	test   %ebx,%ebx
  800a81:	74 24                	je     800aa7 <vprintfmt+0x24b>
  800a83:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a87:	78 b8                	js     800a41 <vprintfmt+0x1e5>
  800a89:	ff 4d e0             	decl   -0x20(%ebp)
  800a8c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a90:	79 af                	jns    800a41 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a92:	eb 13                	jmp    800aa7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a94:	83 ec 08             	sub    $0x8,%esp
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	6a 20                	push   $0x20
  800a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9f:	ff d0                	call   *%eax
  800aa1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aa4:	ff 4d e4             	decl   -0x1c(%ebp)
  800aa7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aab:	7f e7                	jg     800a94 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800aad:	e9 66 01 00 00       	jmp    800c18 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ab2:	83 ec 08             	sub    $0x8,%esp
  800ab5:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab8:	8d 45 14             	lea    0x14(%ebp),%eax
  800abb:	50                   	push   %eax
  800abc:	e8 3c fd ff ff       	call   8007fd <getint>
  800ac1:	83 c4 10             	add    $0x10,%esp
  800ac4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800aca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800acd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ad0:	85 d2                	test   %edx,%edx
  800ad2:	79 23                	jns    800af7 <vprintfmt+0x29b>
				putch('-', putdat);
  800ad4:	83 ec 08             	sub    $0x8,%esp
  800ad7:	ff 75 0c             	pushl  0xc(%ebp)
  800ada:	6a 2d                	push   $0x2d
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	ff d0                	call   *%eax
  800ae1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ae4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aea:	f7 d8                	neg    %eax
  800aec:	83 d2 00             	adc    $0x0,%edx
  800aef:	f7 da                	neg    %edx
  800af1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800af7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800afe:	e9 bc 00 00 00       	jmp    800bbf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b03:	83 ec 08             	sub    $0x8,%esp
  800b06:	ff 75 e8             	pushl  -0x18(%ebp)
  800b09:	8d 45 14             	lea    0x14(%ebp),%eax
  800b0c:	50                   	push   %eax
  800b0d:	e8 84 fc ff ff       	call   800796 <getuint>
  800b12:	83 c4 10             	add    $0x10,%esp
  800b15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b18:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b1b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b22:	e9 98 00 00 00       	jmp    800bbf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b27:	83 ec 08             	sub    $0x8,%esp
  800b2a:	ff 75 0c             	pushl  0xc(%ebp)
  800b2d:	6a 58                	push   $0x58
  800b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b32:	ff d0                	call   *%eax
  800b34:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b37:	83 ec 08             	sub    $0x8,%esp
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	6a 58                	push   $0x58
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	ff d0                	call   *%eax
  800b44:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b47:	83 ec 08             	sub    $0x8,%esp
  800b4a:	ff 75 0c             	pushl  0xc(%ebp)
  800b4d:	6a 58                	push   $0x58
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	ff d0                	call   *%eax
  800b54:	83 c4 10             	add    $0x10,%esp
			break;
  800b57:	e9 bc 00 00 00       	jmp    800c18 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b5c:	83 ec 08             	sub    $0x8,%esp
  800b5f:	ff 75 0c             	pushl  0xc(%ebp)
  800b62:	6a 30                	push   $0x30
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	ff d0                	call   *%eax
  800b69:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	6a 78                	push   $0x78
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	ff d0                	call   *%eax
  800b79:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b7f:	83 c0 04             	add    $0x4,%eax
  800b82:	89 45 14             	mov    %eax,0x14(%ebp)
  800b85:	8b 45 14             	mov    0x14(%ebp),%eax
  800b88:	83 e8 04             	sub    $0x4,%eax
  800b8b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b90:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b97:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b9e:	eb 1f                	jmp    800bbf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ba0:	83 ec 08             	sub    $0x8,%esp
  800ba3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ba6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ba9:	50                   	push   %eax
  800baa:	e8 e7 fb ff ff       	call   800796 <getuint>
  800baf:	83 c4 10             	add    $0x10,%esp
  800bb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bb8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bbf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bc3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bc6:	83 ec 04             	sub    $0x4,%esp
  800bc9:	52                   	push   %edx
  800bca:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bcd:	50                   	push   %eax
  800bce:	ff 75 f4             	pushl  -0xc(%ebp)
  800bd1:	ff 75 f0             	pushl  -0x10(%ebp)
  800bd4:	ff 75 0c             	pushl  0xc(%ebp)
  800bd7:	ff 75 08             	pushl  0x8(%ebp)
  800bda:	e8 00 fb ff ff       	call   8006df <printnum>
  800bdf:	83 c4 20             	add    $0x20,%esp
			break;
  800be2:	eb 34                	jmp    800c18 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800be4:	83 ec 08             	sub    $0x8,%esp
  800be7:	ff 75 0c             	pushl  0xc(%ebp)
  800bea:	53                   	push   %ebx
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	ff d0                	call   *%eax
  800bf0:	83 c4 10             	add    $0x10,%esp
			break;
  800bf3:	eb 23                	jmp    800c18 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bf5:	83 ec 08             	sub    $0x8,%esp
  800bf8:	ff 75 0c             	pushl  0xc(%ebp)
  800bfb:	6a 25                	push   $0x25
  800bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800c00:	ff d0                	call   *%eax
  800c02:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c05:	ff 4d 10             	decl   0x10(%ebp)
  800c08:	eb 03                	jmp    800c0d <vprintfmt+0x3b1>
  800c0a:	ff 4d 10             	decl   0x10(%ebp)
  800c0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c10:	48                   	dec    %eax
  800c11:	8a 00                	mov    (%eax),%al
  800c13:	3c 25                	cmp    $0x25,%al
  800c15:	75 f3                	jne    800c0a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c17:	90                   	nop
		}
	}
  800c18:	e9 47 fc ff ff       	jmp    800864 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c1d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c21:	5b                   	pop    %ebx
  800c22:	5e                   	pop    %esi
  800c23:	5d                   	pop    %ebp
  800c24:	c3                   	ret    

00800c25 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c25:	55                   	push   %ebp
  800c26:	89 e5                	mov    %esp,%ebp
  800c28:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c2b:	8d 45 10             	lea    0x10(%ebp),%eax
  800c2e:	83 c0 04             	add    $0x4,%eax
  800c31:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c34:	8b 45 10             	mov    0x10(%ebp),%eax
  800c37:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3a:	50                   	push   %eax
  800c3b:	ff 75 0c             	pushl  0xc(%ebp)
  800c3e:	ff 75 08             	pushl  0x8(%ebp)
  800c41:	e8 16 fc ff ff       	call   80085c <vprintfmt>
  800c46:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c49:	90                   	nop
  800c4a:	c9                   	leave  
  800c4b:	c3                   	ret    

00800c4c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c4c:	55                   	push   %ebp
  800c4d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c52:	8b 40 08             	mov    0x8(%eax),%eax
  800c55:	8d 50 01             	lea    0x1(%eax),%edx
  800c58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c61:	8b 10                	mov    (%eax),%edx
  800c63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c66:	8b 40 04             	mov    0x4(%eax),%eax
  800c69:	39 c2                	cmp    %eax,%edx
  800c6b:	73 12                	jae    800c7f <sprintputch+0x33>
		*b->buf++ = ch;
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	8b 00                	mov    (%eax),%eax
  800c72:	8d 48 01             	lea    0x1(%eax),%ecx
  800c75:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c78:	89 0a                	mov    %ecx,(%edx)
  800c7a:	8b 55 08             	mov    0x8(%ebp),%edx
  800c7d:	88 10                	mov    %dl,(%eax)
}
  800c7f:	90                   	nop
  800c80:	5d                   	pop    %ebp
  800c81:	c3                   	ret    

00800c82 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c82:	55                   	push   %ebp
  800c83:	89 e5                	mov    %esp,%ebp
  800c85:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c91:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	01 d0                	add    %edx,%eax
  800c99:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ca3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ca7:	74 06                	je     800caf <vsnprintf+0x2d>
  800ca9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cad:	7f 07                	jg     800cb6 <vsnprintf+0x34>
		return -E_INVAL;
  800caf:	b8 03 00 00 00       	mov    $0x3,%eax
  800cb4:	eb 20                	jmp    800cd6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cb6:	ff 75 14             	pushl  0x14(%ebp)
  800cb9:	ff 75 10             	pushl  0x10(%ebp)
  800cbc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cbf:	50                   	push   %eax
  800cc0:	68 4c 0c 80 00       	push   $0x800c4c
  800cc5:	e8 92 fb ff ff       	call   80085c <vprintfmt>
  800cca:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ccd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cd0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cd6:	c9                   	leave  
  800cd7:	c3                   	ret    

00800cd8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cd8:	55                   	push   %ebp
  800cd9:	89 e5                	mov    %esp,%ebp
  800cdb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cde:	8d 45 10             	lea    0x10(%ebp),%eax
  800ce1:	83 c0 04             	add    $0x4,%eax
  800ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ce7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cea:	ff 75 f4             	pushl  -0xc(%ebp)
  800ced:	50                   	push   %eax
  800cee:	ff 75 0c             	pushl  0xc(%ebp)
  800cf1:	ff 75 08             	pushl  0x8(%ebp)
  800cf4:	e8 89 ff ff ff       	call   800c82 <vsnprintf>
  800cf9:	83 c4 10             	add    $0x10,%esp
  800cfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d02:	c9                   	leave  
  800d03:	c3                   	ret    

00800d04 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d04:	55                   	push   %ebp
  800d05:	89 e5                	mov    %esp,%ebp
  800d07:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d11:	eb 06                	jmp    800d19 <strlen+0x15>
		n++;
  800d13:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d16:	ff 45 08             	incl   0x8(%ebp)
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	84 c0                	test   %al,%al
  800d20:	75 f1                	jne    800d13 <strlen+0xf>
		n++;
	return n;
  800d22:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d25:	c9                   	leave  
  800d26:	c3                   	ret    

00800d27 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d27:	55                   	push   %ebp
  800d28:	89 e5                	mov    %esp,%ebp
  800d2a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d2d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d34:	eb 09                	jmp    800d3f <strnlen+0x18>
		n++;
  800d36:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d39:	ff 45 08             	incl   0x8(%ebp)
  800d3c:	ff 4d 0c             	decl   0xc(%ebp)
  800d3f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d43:	74 09                	je     800d4e <strnlen+0x27>
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8a 00                	mov    (%eax),%al
  800d4a:	84 c0                	test   %al,%al
  800d4c:	75 e8                	jne    800d36 <strnlen+0xf>
		n++;
	return n;
  800d4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d51:	c9                   	leave  
  800d52:	c3                   	ret    

00800d53 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d53:	55                   	push   %ebp
  800d54:	89 e5                	mov    %esp,%ebp
  800d56:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d5f:	90                   	nop
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	8d 50 01             	lea    0x1(%eax),%edx
  800d66:	89 55 08             	mov    %edx,0x8(%ebp)
  800d69:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d6c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d6f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d72:	8a 12                	mov    (%edx),%dl
  800d74:	88 10                	mov    %dl,(%eax)
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	84 c0                	test   %al,%al
  800d7a:	75 e4                	jne    800d60 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d7f:	c9                   	leave  
  800d80:	c3                   	ret    

00800d81 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d81:	55                   	push   %ebp
  800d82:	89 e5                	mov    %esp,%ebp
  800d84:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d8d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d94:	eb 1f                	jmp    800db5 <strncpy+0x34>
		*dst++ = *src;
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	8d 50 01             	lea    0x1(%eax),%edx
  800d9c:	89 55 08             	mov    %edx,0x8(%ebp)
  800d9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da2:	8a 12                	mov    (%edx),%dl
  800da4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800da6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da9:	8a 00                	mov    (%eax),%al
  800dab:	84 c0                	test   %al,%al
  800dad:	74 03                	je     800db2 <strncpy+0x31>
			src++;
  800daf:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800db2:	ff 45 fc             	incl   -0x4(%ebp)
  800db5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dbb:	72 d9                	jb     800d96 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dc0:	c9                   	leave  
  800dc1:	c3                   	ret    

00800dc2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dc2:	55                   	push   %ebp
  800dc3:	89 e5                	mov    %esp,%ebp
  800dc5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd2:	74 30                	je     800e04 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dd4:	eb 16                	jmp    800dec <strlcpy+0x2a>
			*dst++ = *src++;
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8d 50 01             	lea    0x1(%eax),%edx
  800ddc:	89 55 08             	mov    %edx,0x8(%ebp)
  800ddf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800de2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800de5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800de8:	8a 12                	mov    (%edx),%dl
  800dea:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dec:	ff 4d 10             	decl   0x10(%ebp)
  800def:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800df3:	74 09                	je     800dfe <strlcpy+0x3c>
  800df5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df8:	8a 00                	mov    (%eax),%al
  800dfa:	84 c0                	test   %al,%al
  800dfc:	75 d8                	jne    800dd6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800e01:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e04:	8b 55 08             	mov    0x8(%ebp),%edx
  800e07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e0a:	29 c2                	sub    %eax,%edx
  800e0c:	89 d0                	mov    %edx,%eax
}
  800e0e:	c9                   	leave  
  800e0f:	c3                   	ret    

00800e10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e10:	55                   	push   %ebp
  800e11:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e13:	eb 06                	jmp    800e1b <strcmp+0xb>
		p++, q++;
  800e15:	ff 45 08             	incl   0x8(%ebp)
  800e18:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	8a 00                	mov    (%eax),%al
  800e20:	84 c0                	test   %al,%al
  800e22:	74 0e                	je     800e32 <strcmp+0x22>
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	8a 10                	mov    (%eax),%dl
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	38 c2                	cmp    %al,%dl
  800e30:	74 e3                	je     800e15 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	8a 00                	mov    (%eax),%al
  800e37:	0f b6 d0             	movzbl %al,%edx
  800e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	0f b6 c0             	movzbl %al,%eax
  800e42:	29 c2                	sub    %eax,%edx
  800e44:	89 d0                	mov    %edx,%eax
}
  800e46:	5d                   	pop    %ebp
  800e47:	c3                   	ret    

00800e48 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e48:	55                   	push   %ebp
  800e49:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e4b:	eb 09                	jmp    800e56 <strncmp+0xe>
		n--, p++, q++;
  800e4d:	ff 4d 10             	decl   0x10(%ebp)
  800e50:	ff 45 08             	incl   0x8(%ebp)
  800e53:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e5a:	74 17                	je     800e73 <strncmp+0x2b>
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	84 c0                	test   %al,%al
  800e63:	74 0e                	je     800e73 <strncmp+0x2b>
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	8a 10                	mov    (%eax),%dl
  800e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6d:	8a 00                	mov    (%eax),%al
  800e6f:	38 c2                	cmp    %al,%dl
  800e71:	74 da                	je     800e4d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e73:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e77:	75 07                	jne    800e80 <strncmp+0x38>
		return 0;
  800e79:	b8 00 00 00 00       	mov    $0x0,%eax
  800e7e:	eb 14                	jmp    800e94 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	8a 00                	mov    (%eax),%al
  800e85:	0f b6 d0             	movzbl %al,%edx
  800e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8b:	8a 00                	mov    (%eax),%al
  800e8d:	0f b6 c0             	movzbl %al,%eax
  800e90:	29 c2                	sub    %eax,%edx
  800e92:	89 d0                	mov    %edx,%eax
}
  800e94:	5d                   	pop    %ebp
  800e95:	c3                   	ret    

00800e96 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e96:	55                   	push   %ebp
  800e97:	89 e5                	mov    %esp,%ebp
  800e99:	83 ec 04             	sub    $0x4,%esp
  800e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ea2:	eb 12                	jmp    800eb6 <strchr+0x20>
		if (*s == c)
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	8a 00                	mov    (%eax),%al
  800ea9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eac:	75 05                	jne    800eb3 <strchr+0x1d>
			return (char *) s;
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	eb 11                	jmp    800ec4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800eb3:	ff 45 08             	incl   0x8(%ebp)
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	8a 00                	mov    (%eax),%al
  800ebb:	84 c0                	test   %al,%al
  800ebd:	75 e5                	jne    800ea4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ebf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ec4:	c9                   	leave  
  800ec5:	c3                   	ret    

00800ec6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ec6:	55                   	push   %ebp
  800ec7:	89 e5                	mov    %esp,%ebp
  800ec9:	83 ec 04             	sub    $0x4,%esp
  800ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ed2:	eb 0d                	jmp    800ee1 <strfind+0x1b>
		if (*s == c)
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	8a 00                	mov    (%eax),%al
  800ed9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800edc:	74 0e                	je     800eec <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ede:	ff 45 08             	incl   0x8(%ebp)
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	84 c0                	test   %al,%al
  800ee8:	75 ea                	jne    800ed4 <strfind+0xe>
  800eea:	eb 01                	jmp    800eed <strfind+0x27>
		if (*s == c)
			break;
  800eec:	90                   	nop
	return (char *) s;
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef0:	c9                   	leave  
  800ef1:	c3                   	ret    

00800ef2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ef2:	55                   	push   %ebp
  800ef3:	89 e5                	mov    %esp,%ebp
  800ef5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800efe:	8b 45 10             	mov    0x10(%ebp),%eax
  800f01:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f04:	eb 0e                	jmp    800f14 <memset+0x22>
		*p++ = c;
  800f06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f09:	8d 50 01             	lea    0x1(%eax),%edx
  800f0c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f12:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f14:	ff 4d f8             	decl   -0x8(%ebp)
  800f17:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f1b:	79 e9                	jns    800f06 <memset+0x14>
		*p++ = c;

	return v;
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f20:	c9                   	leave  
  800f21:	c3                   	ret    

00800f22 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f22:	55                   	push   %ebp
  800f23:	89 e5                	mov    %esp,%ebp
  800f25:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f34:	eb 16                	jmp    800f4c <memcpy+0x2a>
		*d++ = *s++;
  800f36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f39:	8d 50 01             	lea    0x1(%eax),%edx
  800f3c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f42:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f45:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f48:	8a 12                	mov    (%edx),%dl
  800f4a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f52:	89 55 10             	mov    %edx,0x10(%ebp)
  800f55:	85 c0                	test   %eax,%eax
  800f57:	75 dd                	jne    800f36 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f5c:	c9                   	leave  
  800f5d:	c3                   	ret    

00800f5e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f5e:	55                   	push   %ebp
  800f5f:	89 e5                	mov    %esp,%ebp
  800f61:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f73:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f76:	73 50                	jae    800fc8 <memmove+0x6a>
  800f78:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7e:	01 d0                	add    %edx,%eax
  800f80:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f83:	76 43                	jbe    800fc8 <memmove+0x6a>
		s += n;
  800f85:	8b 45 10             	mov    0x10(%ebp),%eax
  800f88:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f91:	eb 10                	jmp    800fa3 <memmove+0x45>
			*--d = *--s;
  800f93:	ff 4d f8             	decl   -0x8(%ebp)
  800f96:	ff 4d fc             	decl   -0x4(%ebp)
  800f99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9c:	8a 10                	mov    (%eax),%dl
  800f9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fa3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa9:	89 55 10             	mov    %edx,0x10(%ebp)
  800fac:	85 c0                	test   %eax,%eax
  800fae:	75 e3                	jne    800f93 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fb0:	eb 23                	jmp    800fd5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb5:	8d 50 01             	lea    0x1(%eax),%edx
  800fb8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fbb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fbe:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fc1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fc4:	8a 12                	mov    (%edx),%dl
  800fc6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fce:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd1:	85 c0                	test   %eax,%eax
  800fd3:	75 dd                	jne    800fb2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd8:	c9                   	leave  
  800fd9:	c3                   	ret    

00800fda <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fda:	55                   	push   %ebp
  800fdb:	89 e5                	mov    %esp,%ebp
  800fdd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800fec:	eb 2a                	jmp    801018 <memcmp+0x3e>
		if (*s1 != *s2)
  800fee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff1:	8a 10                	mov    (%eax),%dl
  800ff3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	38 c2                	cmp    %al,%dl
  800ffa:	74 16                	je     801012 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ffc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	0f b6 d0             	movzbl %al,%edx
  801004:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	0f b6 c0             	movzbl %al,%eax
  80100c:	29 c2                	sub    %eax,%edx
  80100e:	89 d0                	mov    %edx,%eax
  801010:	eb 18                	jmp    80102a <memcmp+0x50>
		s1++, s2++;
  801012:	ff 45 fc             	incl   -0x4(%ebp)
  801015:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801018:	8b 45 10             	mov    0x10(%ebp),%eax
  80101b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80101e:	89 55 10             	mov    %edx,0x10(%ebp)
  801021:	85 c0                	test   %eax,%eax
  801023:	75 c9                	jne    800fee <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801025:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80102a:	c9                   	leave  
  80102b:	c3                   	ret    

0080102c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80102c:	55                   	push   %ebp
  80102d:	89 e5                	mov    %esp,%ebp
  80102f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801032:	8b 55 08             	mov    0x8(%ebp),%edx
  801035:	8b 45 10             	mov    0x10(%ebp),%eax
  801038:	01 d0                	add    %edx,%eax
  80103a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80103d:	eb 15                	jmp    801054 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	0f b6 d0             	movzbl %al,%edx
  801047:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104a:	0f b6 c0             	movzbl %al,%eax
  80104d:	39 c2                	cmp    %eax,%edx
  80104f:	74 0d                	je     80105e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801051:	ff 45 08             	incl   0x8(%ebp)
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80105a:	72 e3                	jb     80103f <memfind+0x13>
  80105c:	eb 01                	jmp    80105f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80105e:	90                   	nop
	return (void *) s;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801062:	c9                   	leave  
  801063:	c3                   	ret    

00801064 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801064:	55                   	push   %ebp
  801065:	89 e5                	mov    %esp,%ebp
  801067:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80106a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801071:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801078:	eb 03                	jmp    80107d <strtol+0x19>
		s++;
  80107a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	8a 00                	mov    (%eax),%al
  801082:	3c 20                	cmp    $0x20,%al
  801084:	74 f4                	je     80107a <strtol+0x16>
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	8a 00                	mov    (%eax),%al
  80108b:	3c 09                	cmp    $0x9,%al
  80108d:	74 eb                	je     80107a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	3c 2b                	cmp    $0x2b,%al
  801096:	75 05                	jne    80109d <strtol+0x39>
		s++;
  801098:	ff 45 08             	incl   0x8(%ebp)
  80109b:	eb 13                	jmp    8010b0 <strtol+0x4c>
	else if (*s == '-')
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	8a 00                	mov    (%eax),%al
  8010a2:	3c 2d                	cmp    $0x2d,%al
  8010a4:	75 0a                	jne    8010b0 <strtol+0x4c>
		s++, neg = 1;
  8010a6:	ff 45 08             	incl   0x8(%ebp)
  8010a9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b4:	74 06                	je     8010bc <strtol+0x58>
  8010b6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010ba:	75 20                	jne    8010dc <strtol+0x78>
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	3c 30                	cmp    $0x30,%al
  8010c3:	75 17                	jne    8010dc <strtol+0x78>
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	40                   	inc    %eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	3c 78                	cmp    $0x78,%al
  8010cd:	75 0d                	jne    8010dc <strtol+0x78>
		s += 2, base = 16;
  8010cf:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010d3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010da:	eb 28                	jmp    801104 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e0:	75 15                	jne    8010f7 <strtol+0x93>
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	3c 30                	cmp    $0x30,%al
  8010e9:	75 0c                	jne    8010f7 <strtol+0x93>
		s++, base = 8;
  8010eb:	ff 45 08             	incl   0x8(%ebp)
  8010ee:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010f5:	eb 0d                	jmp    801104 <strtol+0xa0>
	else if (base == 0)
  8010f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fb:	75 07                	jne    801104 <strtol+0xa0>
		base = 10;
  8010fd:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	3c 2f                	cmp    $0x2f,%al
  80110b:	7e 19                	jle    801126 <strtol+0xc2>
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8a 00                	mov    (%eax),%al
  801112:	3c 39                	cmp    $0x39,%al
  801114:	7f 10                	jg     801126 <strtol+0xc2>
			dig = *s - '0';
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	8a 00                	mov    (%eax),%al
  80111b:	0f be c0             	movsbl %al,%eax
  80111e:	83 e8 30             	sub    $0x30,%eax
  801121:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801124:	eb 42                	jmp    801168 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	3c 60                	cmp    $0x60,%al
  80112d:	7e 19                	jle    801148 <strtol+0xe4>
  80112f:	8b 45 08             	mov    0x8(%ebp),%eax
  801132:	8a 00                	mov    (%eax),%al
  801134:	3c 7a                	cmp    $0x7a,%al
  801136:	7f 10                	jg     801148 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	8a 00                	mov    (%eax),%al
  80113d:	0f be c0             	movsbl %al,%eax
  801140:	83 e8 57             	sub    $0x57,%eax
  801143:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801146:	eb 20                	jmp    801168 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	3c 40                	cmp    $0x40,%al
  80114f:	7e 39                	jle    80118a <strtol+0x126>
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	3c 5a                	cmp    $0x5a,%al
  801158:	7f 30                	jg     80118a <strtol+0x126>
			dig = *s - 'A' + 10;
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	0f be c0             	movsbl %al,%eax
  801162:	83 e8 37             	sub    $0x37,%eax
  801165:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801168:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80116b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80116e:	7d 19                	jge    801189 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801170:	ff 45 08             	incl   0x8(%ebp)
  801173:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801176:	0f af 45 10          	imul   0x10(%ebp),%eax
  80117a:	89 c2                	mov    %eax,%edx
  80117c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80117f:	01 d0                	add    %edx,%eax
  801181:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801184:	e9 7b ff ff ff       	jmp    801104 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801189:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80118a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80118e:	74 08                	je     801198 <strtol+0x134>
		*endptr = (char *) s;
  801190:	8b 45 0c             	mov    0xc(%ebp),%eax
  801193:	8b 55 08             	mov    0x8(%ebp),%edx
  801196:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801198:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80119c:	74 07                	je     8011a5 <strtol+0x141>
  80119e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a1:	f7 d8                	neg    %eax
  8011a3:	eb 03                	jmp    8011a8 <strtol+0x144>
  8011a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <ltostr>:

void
ltostr(long value, char *str)
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
  8011ad:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011be:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c2:	79 13                	jns    8011d7 <ltostr+0x2d>
	{
		neg = 1;
  8011c4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ce:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011d1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011d4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011da:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011df:	99                   	cltd   
  8011e0:	f7 f9                	idiv   %ecx
  8011e2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e8:	8d 50 01             	lea    0x1(%eax),%edx
  8011eb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011ee:	89 c2                	mov    %eax,%edx
  8011f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f3:	01 d0                	add    %edx,%eax
  8011f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f8:	83 c2 30             	add    $0x30,%edx
  8011fb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801200:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801205:	f7 e9                	imul   %ecx
  801207:	c1 fa 02             	sar    $0x2,%edx
  80120a:	89 c8                	mov    %ecx,%eax
  80120c:	c1 f8 1f             	sar    $0x1f,%eax
  80120f:	29 c2                	sub    %eax,%edx
  801211:	89 d0                	mov    %edx,%eax
  801213:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801216:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801219:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80121e:	f7 e9                	imul   %ecx
  801220:	c1 fa 02             	sar    $0x2,%edx
  801223:	89 c8                	mov    %ecx,%eax
  801225:	c1 f8 1f             	sar    $0x1f,%eax
  801228:	29 c2                	sub    %eax,%edx
  80122a:	89 d0                	mov    %edx,%eax
  80122c:	c1 e0 02             	shl    $0x2,%eax
  80122f:	01 d0                	add    %edx,%eax
  801231:	01 c0                	add    %eax,%eax
  801233:	29 c1                	sub    %eax,%ecx
  801235:	89 ca                	mov    %ecx,%edx
  801237:	85 d2                	test   %edx,%edx
  801239:	75 9c                	jne    8011d7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80123b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801242:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801245:	48                   	dec    %eax
  801246:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801249:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80124d:	74 3d                	je     80128c <ltostr+0xe2>
		start = 1 ;
  80124f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801256:	eb 34                	jmp    80128c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801258:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80125b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125e:	01 d0                	add    %edx,%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801265:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126b:	01 c2                	add    %eax,%edx
  80126d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801270:	8b 45 0c             	mov    0xc(%ebp),%eax
  801273:	01 c8                	add    %ecx,%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801279:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80127c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127f:	01 c2                	add    %eax,%edx
  801281:	8a 45 eb             	mov    -0x15(%ebp),%al
  801284:	88 02                	mov    %al,(%edx)
		start++ ;
  801286:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801289:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80128c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80128f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801292:	7c c4                	jl     801258 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801294:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129a:	01 d0                	add    %edx,%eax
  80129c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80129f:	90                   	nop
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
  8012a5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012a8:	ff 75 08             	pushl  0x8(%ebp)
  8012ab:	e8 54 fa ff ff       	call   800d04 <strlen>
  8012b0:	83 c4 04             	add    $0x4,%esp
  8012b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012b6:	ff 75 0c             	pushl  0xc(%ebp)
  8012b9:	e8 46 fa ff ff       	call   800d04 <strlen>
  8012be:	83 c4 04             	add    $0x4,%esp
  8012c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012d2:	eb 17                	jmp    8012eb <strcconcat+0x49>
		final[s] = str1[s] ;
  8012d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012da:	01 c2                	add    %eax,%edx
  8012dc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	01 c8                	add    %ecx,%eax
  8012e4:	8a 00                	mov    (%eax),%al
  8012e6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012e8:	ff 45 fc             	incl   -0x4(%ebp)
  8012eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012f1:	7c e1                	jl     8012d4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012fa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801301:	eb 1f                	jmp    801322 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801303:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801306:	8d 50 01             	lea    0x1(%eax),%edx
  801309:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80130c:	89 c2                	mov    %eax,%edx
  80130e:	8b 45 10             	mov    0x10(%ebp),%eax
  801311:	01 c2                	add    %eax,%edx
  801313:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801316:	8b 45 0c             	mov    0xc(%ebp),%eax
  801319:	01 c8                	add    %ecx,%eax
  80131b:	8a 00                	mov    (%eax),%al
  80131d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80131f:	ff 45 f8             	incl   -0x8(%ebp)
  801322:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801325:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801328:	7c d9                	jl     801303 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80132a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80132d:	8b 45 10             	mov    0x10(%ebp),%eax
  801330:	01 d0                	add    %edx,%eax
  801332:	c6 00 00             	movb   $0x0,(%eax)
}
  801335:	90                   	nop
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80133b:	8b 45 14             	mov    0x14(%ebp),%eax
  80133e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801344:	8b 45 14             	mov    0x14(%ebp),%eax
  801347:	8b 00                	mov    (%eax),%eax
  801349:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801350:	8b 45 10             	mov    0x10(%ebp),%eax
  801353:	01 d0                	add    %edx,%eax
  801355:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80135b:	eb 0c                	jmp    801369 <strsplit+0x31>
			*string++ = 0;
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8d 50 01             	lea    0x1(%eax),%edx
  801363:	89 55 08             	mov    %edx,0x8(%ebp)
  801366:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	8a 00                	mov    (%eax),%al
  80136e:	84 c0                	test   %al,%al
  801370:	74 18                	je     80138a <strsplit+0x52>
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	0f be c0             	movsbl %al,%eax
  80137a:	50                   	push   %eax
  80137b:	ff 75 0c             	pushl  0xc(%ebp)
  80137e:	e8 13 fb ff ff       	call   800e96 <strchr>
  801383:	83 c4 08             	add    $0x8,%esp
  801386:	85 c0                	test   %eax,%eax
  801388:	75 d3                	jne    80135d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	8a 00                	mov    (%eax),%al
  80138f:	84 c0                	test   %al,%al
  801391:	74 5a                	je     8013ed <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801393:	8b 45 14             	mov    0x14(%ebp),%eax
  801396:	8b 00                	mov    (%eax),%eax
  801398:	83 f8 0f             	cmp    $0xf,%eax
  80139b:	75 07                	jne    8013a4 <strsplit+0x6c>
		{
			return 0;
  80139d:	b8 00 00 00 00       	mov    $0x0,%eax
  8013a2:	eb 66                	jmp    80140a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a7:	8b 00                	mov    (%eax),%eax
  8013a9:	8d 48 01             	lea    0x1(%eax),%ecx
  8013ac:	8b 55 14             	mov    0x14(%ebp),%edx
  8013af:	89 0a                	mov    %ecx,(%edx)
  8013b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013bb:	01 c2                	add    %eax,%edx
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013c2:	eb 03                	jmp    8013c7 <strsplit+0x8f>
			string++;
  8013c4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	84 c0                	test   %al,%al
  8013ce:	74 8b                	je     80135b <strsplit+0x23>
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	8a 00                	mov    (%eax),%al
  8013d5:	0f be c0             	movsbl %al,%eax
  8013d8:	50                   	push   %eax
  8013d9:	ff 75 0c             	pushl  0xc(%ebp)
  8013dc:	e8 b5 fa ff ff       	call   800e96 <strchr>
  8013e1:	83 c4 08             	add    $0x8,%esp
  8013e4:	85 c0                	test   %eax,%eax
  8013e6:	74 dc                	je     8013c4 <strsplit+0x8c>
			string++;
	}
  8013e8:	e9 6e ff ff ff       	jmp    80135b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013ed:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8013f1:	8b 00                	mov    (%eax),%eax
  8013f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fd:	01 d0                	add    %edx,%eax
  8013ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801405:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
  80140f:	57                   	push   %edi
  801410:	56                   	push   %esi
  801411:	53                   	push   %ebx
  801412:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80141e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801421:	8b 7d 18             	mov    0x18(%ebp),%edi
  801424:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801427:	cd 30                	int    $0x30
  801429:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80142c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80142f:	83 c4 10             	add    $0x10,%esp
  801432:	5b                   	pop    %ebx
  801433:	5e                   	pop    %esi
  801434:	5f                   	pop    %edi
  801435:	5d                   	pop    %ebp
  801436:	c3                   	ret    

00801437 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801437:	55                   	push   %ebp
  801438:	89 e5                	mov    %esp,%ebp
  80143a:	83 ec 04             	sub    $0x4,%esp
  80143d:	8b 45 10             	mov    0x10(%ebp),%eax
  801440:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801443:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	52                   	push   %edx
  80144f:	ff 75 0c             	pushl  0xc(%ebp)
  801452:	50                   	push   %eax
  801453:	6a 00                	push   $0x0
  801455:	e8 b2 ff ff ff       	call   80140c <syscall>
  80145a:	83 c4 18             	add    $0x18,%esp
}
  80145d:	90                   	nop
  80145e:	c9                   	leave  
  80145f:	c3                   	ret    

00801460 <sys_cgetc>:

int
sys_cgetc(void)
{
  801460:	55                   	push   %ebp
  801461:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 01                	push   $0x1
  80146f:	e8 98 ff ff ff       	call   80140c <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	50                   	push   %eax
  801488:	6a 05                	push   $0x5
  80148a:	e8 7d ff ff ff       	call   80140c <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 02                	push   $0x2
  8014a3:	e8 64 ff ff ff       	call   80140c <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
}
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 03                	push   $0x3
  8014bc:	e8 4b ff ff ff       	call   80140c <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 04                	push   $0x4
  8014d5:	e8 32 ff ff ff       	call   80140c <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <sys_env_exit>:


void sys_env_exit(void)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 06                	push   $0x6
  8014ee:	e8 19 ff ff ff       	call   80140c <syscall>
  8014f3:	83 c4 18             	add    $0x18,%esp
}
  8014f6:	90                   	nop
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8014fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	52                   	push   %edx
  801509:	50                   	push   %eax
  80150a:	6a 07                	push   $0x7
  80150c:	e8 fb fe ff ff       	call   80140c <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
  801519:	56                   	push   %esi
  80151a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80151b:	8b 75 18             	mov    0x18(%ebp),%esi
  80151e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801521:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801524:	8b 55 0c             	mov    0xc(%ebp),%edx
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	56                   	push   %esi
  80152b:	53                   	push   %ebx
  80152c:	51                   	push   %ecx
  80152d:	52                   	push   %edx
  80152e:	50                   	push   %eax
  80152f:	6a 08                	push   $0x8
  801531:	e8 d6 fe ff ff       	call   80140c <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
}
  801539:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80153c:	5b                   	pop    %ebx
  80153d:	5e                   	pop    %esi
  80153e:	5d                   	pop    %ebp
  80153f:	c3                   	ret    

00801540 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801543:	8b 55 0c             	mov    0xc(%ebp),%edx
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	52                   	push   %edx
  801550:	50                   	push   %eax
  801551:	6a 09                	push   $0x9
  801553:	e8 b4 fe ff ff       	call   80140c <syscall>
  801558:	83 c4 18             	add    $0x18,%esp
}
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	ff 75 0c             	pushl  0xc(%ebp)
  801569:	ff 75 08             	pushl  0x8(%ebp)
  80156c:	6a 0a                	push   $0xa
  80156e:	e8 99 fe ff ff       	call   80140c <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 0b                	push   $0xb
  801587:	e8 80 fe ff ff       	call   80140c <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
}
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 0c                	push   $0xc
  8015a0:	e8 67 fe ff ff       	call   80140c <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 0d                	push   $0xd
  8015b9:	e8 4e fe ff ff       	call   80140c <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	c9                   	leave  
  8015c2:	c3                   	ret    

008015c3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	ff 75 0c             	pushl  0xc(%ebp)
  8015cf:	ff 75 08             	pushl  0x8(%ebp)
  8015d2:	6a 11                	push   $0x11
  8015d4:	e8 33 fe ff ff       	call   80140c <syscall>
  8015d9:	83 c4 18             	add    $0x18,%esp
	return;
  8015dc:	90                   	nop
}
  8015dd:	c9                   	leave  
  8015de:	c3                   	ret    

008015df <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	ff 75 0c             	pushl  0xc(%ebp)
  8015eb:	ff 75 08             	pushl  0x8(%ebp)
  8015ee:	6a 12                	push   $0x12
  8015f0:	e8 17 fe ff ff       	call   80140c <syscall>
  8015f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8015f8:	90                   	nop
}
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 0e                	push   $0xe
  80160a:	e8 fd fd ff ff       	call   80140c <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
}
  801612:	c9                   	leave  
  801613:	c3                   	ret    

00801614 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	ff 75 08             	pushl  0x8(%ebp)
  801622:	6a 0f                	push   $0xf
  801624:	e8 e3 fd ff ff       	call   80140c <syscall>
  801629:	83 c4 18             	add    $0x18,%esp
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 10                	push   $0x10
  80163d:	e8 ca fd ff ff       	call   80140c <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	90                   	nop
  801646:	c9                   	leave  
  801647:	c3                   	ret    

00801648 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801648:	55                   	push   %ebp
  801649:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	6a 14                	push   $0x14
  801657:	e8 b0 fd ff ff       	call   80140c <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	90                   	nop
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 15                	push   $0x15
  801671:	e8 96 fd ff ff       	call   80140c <syscall>
  801676:	83 c4 18             	add    $0x18,%esp
}
  801679:	90                   	nop
  80167a:	c9                   	leave  
  80167b:	c3                   	ret    

0080167c <sys_cputc>:


void
sys_cputc(const char c)
{
  80167c:	55                   	push   %ebp
  80167d:	89 e5                	mov    %esp,%ebp
  80167f:	83 ec 04             	sub    $0x4,%esp
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801688:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	50                   	push   %eax
  801695:	6a 16                	push   $0x16
  801697:	e8 70 fd ff ff       	call   80140c <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
}
  80169f:	90                   	nop
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 17                	push   $0x17
  8016b1:	e8 56 fd ff ff       	call   80140c <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
}
  8016b9:	90                   	nop
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	ff 75 0c             	pushl  0xc(%ebp)
  8016cb:	50                   	push   %eax
  8016cc:	6a 18                	push   $0x18
  8016ce:	e8 39 fd ff ff       	call   80140c <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	52                   	push   %edx
  8016e8:	50                   	push   %eax
  8016e9:	6a 1b                	push   $0x1b
  8016eb:	e8 1c fd ff ff       	call   80140c <syscall>
  8016f0:	83 c4 18             	add    $0x18,%esp
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	52                   	push   %edx
  801705:	50                   	push   %eax
  801706:	6a 19                	push   $0x19
  801708:	e8 ff fc ff ff       	call   80140c <syscall>
  80170d:	83 c4 18             	add    $0x18,%esp
}
  801710:	90                   	nop
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801716:	8b 55 0c             	mov    0xc(%ebp),%edx
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	52                   	push   %edx
  801723:	50                   	push   %eax
  801724:	6a 1a                	push   $0x1a
  801726:	e8 e1 fc ff ff       	call   80140c <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
}
  80172e:	90                   	nop
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
  801734:	83 ec 04             	sub    $0x4,%esp
  801737:	8b 45 10             	mov    0x10(%ebp),%eax
  80173a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80173d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801740:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	6a 00                	push   $0x0
  801749:	51                   	push   %ecx
  80174a:	52                   	push   %edx
  80174b:	ff 75 0c             	pushl  0xc(%ebp)
  80174e:	50                   	push   %eax
  80174f:	6a 1c                	push   $0x1c
  801751:	e8 b6 fc ff ff       	call   80140c <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80175e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801761:	8b 45 08             	mov    0x8(%ebp),%eax
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	52                   	push   %edx
  80176b:	50                   	push   %eax
  80176c:	6a 1d                	push   $0x1d
  80176e:	e8 99 fc ff ff       	call   80140c <syscall>
  801773:	83 c4 18             	add    $0x18,%esp
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80177b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80177e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	51                   	push   %ecx
  801789:	52                   	push   %edx
  80178a:	50                   	push   %eax
  80178b:	6a 1e                	push   $0x1e
  80178d:	e8 7a fc ff ff       	call   80140c <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80179a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	52                   	push   %edx
  8017a7:	50                   	push   %eax
  8017a8:	6a 1f                	push   $0x1f
  8017aa:	e8 5d fc ff ff       	call   80140c <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 20                	push   $0x20
  8017c3:	e8 44 fc ff ff       	call   80140c <syscall>
  8017c8:	83 c4 18             	add    $0x18,%esp
}
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8017d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d3:	6a 00                	push   $0x0
  8017d5:	ff 75 14             	pushl  0x14(%ebp)
  8017d8:	ff 75 10             	pushl  0x10(%ebp)
  8017db:	ff 75 0c             	pushl  0xc(%ebp)
  8017de:	50                   	push   %eax
  8017df:	6a 21                	push   $0x21
  8017e1:	e8 26 fc ff ff       	call   80140c <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	50                   	push   %eax
  8017fa:	6a 22                	push   $0x22
  8017fc:	e8 0b fc ff ff       	call   80140c <syscall>
  801801:	83 c4 18             	add    $0x18,%esp
}
  801804:	90                   	nop
  801805:	c9                   	leave  
  801806:	c3                   	ret    

00801807 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801807:	55                   	push   %ebp
  801808:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	50                   	push   %eax
  801816:	6a 23                	push   $0x23
  801818:	e8 ef fb ff ff       	call   80140c <syscall>
  80181d:	83 c4 18             	add    $0x18,%esp
}
  801820:	90                   	nop
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
  801826:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801829:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80182c:	8d 50 04             	lea    0x4(%eax),%edx
  80182f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	52                   	push   %edx
  801839:	50                   	push   %eax
  80183a:	6a 24                	push   $0x24
  80183c:	e8 cb fb ff ff       	call   80140c <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
	return result;
  801844:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801847:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80184a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80184d:	89 01                	mov    %eax,(%ecx)
  80184f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	c9                   	leave  
  801856:	c2 04 00             	ret    $0x4

00801859 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	ff 75 10             	pushl  0x10(%ebp)
  801863:	ff 75 0c             	pushl  0xc(%ebp)
  801866:	ff 75 08             	pushl  0x8(%ebp)
  801869:	6a 13                	push   $0x13
  80186b:	e8 9c fb ff ff       	call   80140c <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
	return ;
  801873:	90                   	nop
}
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <sys_rcr2>:
uint32 sys_rcr2()
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 25                	push   $0x25
  801885:	e8 82 fb ff ff       	call   80140c <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
  801892:	83 ec 04             	sub    $0x4,%esp
  801895:	8b 45 08             	mov    0x8(%ebp),%eax
  801898:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80189b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	50                   	push   %eax
  8018a8:	6a 26                	push   $0x26
  8018aa:	e8 5d fb ff ff       	call   80140c <syscall>
  8018af:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b2:	90                   	nop
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <rsttst>:
void rsttst()
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 28                	push   $0x28
  8018c4:	e8 43 fb ff ff       	call   80140c <syscall>
  8018c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8018cc:	90                   	nop
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
  8018d2:	83 ec 04             	sub    $0x4,%esp
  8018d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018db:	8b 55 18             	mov    0x18(%ebp),%edx
  8018de:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018e2:	52                   	push   %edx
  8018e3:	50                   	push   %eax
  8018e4:	ff 75 10             	pushl  0x10(%ebp)
  8018e7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ea:	ff 75 08             	pushl  0x8(%ebp)
  8018ed:	6a 27                	push   $0x27
  8018ef:	e8 18 fb ff ff       	call   80140c <syscall>
  8018f4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f7:	90                   	nop
}
  8018f8:	c9                   	leave  
  8018f9:	c3                   	ret    

008018fa <chktst>:
void chktst(uint32 n)
{
  8018fa:	55                   	push   %ebp
  8018fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	ff 75 08             	pushl  0x8(%ebp)
  801908:	6a 29                	push   $0x29
  80190a:	e8 fd fa ff ff       	call   80140c <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
	return ;
  801912:	90                   	nop
}
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <inctst>:

void inctst()
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 2a                	push   $0x2a
  801924:	e8 e3 fa ff ff       	call   80140c <syscall>
  801929:	83 c4 18             	add    $0x18,%esp
	return ;
  80192c:	90                   	nop
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <gettst>:
uint32 gettst()
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 2b                	push   $0x2b
  80193e:	e8 c9 fa ff ff       	call   80140c <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
  80194b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 2c                	push   $0x2c
  80195a:	e8 ad fa ff ff       	call   80140c <syscall>
  80195f:	83 c4 18             	add    $0x18,%esp
  801962:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801965:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801969:	75 07                	jne    801972 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80196b:	b8 01 00 00 00       	mov    $0x1,%eax
  801970:	eb 05                	jmp    801977 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801972:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
  80197c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 2c                	push   $0x2c
  80198b:	e8 7c fa ff ff       	call   80140c <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
  801993:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801996:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80199a:	75 07                	jne    8019a3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80199c:	b8 01 00 00 00       	mov    $0x1,%eax
  8019a1:	eb 05                	jmp    8019a8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
  8019ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 2c                	push   $0x2c
  8019bc:	e8 4b fa ff ff       	call   80140c <syscall>
  8019c1:	83 c4 18             	add    $0x18,%esp
  8019c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019c7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019cb:	75 07                	jne    8019d4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8019d2:	eb 05                	jmp    8019d9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019d9:	c9                   	leave  
  8019da:	c3                   	ret    

008019db <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019db:	55                   	push   %ebp
  8019dc:	89 e5                	mov    %esp,%ebp
  8019de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 2c                	push   $0x2c
  8019ed:	e8 1a fa ff ff       	call   80140c <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
  8019f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8019f8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8019fc:	75 07                	jne    801a05 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8019fe:	b8 01 00 00 00       	mov    $0x1,%eax
  801a03:	eb 05                	jmp    801a0a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a05:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	ff 75 08             	pushl  0x8(%ebp)
  801a1a:	6a 2d                	push   $0x2d
  801a1c:	e8 eb f9 ff ff       	call   80140c <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
	return ;
  801a24:	90                   	nop
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
  801a2a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a2b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a2e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a34:	8b 45 08             	mov    0x8(%ebp),%eax
  801a37:	6a 00                	push   $0x0
  801a39:	53                   	push   %ebx
  801a3a:	51                   	push   %ecx
  801a3b:	52                   	push   %edx
  801a3c:	50                   	push   %eax
  801a3d:	6a 2e                	push   $0x2e
  801a3f:	e8 c8 f9 ff ff       	call   80140c <syscall>
  801a44:	83 c4 18             	add    $0x18,%esp
}
  801a47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a52:	8b 45 08             	mov    0x8(%ebp),%eax
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	52                   	push   %edx
  801a5c:	50                   	push   %eax
  801a5d:	6a 2f                	push   $0x2f
  801a5f:	e8 a8 f9 ff ff       	call   80140c <syscall>
  801a64:	83 c4 18             	add    $0x18,%esp
}
  801a67:	c9                   	leave  
  801a68:	c3                   	ret    

00801a69 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801a69:	55                   	push   %ebp
  801a6a:	89 e5                	mov    %esp,%ebp
  801a6c:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801a6f:	8b 55 08             	mov    0x8(%ebp),%edx
  801a72:	89 d0                	mov    %edx,%eax
  801a74:	c1 e0 02             	shl    $0x2,%eax
  801a77:	01 d0                	add    %edx,%eax
  801a79:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a80:	01 d0                	add    %edx,%eax
  801a82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a89:	01 d0                	add    %edx,%eax
  801a8b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a92:	01 d0                	add    %edx,%eax
  801a94:	c1 e0 04             	shl    $0x4,%eax
  801a97:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801a9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801aa1:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801aa4:	83 ec 0c             	sub    $0xc,%esp
  801aa7:	50                   	push   %eax
  801aa8:	e8 76 fd ff ff       	call   801823 <sys_get_virtual_time>
  801aad:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801ab0:	eb 41                	jmp    801af3 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801ab2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801ab5:	83 ec 0c             	sub    $0xc,%esp
  801ab8:	50                   	push   %eax
  801ab9:	e8 65 fd ff ff       	call   801823 <sys_get_virtual_time>
  801abe:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801ac1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ac4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ac7:	29 c2                	sub    %eax,%edx
  801ac9:	89 d0                	mov    %edx,%eax
  801acb:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801ace:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801ad1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ad4:	89 d1                	mov    %edx,%ecx
  801ad6:	29 c1                	sub    %eax,%ecx
  801ad8:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801adb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ade:	39 c2                	cmp    %eax,%edx
  801ae0:	0f 97 c0             	seta   %al
  801ae3:	0f b6 c0             	movzbl %al,%eax
  801ae6:	29 c1                	sub    %eax,%ecx
  801ae8:	89 c8                	mov    %ecx,%eax
  801aea:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801aed:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801af0:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801af6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801af9:	72 b7                	jb     801ab2 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801afb:	90                   	nop
  801afc:	c9                   	leave  
  801afd:	c3                   	ret    

00801afe <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
  801b01:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801b04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801b0b:	eb 03                	jmp    801b10 <busy_wait+0x12>
  801b0d:	ff 45 fc             	incl   -0x4(%ebp)
  801b10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b13:	3b 45 08             	cmp    0x8(%ebp),%eax
  801b16:	72 f5                	jb     801b0d <busy_wait+0xf>
	return i;
  801b18:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801b1b:	c9                   	leave  
  801b1c:	c3                   	ret    
  801b1d:	66 90                	xchg   %ax,%ax
  801b1f:	90                   	nop

00801b20 <__udivdi3>:
  801b20:	55                   	push   %ebp
  801b21:	57                   	push   %edi
  801b22:	56                   	push   %esi
  801b23:	53                   	push   %ebx
  801b24:	83 ec 1c             	sub    $0x1c,%esp
  801b27:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b2b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b33:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b37:	89 ca                	mov    %ecx,%edx
  801b39:	89 f8                	mov    %edi,%eax
  801b3b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b3f:	85 f6                	test   %esi,%esi
  801b41:	75 2d                	jne    801b70 <__udivdi3+0x50>
  801b43:	39 cf                	cmp    %ecx,%edi
  801b45:	77 65                	ja     801bac <__udivdi3+0x8c>
  801b47:	89 fd                	mov    %edi,%ebp
  801b49:	85 ff                	test   %edi,%edi
  801b4b:	75 0b                	jne    801b58 <__udivdi3+0x38>
  801b4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b52:	31 d2                	xor    %edx,%edx
  801b54:	f7 f7                	div    %edi
  801b56:	89 c5                	mov    %eax,%ebp
  801b58:	31 d2                	xor    %edx,%edx
  801b5a:	89 c8                	mov    %ecx,%eax
  801b5c:	f7 f5                	div    %ebp
  801b5e:	89 c1                	mov    %eax,%ecx
  801b60:	89 d8                	mov    %ebx,%eax
  801b62:	f7 f5                	div    %ebp
  801b64:	89 cf                	mov    %ecx,%edi
  801b66:	89 fa                	mov    %edi,%edx
  801b68:	83 c4 1c             	add    $0x1c,%esp
  801b6b:	5b                   	pop    %ebx
  801b6c:	5e                   	pop    %esi
  801b6d:	5f                   	pop    %edi
  801b6e:	5d                   	pop    %ebp
  801b6f:	c3                   	ret    
  801b70:	39 ce                	cmp    %ecx,%esi
  801b72:	77 28                	ja     801b9c <__udivdi3+0x7c>
  801b74:	0f bd fe             	bsr    %esi,%edi
  801b77:	83 f7 1f             	xor    $0x1f,%edi
  801b7a:	75 40                	jne    801bbc <__udivdi3+0x9c>
  801b7c:	39 ce                	cmp    %ecx,%esi
  801b7e:	72 0a                	jb     801b8a <__udivdi3+0x6a>
  801b80:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b84:	0f 87 9e 00 00 00    	ja     801c28 <__udivdi3+0x108>
  801b8a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b8f:	89 fa                	mov    %edi,%edx
  801b91:	83 c4 1c             	add    $0x1c,%esp
  801b94:	5b                   	pop    %ebx
  801b95:	5e                   	pop    %esi
  801b96:	5f                   	pop    %edi
  801b97:	5d                   	pop    %ebp
  801b98:	c3                   	ret    
  801b99:	8d 76 00             	lea    0x0(%esi),%esi
  801b9c:	31 ff                	xor    %edi,%edi
  801b9e:	31 c0                	xor    %eax,%eax
  801ba0:	89 fa                	mov    %edi,%edx
  801ba2:	83 c4 1c             	add    $0x1c,%esp
  801ba5:	5b                   	pop    %ebx
  801ba6:	5e                   	pop    %esi
  801ba7:	5f                   	pop    %edi
  801ba8:	5d                   	pop    %ebp
  801ba9:	c3                   	ret    
  801baa:	66 90                	xchg   %ax,%ax
  801bac:	89 d8                	mov    %ebx,%eax
  801bae:	f7 f7                	div    %edi
  801bb0:	31 ff                	xor    %edi,%edi
  801bb2:	89 fa                	mov    %edi,%edx
  801bb4:	83 c4 1c             	add    $0x1c,%esp
  801bb7:	5b                   	pop    %ebx
  801bb8:	5e                   	pop    %esi
  801bb9:	5f                   	pop    %edi
  801bba:	5d                   	pop    %ebp
  801bbb:	c3                   	ret    
  801bbc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bc1:	89 eb                	mov    %ebp,%ebx
  801bc3:	29 fb                	sub    %edi,%ebx
  801bc5:	89 f9                	mov    %edi,%ecx
  801bc7:	d3 e6                	shl    %cl,%esi
  801bc9:	89 c5                	mov    %eax,%ebp
  801bcb:	88 d9                	mov    %bl,%cl
  801bcd:	d3 ed                	shr    %cl,%ebp
  801bcf:	89 e9                	mov    %ebp,%ecx
  801bd1:	09 f1                	or     %esi,%ecx
  801bd3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bd7:	89 f9                	mov    %edi,%ecx
  801bd9:	d3 e0                	shl    %cl,%eax
  801bdb:	89 c5                	mov    %eax,%ebp
  801bdd:	89 d6                	mov    %edx,%esi
  801bdf:	88 d9                	mov    %bl,%cl
  801be1:	d3 ee                	shr    %cl,%esi
  801be3:	89 f9                	mov    %edi,%ecx
  801be5:	d3 e2                	shl    %cl,%edx
  801be7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801beb:	88 d9                	mov    %bl,%cl
  801bed:	d3 e8                	shr    %cl,%eax
  801bef:	09 c2                	or     %eax,%edx
  801bf1:	89 d0                	mov    %edx,%eax
  801bf3:	89 f2                	mov    %esi,%edx
  801bf5:	f7 74 24 0c          	divl   0xc(%esp)
  801bf9:	89 d6                	mov    %edx,%esi
  801bfb:	89 c3                	mov    %eax,%ebx
  801bfd:	f7 e5                	mul    %ebp
  801bff:	39 d6                	cmp    %edx,%esi
  801c01:	72 19                	jb     801c1c <__udivdi3+0xfc>
  801c03:	74 0b                	je     801c10 <__udivdi3+0xf0>
  801c05:	89 d8                	mov    %ebx,%eax
  801c07:	31 ff                	xor    %edi,%edi
  801c09:	e9 58 ff ff ff       	jmp    801b66 <__udivdi3+0x46>
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c14:	89 f9                	mov    %edi,%ecx
  801c16:	d3 e2                	shl    %cl,%edx
  801c18:	39 c2                	cmp    %eax,%edx
  801c1a:	73 e9                	jae    801c05 <__udivdi3+0xe5>
  801c1c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c1f:	31 ff                	xor    %edi,%edi
  801c21:	e9 40 ff ff ff       	jmp    801b66 <__udivdi3+0x46>
  801c26:	66 90                	xchg   %ax,%ax
  801c28:	31 c0                	xor    %eax,%eax
  801c2a:	e9 37 ff ff ff       	jmp    801b66 <__udivdi3+0x46>
  801c2f:	90                   	nop

00801c30 <__umoddi3>:
  801c30:	55                   	push   %ebp
  801c31:	57                   	push   %edi
  801c32:	56                   	push   %esi
  801c33:	53                   	push   %ebx
  801c34:	83 ec 1c             	sub    $0x1c,%esp
  801c37:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c3b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c43:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c4b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c4f:	89 f3                	mov    %esi,%ebx
  801c51:	89 fa                	mov    %edi,%edx
  801c53:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c57:	89 34 24             	mov    %esi,(%esp)
  801c5a:	85 c0                	test   %eax,%eax
  801c5c:	75 1a                	jne    801c78 <__umoddi3+0x48>
  801c5e:	39 f7                	cmp    %esi,%edi
  801c60:	0f 86 a2 00 00 00    	jbe    801d08 <__umoddi3+0xd8>
  801c66:	89 c8                	mov    %ecx,%eax
  801c68:	89 f2                	mov    %esi,%edx
  801c6a:	f7 f7                	div    %edi
  801c6c:	89 d0                	mov    %edx,%eax
  801c6e:	31 d2                	xor    %edx,%edx
  801c70:	83 c4 1c             	add    $0x1c,%esp
  801c73:	5b                   	pop    %ebx
  801c74:	5e                   	pop    %esi
  801c75:	5f                   	pop    %edi
  801c76:	5d                   	pop    %ebp
  801c77:	c3                   	ret    
  801c78:	39 f0                	cmp    %esi,%eax
  801c7a:	0f 87 ac 00 00 00    	ja     801d2c <__umoddi3+0xfc>
  801c80:	0f bd e8             	bsr    %eax,%ebp
  801c83:	83 f5 1f             	xor    $0x1f,%ebp
  801c86:	0f 84 ac 00 00 00    	je     801d38 <__umoddi3+0x108>
  801c8c:	bf 20 00 00 00       	mov    $0x20,%edi
  801c91:	29 ef                	sub    %ebp,%edi
  801c93:	89 fe                	mov    %edi,%esi
  801c95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c99:	89 e9                	mov    %ebp,%ecx
  801c9b:	d3 e0                	shl    %cl,%eax
  801c9d:	89 d7                	mov    %edx,%edi
  801c9f:	89 f1                	mov    %esi,%ecx
  801ca1:	d3 ef                	shr    %cl,%edi
  801ca3:	09 c7                	or     %eax,%edi
  801ca5:	89 e9                	mov    %ebp,%ecx
  801ca7:	d3 e2                	shl    %cl,%edx
  801ca9:	89 14 24             	mov    %edx,(%esp)
  801cac:	89 d8                	mov    %ebx,%eax
  801cae:	d3 e0                	shl    %cl,%eax
  801cb0:	89 c2                	mov    %eax,%edx
  801cb2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cb6:	d3 e0                	shl    %cl,%eax
  801cb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cbc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cc0:	89 f1                	mov    %esi,%ecx
  801cc2:	d3 e8                	shr    %cl,%eax
  801cc4:	09 d0                	or     %edx,%eax
  801cc6:	d3 eb                	shr    %cl,%ebx
  801cc8:	89 da                	mov    %ebx,%edx
  801cca:	f7 f7                	div    %edi
  801ccc:	89 d3                	mov    %edx,%ebx
  801cce:	f7 24 24             	mull   (%esp)
  801cd1:	89 c6                	mov    %eax,%esi
  801cd3:	89 d1                	mov    %edx,%ecx
  801cd5:	39 d3                	cmp    %edx,%ebx
  801cd7:	0f 82 87 00 00 00    	jb     801d64 <__umoddi3+0x134>
  801cdd:	0f 84 91 00 00 00    	je     801d74 <__umoddi3+0x144>
  801ce3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ce7:	29 f2                	sub    %esi,%edx
  801ce9:	19 cb                	sbb    %ecx,%ebx
  801ceb:	89 d8                	mov    %ebx,%eax
  801ced:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cf1:	d3 e0                	shl    %cl,%eax
  801cf3:	89 e9                	mov    %ebp,%ecx
  801cf5:	d3 ea                	shr    %cl,%edx
  801cf7:	09 d0                	or     %edx,%eax
  801cf9:	89 e9                	mov    %ebp,%ecx
  801cfb:	d3 eb                	shr    %cl,%ebx
  801cfd:	89 da                	mov    %ebx,%edx
  801cff:	83 c4 1c             	add    $0x1c,%esp
  801d02:	5b                   	pop    %ebx
  801d03:	5e                   	pop    %esi
  801d04:	5f                   	pop    %edi
  801d05:	5d                   	pop    %ebp
  801d06:	c3                   	ret    
  801d07:	90                   	nop
  801d08:	89 fd                	mov    %edi,%ebp
  801d0a:	85 ff                	test   %edi,%edi
  801d0c:	75 0b                	jne    801d19 <__umoddi3+0xe9>
  801d0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d13:	31 d2                	xor    %edx,%edx
  801d15:	f7 f7                	div    %edi
  801d17:	89 c5                	mov    %eax,%ebp
  801d19:	89 f0                	mov    %esi,%eax
  801d1b:	31 d2                	xor    %edx,%edx
  801d1d:	f7 f5                	div    %ebp
  801d1f:	89 c8                	mov    %ecx,%eax
  801d21:	f7 f5                	div    %ebp
  801d23:	89 d0                	mov    %edx,%eax
  801d25:	e9 44 ff ff ff       	jmp    801c6e <__umoddi3+0x3e>
  801d2a:	66 90                	xchg   %ax,%ax
  801d2c:	89 c8                	mov    %ecx,%eax
  801d2e:	89 f2                	mov    %esi,%edx
  801d30:	83 c4 1c             	add    $0x1c,%esp
  801d33:	5b                   	pop    %ebx
  801d34:	5e                   	pop    %esi
  801d35:	5f                   	pop    %edi
  801d36:	5d                   	pop    %ebp
  801d37:	c3                   	ret    
  801d38:	3b 04 24             	cmp    (%esp),%eax
  801d3b:	72 06                	jb     801d43 <__umoddi3+0x113>
  801d3d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d41:	77 0f                	ja     801d52 <__umoddi3+0x122>
  801d43:	89 f2                	mov    %esi,%edx
  801d45:	29 f9                	sub    %edi,%ecx
  801d47:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d4b:	89 14 24             	mov    %edx,(%esp)
  801d4e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d52:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d56:	8b 14 24             	mov    (%esp),%edx
  801d59:	83 c4 1c             	add    $0x1c,%esp
  801d5c:	5b                   	pop    %ebx
  801d5d:	5e                   	pop    %esi
  801d5e:	5f                   	pop    %edi
  801d5f:	5d                   	pop    %ebp
  801d60:	c3                   	ret    
  801d61:	8d 76 00             	lea    0x0(%esi),%esi
  801d64:	2b 04 24             	sub    (%esp),%eax
  801d67:	19 fa                	sbb    %edi,%edx
  801d69:	89 d1                	mov    %edx,%ecx
  801d6b:	89 c6                	mov    %eax,%esi
  801d6d:	e9 71 ff ff ff       	jmp    801ce3 <__umoddi3+0xb3>
  801d72:	66 90                	xchg   %ax,%ax
  801d74:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d78:	72 ea                	jb     801d64 <__umoddi3+0x134>
  801d7a:	89 d9                	mov    %ebx,%ecx
  801d7c:	e9 62 ff ff ff       	jmp    801ce3 <__umoddi3+0xb3>
