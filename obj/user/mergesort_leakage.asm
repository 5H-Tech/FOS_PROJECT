
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 65 07 00 00       	call   80079b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 3a 21 00 00       	call   802180 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 28 80 00       	push   $0x802820
  80004e:	e8 2f 0b 00 00       	call   800b82 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 28 80 00       	push   $0x802822
  80005e:	e8 1f 0b 00 00       	call   800b82 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 28 80 00       	push   $0x802838
  80006e:	e8 0f 0b 00 00       	call   800b82 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 28 80 00       	push   $0x802822
  80007e:	e8 ff 0a 00 00       	call   800b82 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 28 80 00       	push   $0x802820
  80008e:	e8 ef 0a 00 00       	call   800b82 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 50 28 80 00       	push   $0x802850
  8000a5:	e8 5a 11 00 00       	call   801204 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 aa 16 00 00       	call   80176a <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 3d 1a 00 00       	call   801b12 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 70 28 80 00       	push   $0x802870
  8000e3:	e8 9a 0a 00 00       	call   800b82 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 92 28 80 00       	push   $0x802892
  8000f3:	e8 8a 0a 00 00       	call   800b82 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 a0 28 80 00       	push   $0x8028a0
  800103:	e8 7a 0a 00 00       	call   800b82 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 af 28 80 00       	push   $0x8028af
  800113:	e8 6a 0a 00 00       	call   800b82 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 bf 28 80 00       	push   $0x8028bf
  800123:	e8 5a 0a 00 00       	call   800b82 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 13 06 00 00       	call   800743 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 bb 05 00 00       	call   8006fb <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 ae 05 00 00       	call   8006fb <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 33 20 00 00       	call   80219a <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 e6 01 00 00       	call   80036e <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 04 02 00 00       	call   80039f <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 26 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 13 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 d2 02 00 00       	call   8004a6 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 a4 1f 00 00       	call   802180 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 c8 28 80 00       	push   $0x8028c8
  8001e4:	e8 99 09 00 00       	call   800b82 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 a9 1f 00 00       	call   80219a <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 c5 00 00 00       	call   8002c4 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 fc 28 80 00       	push   $0x8028fc
  800213:	6a 4a                	push   $0x4a
  800215:	68 1e 29 80 00       	push   $0x80291e
  80021a:	e8 c1 06 00 00       	call   8008e0 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 5c 1f 00 00       	call   802180 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 38 29 80 00       	push   $0x802938
  80022c:	e8 51 09 00 00       	call   800b82 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 6c 29 80 00       	push   $0x80296c
  80023c:	e8 41 09 00 00       	call   800b82 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 a0 29 80 00       	push   $0x8029a0
  80024c:	e8 31 09 00 00       	call   800b82 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 41 1f 00 00       	call   80219a <sys_enable_interrupt>
		}

		//free(Elements) ;

		sys_disable_interrupt();
  800259:	e8 22 1f 00 00       	call   802180 <sys_disable_interrupt>
			Chose = 0 ;
  80025e:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800262:	eb 42                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800264:	83 ec 0c             	sub    $0xc,%esp
  800267:	68 d2 29 80 00       	push   $0x8029d2
  80026c:	e8 11 09 00 00       	call   800b82 <cprintf>
  800271:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800274:	e8 ca 04 00 00       	call   800743 <getchar>
  800279:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 72 04 00 00       	call   8006fb <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 65 04 00 00       	call   8006fb <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 58 04 00 00       	call   8006fb <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b2                	jne    800264 <_main+0x22c>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 e3 1e 00 00       	call   80219a <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>

}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 20 28 80 00       	push   $0x802820
  80044b:	e8 32 07 00 00       	call   800b82 <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 f0 29 80 00       	push   $0x8029f0
  80046d:	e8 10 07 00 00       	call   800b82 <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 f5 29 80 00       	push   $0x8029f5
  80049b:	e8 e2 06 00 00       	call   800b82 <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 d1 15 00 00       	call   801b12 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 bc 15 00 00       	call   801b12 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800707:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80070b:	83 ec 0c             	sub    $0xc,%esp
  80070e:	50                   	push   %eax
  80070f:	e8 a0 1a 00 00       	call   8021b4 <sys_cputc>
  800714:	83 c4 10             	add    $0x10,%esp
}
  800717:	90                   	nop
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800720:	e8 5b 1a 00 00       	call   802180 <sys_disable_interrupt>
	char c = ch;
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80072b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80072f:	83 ec 0c             	sub    $0xc,%esp
  800732:	50                   	push   %eax
  800733:	e8 7c 1a 00 00       	call   8021b4 <sys_cputc>
  800738:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80073b:	e8 5a 1a 00 00       	call   80219a <sys_enable_interrupt>
}
  800740:	90                   	nop
  800741:	c9                   	leave  
  800742:	c3                   	ret    

00800743 <getchar>:

int
getchar(void)
{
  800743:	55                   	push   %ebp
  800744:	89 e5                	mov    %esp,%ebp
  800746:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800749:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800750:	eb 08                	jmp    80075a <getchar+0x17>
	{
		c = sys_cgetc();
  800752:	e8 41 18 00 00       	call   801f98 <sys_cgetc>
  800757:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80075a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80075e:	74 f2                	je     800752 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800760:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800763:	c9                   	leave  
  800764:	c3                   	ret    

00800765 <atomic_getchar>:

int
atomic_getchar(void)
{
  800765:	55                   	push   %ebp
  800766:	89 e5                	mov    %esp,%ebp
  800768:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80076b:	e8 10 1a 00 00       	call   802180 <sys_disable_interrupt>
	int c=0;
  800770:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800777:	eb 08                	jmp    800781 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800779:	e8 1a 18 00 00       	call   801f98 <sys_cgetc>
  80077e:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800781:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800785:	74 f2                	je     800779 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800787:	e8 0e 1a 00 00       	call   80219a <sys_enable_interrupt>
	return c;
  80078c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078f:	c9                   	leave  
  800790:	c3                   	ret    

00800791 <iscons>:

int iscons(int fdnum)
{
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800794:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800799:	5d                   	pop    %ebp
  80079a:	c3                   	ret    

0080079b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80079b:	55                   	push   %ebp
  80079c:	89 e5                	mov    %esp,%ebp
  80079e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007a1:	e8 3f 18 00 00       	call   801fe5 <sys_getenvindex>
  8007a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ac:	89 d0                	mov    %edx,%eax
  8007ae:	c1 e0 03             	shl    $0x3,%eax
  8007b1:	01 d0                	add    %edx,%eax
  8007b3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007ba:	01 c8                	add    %ecx,%eax
  8007bc:	01 c0                	add    %eax,%eax
  8007be:	01 d0                	add    %edx,%eax
  8007c0:	01 c0                	add    %eax,%eax
  8007c2:	01 d0                	add    %edx,%eax
  8007c4:	89 c2                	mov    %eax,%edx
  8007c6:	c1 e2 05             	shl    $0x5,%edx
  8007c9:	29 c2                	sub    %eax,%edx
  8007cb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007d2:	89 c2                	mov    %eax,%edx
  8007d4:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007da:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007df:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e4:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8007ea:	84 c0                	test   %al,%al
  8007ec:	74 0f                	je     8007fd <libmain+0x62>
		binaryname = myEnv->prog_name;
  8007ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f3:	05 40 3c 01 00       	add    $0x13c40,%eax
  8007f8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800801:	7e 0a                	jle    80080d <libmain+0x72>
		binaryname = argv[0];
  800803:	8b 45 0c             	mov    0xc(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 1d f8 ff ff       	call   800038 <_main>
  80081b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80081e:	e8 5d 19 00 00       	call   802180 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800823:	83 ec 0c             	sub    $0xc,%esp
  800826:	68 14 2a 80 00       	push   $0x802a14
  80082b:	e8 52 03 00 00       	call   800b82 <cprintf>
  800830:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800833:	a1 24 30 80 00       	mov    0x803024,%eax
  800838:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80083e:	a1 24 30 80 00       	mov    0x803024,%eax
  800843:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800849:	83 ec 04             	sub    $0x4,%esp
  80084c:	52                   	push   %edx
  80084d:	50                   	push   %eax
  80084e:	68 3c 2a 80 00       	push   $0x802a3c
  800853:	e8 2a 03 00 00       	call   800b82 <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800866:	a1 24 30 80 00       	mov    0x803024,%eax
  80086b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800871:	83 ec 04             	sub    $0x4,%esp
  800874:	52                   	push   %edx
  800875:	50                   	push   %eax
  800876:	68 64 2a 80 00       	push   $0x802a64
  80087b:	e8 02 03 00 00       	call   800b82 <cprintf>
  800880:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800883:	a1 24 30 80 00       	mov    0x803024,%eax
  800888:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	50                   	push   %eax
  800892:	68 a5 2a 80 00       	push   $0x802aa5
  800897:	e8 e6 02 00 00       	call   800b82 <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80089f:	83 ec 0c             	sub    $0xc,%esp
  8008a2:	68 14 2a 80 00       	push   $0x802a14
  8008a7:	e8 d6 02 00 00       	call   800b82 <cprintf>
  8008ac:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008af:	e8 e6 18 00 00       	call   80219a <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008b4:	e8 19 00 00 00       	call   8008d2 <exit>
}
  8008b9:	90                   	nop
  8008ba:	c9                   	leave  
  8008bb:	c3                   	ret    

008008bc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008c2:	83 ec 0c             	sub    $0xc,%esp
  8008c5:	6a 00                	push   $0x0
  8008c7:	e8 e5 16 00 00       	call   801fb1 <sys_env_destroy>
  8008cc:	83 c4 10             	add    $0x10,%esp
}
  8008cf:	90                   	nop
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <exit>:

void
exit(void)
{
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008d8:	e8 3a 17 00 00       	call   802017 <sys_env_exit>
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e9:	83 c0 04             	add    $0x4,%eax
  8008ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008ef:	a1 18 31 80 00       	mov    0x803118,%eax
  8008f4:	85 c0                	test   %eax,%eax
  8008f6:	74 16                	je     80090e <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008f8:	a1 18 31 80 00       	mov    0x803118,%eax
  8008fd:	83 ec 08             	sub    $0x8,%esp
  800900:	50                   	push   %eax
  800901:	68 bc 2a 80 00       	push   $0x802abc
  800906:	e8 77 02 00 00       	call   800b82 <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80090e:	a1 00 30 80 00       	mov    0x803000,%eax
  800913:	ff 75 0c             	pushl  0xc(%ebp)
  800916:	ff 75 08             	pushl  0x8(%ebp)
  800919:	50                   	push   %eax
  80091a:	68 c1 2a 80 00       	push   $0x802ac1
  80091f:	e8 5e 02 00 00       	call   800b82 <cprintf>
  800924:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800927:	8b 45 10             	mov    0x10(%ebp),%eax
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 f4             	pushl  -0xc(%ebp)
  800930:	50                   	push   %eax
  800931:	e8 e1 01 00 00       	call   800b17 <vcprintf>
  800936:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	6a 00                	push   $0x0
  80093e:	68 dd 2a 80 00       	push   $0x802add
  800943:	e8 cf 01 00 00       	call   800b17 <vcprintf>
  800948:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80094b:	e8 82 ff ff ff       	call   8008d2 <exit>

	// should not return here
	while (1) ;
  800950:	eb fe                	jmp    800950 <_panic+0x70>

00800952 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800958:	a1 24 30 80 00       	mov    0x803024,%eax
  80095d:	8b 50 74             	mov    0x74(%eax),%edx
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	39 c2                	cmp    %eax,%edx
  800965:	74 14                	je     80097b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800967:	83 ec 04             	sub    $0x4,%esp
  80096a:	68 e0 2a 80 00       	push   $0x802ae0
  80096f:	6a 26                	push   $0x26
  800971:	68 2c 2b 80 00       	push   $0x802b2c
  800976:	e8 65 ff ff ff       	call   8008e0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80097b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800982:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800989:	e9 b6 00 00 00       	jmp    800a44 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800991:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	01 d0                	add    %edx,%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	85 c0                	test   %eax,%eax
  8009a1:	75 08                	jne    8009ab <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009a3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009a6:	e9 96 00 00 00       	jmp    800a41 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009b9:	eb 5d                	jmp    800a18 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009bb:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c9:	c1 e2 04             	shl    $0x4,%edx
  8009cc:	01 d0                	add    %edx,%eax
  8009ce:	8a 40 04             	mov    0x4(%eax),%al
  8009d1:	84 c0                	test   %al,%al
  8009d3:	75 40                	jne    800a15 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009d5:	a1 24 30 80 00       	mov    0x803024,%eax
  8009da:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009e3:	c1 e2 04             	shl    $0x4,%edx
  8009e6:	01 d0                	add    %edx,%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009fa:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	01 c8                	add    %ecx,%eax
  800a06:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a08:	39 c2                	cmp    %eax,%edx
  800a0a:	75 09                	jne    800a15 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a0c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a13:	eb 12                	jmp    800a27 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a15:	ff 45 e8             	incl   -0x18(%ebp)
  800a18:	a1 24 30 80 00       	mov    0x803024,%eax
  800a1d:	8b 50 74             	mov    0x74(%eax),%edx
  800a20:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a23:	39 c2                	cmp    %eax,%edx
  800a25:	77 94                	ja     8009bb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a2b:	75 14                	jne    800a41 <CheckWSWithoutLastIndex+0xef>
			panic(
  800a2d:	83 ec 04             	sub    $0x4,%esp
  800a30:	68 38 2b 80 00       	push   $0x802b38
  800a35:	6a 3a                	push   $0x3a
  800a37:	68 2c 2b 80 00       	push   $0x802b2c
  800a3c:	e8 9f fe ff ff       	call   8008e0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a41:	ff 45 f0             	incl   -0x10(%ebp)
  800a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a47:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a4a:	0f 8c 3e ff ff ff    	jl     80098e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a57:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a5e:	eb 20                	jmp    800a80 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a60:	a1 24 30 80 00       	mov    0x803024,%eax
  800a65:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a6b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a6e:	c1 e2 04             	shl    $0x4,%edx
  800a71:	01 d0                	add    %edx,%eax
  800a73:	8a 40 04             	mov    0x4(%eax),%al
  800a76:	3c 01                	cmp    $0x1,%al
  800a78:	75 03                	jne    800a7d <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a7a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a7d:	ff 45 e0             	incl   -0x20(%ebp)
  800a80:	a1 24 30 80 00       	mov    0x803024,%eax
  800a85:	8b 50 74             	mov    0x74(%eax),%edx
  800a88:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8b:	39 c2                	cmp    %eax,%edx
  800a8d:	77 d1                	ja     800a60 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a92:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a95:	74 14                	je     800aab <CheckWSWithoutLastIndex+0x159>
		panic(
  800a97:	83 ec 04             	sub    $0x4,%esp
  800a9a:	68 8c 2b 80 00       	push   $0x802b8c
  800a9f:	6a 44                	push   $0x44
  800aa1:	68 2c 2b 80 00       	push   $0x802b2c
  800aa6:	e8 35 fe ff ff       	call   8008e0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aab:	90                   	nop
  800aac:	c9                   	leave  
  800aad:	c3                   	ret    

00800aae <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aae:	55                   	push   %ebp
  800aaf:	89 e5                	mov    %esp,%ebp
  800ab1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8b 00                	mov    (%eax),%eax
  800ab9:	8d 48 01             	lea    0x1(%eax),%ecx
  800abc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800abf:	89 0a                	mov    %ecx,(%edx)
  800ac1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac4:	88 d1                	mov    %dl,%cl
  800ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	8b 00                	mov    (%eax),%eax
  800ad2:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ad7:	75 2c                	jne    800b05 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ad9:	a0 28 30 80 00       	mov    0x803028,%al
  800ade:	0f b6 c0             	movzbl %al,%eax
  800ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae4:	8b 12                	mov    (%edx),%edx
  800ae6:	89 d1                	mov    %edx,%ecx
  800ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aeb:	83 c2 08             	add    $0x8,%edx
  800aee:	83 ec 04             	sub    $0x4,%esp
  800af1:	50                   	push   %eax
  800af2:	51                   	push   %ecx
  800af3:	52                   	push   %edx
  800af4:	e8 76 14 00 00       	call   801f6f <sys_cputs>
  800af9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800afc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b08:	8b 40 04             	mov    0x4(%eax),%eax
  800b0b:	8d 50 01             	lea    0x1(%eax),%edx
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b14:	90                   	nop
  800b15:	c9                   	leave  
  800b16:	c3                   	ret    

00800b17 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b17:	55                   	push   %ebp
  800b18:	89 e5                	mov    %esp,%ebp
  800b1a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b20:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b27:	00 00 00 
	b.cnt = 0;
  800b2a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b31:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	ff 75 08             	pushl  0x8(%ebp)
  800b3a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b40:	50                   	push   %eax
  800b41:	68 ae 0a 80 00       	push   $0x800aae
  800b46:	e8 11 02 00 00       	call   800d5c <vprintfmt>
  800b4b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b4e:	a0 28 30 80 00       	mov    0x803028,%al
  800b53:	0f b6 c0             	movzbl %al,%eax
  800b56:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b5c:	83 ec 04             	sub    $0x4,%esp
  800b5f:	50                   	push   %eax
  800b60:	52                   	push   %edx
  800b61:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b67:	83 c0 08             	add    $0x8,%eax
  800b6a:	50                   	push   %eax
  800b6b:	e8 ff 13 00 00       	call   801f6f <sys_cputs>
  800b70:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b73:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b7a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b88:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b8f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b9e:	50                   	push   %eax
  800b9f:	e8 73 ff ff ff       	call   800b17 <vcprintf>
  800ba4:	83 c4 10             	add    $0x10,%esp
  800ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bb5:	e8 c6 15 00 00       	call   802180 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bba:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	83 ec 08             	sub    $0x8,%esp
  800bc6:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc9:	50                   	push   %eax
  800bca:	e8 48 ff ff ff       	call   800b17 <vcprintf>
  800bcf:	83 c4 10             	add    $0x10,%esp
  800bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bd5:	e8 c0 15 00 00       	call   80219a <sys_enable_interrupt>
	return cnt;
  800bda:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bdd:	c9                   	leave  
  800bde:	c3                   	ret    

00800bdf <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bdf:	55                   	push   %ebp
  800be0:	89 e5                	mov    %esp,%ebp
  800be2:	53                   	push   %ebx
  800be3:	83 ec 14             	sub    $0x14,%esp
  800be6:	8b 45 10             	mov    0x10(%ebp),%eax
  800be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bec:	8b 45 14             	mov    0x14(%ebp),%eax
  800bef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf2:	8b 45 18             	mov    0x18(%ebp),%eax
  800bf5:	ba 00 00 00 00       	mov    $0x0,%edx
  800bfa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bfd:	77 55                	ja     800c54 <printnum+0x75>
  800bff:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c02:	72 05                	jb     800c09 <printnum+0x2a>
  800c04:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c07:	77 4b                	ja     800c54 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c09:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c0c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c0f:	8b 45 18             	mov    0x18(%ebp),%eax
  800c12:	ba 00 00 00 00       	mov    $0x0,%edx
  800c17:	52                   	push   %edx
  800c18:	50                   	push   %eax
  800c19:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1c:	ff 75 f0             	pushl  -0x10(%ebp)
  800c1f:	e8 80 19 00 00       	call   8025a4 <__udivdi3>
  800c24:	83 c4 10             	add    $0x10,%esp
  800c27:	83 ec 04             	sub    $0x4,%esp
  800c2a:	ff 75 20             	pushl  0x20(%ebp)
  800c2d:	53                   	push   %ebx
  800c2e:	ff 75 18             	pushl  0x18(%ebp)
  800c31:	52                   	push   %edx
  800c32:	50                   	push   %eax
  800c33:	ff 75 0c             	pushl  0xc(%ebp)
  800c36:	ff 75 08             	pushl  0x8(%ebp)
  800c39:	e8 a1 ff ff ff       	call   800bdf <printnum>
  800c3e:	83 c4 20             	add    $0x20,%esp
  800c41:	eb 1a                	jmp    800c5d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c43:	83 ec 08             	sub    $0x8,%esp
  800c46:	ff 75 0c             	pushl  0xc(%ebp)
  800c49:	ff 75 20             	pushl  0x20(%ebp)
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	ff d0                	call   *%eax
  800c51:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c54:	ff 4d 1c             	decl   0x1c(%ebp)
  800c57:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c5b:	7f e6                	jg     800c43 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c5d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c60:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c6b:	53                   	push   %ebx
  800c6c:	51                   	push   %ecx
  800c6d:	52                   	push   %edx
  800c6e:	50                   	push   %eax
  800c6f:	e8 40 1a 00 00       	call   8026b4 <__umoddi3>
  800c74:	83 c4 10             	add    $0x10,%esp
  800c77:	05 f4 2d 80 00       	add    $0x802df4,%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	0f be c0             	movsbl %al,%eax
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 0c             	pushl  0xc(%ebp)
  800c87:	50                   	push   %eax
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	ff d0                	call   *%eax
  800c8d:	83 c4 10             	add    $0x10,%esp
}
  800c90:	90                   	nop
  800c91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c94:	c9                   	leave  
  800c95:	c3                   	ret    

00800c96 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c99:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c9d:	7e 1c                	jle    800cbb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8b 00                	mov    (%eax),%eax
  800ca4:	8d 50 08             	lea    0x8(%eax),%edx
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	89 10                	mov    %edx,(%eax)
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8b 00                	mov    (%eax),%eax
  800cb1:	83 e8 08             	sub    $0x8,%eax
  800cb4:	8b 50 04             	mov    0x4(%eax),%edx
  800cb7:	8b 00                	mov    (%eax),%eax
  800cb9:	eb 40                	jmp    800cfb <getuint+0x65>
	else if (lflag)
  800cbb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cbf:	74 1e                	je     800cdf <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	8b 00                	mov    (%eax),%eax
  800cc6:	8d 50 04             	lea    0x4(%eax),%edx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	89 10                	mov    %edx,(%eax)
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8b 00                	mov    (%eax),%eax
  800cd3:	83 e8 04             	sub    $0x4,%eax
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	ba 00 00 00 00       	mov    $0x0,%edx
  800cdd:	eb 1c                	jmp    800cfb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	8b 00                	mov    (%eax),%eax
  800ce4:	8d 50 04             	lea    0x4(%eax),%edx
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	89 10                	mov    %edx,(%eax)
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	8b 00                	mov    (%eax),%eax
  800cf1:	83 e8 04             	sub    $0x4,%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cfb:	5d                   	pop    %ebp
  800cfc:	c3                   	ret    

00800cfd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d00:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d04:	7e 1c                	jle    800d22 <getint+0x25>
		return va_arg(*ap, long long);
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8b 00                	mov    (%eax),%eax
  800d0b:	8d 50 08             	lea    0x8(%eax),%edx
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	89 10                	mov    %edx,(%eax)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8b 00                	mov    (%eax),%eax
  800d18:	83 e8 08             	sub    $0x8,%eax
  800d1b:	8b 50 04             	mov    0x4(%eax),%edx
  800d1e:	8b 00                	mov    (%eax),%eax
  800d20:	eb 38                	jmp    800d5a <getint+0x5d>
	else if (lflag)
  800d22:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d26:	74 1a                	je     800d42 <getint+0x45>
		return va_arg(*ap, long);
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8b 00                	mov    (%eax),%eax
  800d2d:	8d 50 04             	lea    0x4(%eax),%edx
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	89 10                	mov    %edx,(%eax)
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8b 00                	mov    (%eax),%eax
  800d3a:	83 e8 04             	sub    $0x4,%eax
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	99                   	cltd   
  800d40:	eb 18                	jmp    800d5a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8b 00                	mov    (%eax),%eax
  800d47:	8d 50 04             	lea    0x4(%eax),%edx
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	89 10                	mov    %edx,(%eax)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8b 00                	mov    (%eax),%eax
  800d54:	83 e8 04             	sub    $0x4,%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	99                   	cltd   
}
  800d5a:	5d                   	pop    %ebp
  800d5b:	c3                   	ret    

00800d5c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d5c:	55                   	push   %ebp
  800d5d:	89 e5                	mov    %esp,%ebp
  800d5f:	56                   	push   %esi
  800d60:	53                   	push   %ebx
  800d61:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d64:	eb 17                	jmp    800d7d <vprintfmt+0x21>
			if (ch == '\0')
  800d66:	85 db                	test   %ebx,%ebx
  800d68:	0f 84 af 03 00 00    	je     80111d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d6e:	83 ec 08             	sub    $0x8,%esp
  800d71:	ff 75 0c             	pushl  0xc(%ebp)
  800d74:	53                   	push   %ebx
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	ff d0                	call   *%eax
  800d7a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d80:	8d 50 01             	lea    0x1(%eax),%edx
  800d83:	89 55 10             	mov    %edx,0x10(%ebp)
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f b6 d8             	movzbl %al,%ebx
  800d8b:	83 fb 25             	cmp    $0x25,%ebx
  800d8e:	75 d6                	jne    800d66 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d90:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d94:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d9b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db0:	8b 45 10             	mov    0x10(%ebp),%eax
  800db3:	8d 50 01             	lea    0x1(%eax),%edx
  800db6:	89 55 10             	mov    %edx,0x10(%ebp)
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f b6 d8             	movzbl %al,%ebx
  800dbe:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc1:	83 f8 55             	cmp    $0x55,%eax
  800dc4:	0f 87 2b 03 00 00    	ja     8010f5 <vprintfmt+0x399>
  800dca:	8b 04 85 18 2e 80 00 	mov    0x802e18(,%eax,4),%eax
  800dd1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dd7:	eb d7                	jmp    800db0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ddd:	eb d1                	jmp    800db0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ddf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800de6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de9:	89 d0                	mov    %edx,%eax
  800deb:	c1 e0 02             	shl    $0x2,%eax
  800dee:	01 d0                	add    %edx,%eax
  800df0:	01 c0                	add    %eax,%eax
  800df2:	01 d8                	add    %ebx,%eax
  800df4:	83 e8 30             	sub    $0x30,%eax
  800df7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dfa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfd:	8a 00                	mov    (%eax),%al
  800dff:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e02:	83 fb 2f             	cmp    $0x2f,%ebx
  800e05:	7e 3e                	jle    800e45 <vprintfmt+0xe9>
  800e07:	83 fb 39             	cmp    $0x39,%ebx
  800e0a:	7f 39                	jg     800e45 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e0c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e0f:	eb d5                	jmp    800de6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e11:	8b 45 14             	mov    0x14(%ebp),%eax
  800e14:	83 c0 04             	add    $0x4,%eax
  800e17:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1d:	83 e8 04             	sub    $0x4,%eax
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e25:	eb 1f                	jmp    800e46 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2b:	79 83                	jns    800db0 <vprintfmt+0x54>
				width = 0;
  800e2d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e34:	e9 77 ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e39:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e40:	e9 6b ff ff ff       	jmp    800db0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e45:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4a:	0f 89 60 ff ff ff    	jns    800db0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e56:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e5d:	e9 4e ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e62:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e65:	e9 46 ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6d:	83 c0 04             	add    $0x4,%eax
  800e70:	89 45 14             	mov    %eax,0x14(%ebp)
  800e73:	8b 45 14             	mov    0x14(%ebp),%eax
  800e76:	83 e8 04             	sub    $0x4,%eax
  800e79:	8b 00                	mov    (%eax),%eax
  800e7b:	83 ec 08             	sub    $0x8,%esp
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	50                   	push   %eax
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			break;
  800e8a:	e9 89 02 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 c0 04             	add    $0x4,%eax
  800e95:	89 45 14             	mov    %eax,0x14(%ebp)
  800e98:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9b:	83 e8 04             	sub    $0x4,%eax
  800e9e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea0:	85 db                	test   %ebx,%ebx
  800ea2:	79 02                	jns    800ea6 <vprintfmt+0x14a>
				err = -err;
  800ea4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ea6:	83 fb 64             	cmp    $0x64,%ebx
  800ea9:	7f 0b                	jg     800eb6 <vprintfmt+0x15a>
  800eab:	8b 34 9d 60 2c 80 00 	mov    0x802c60(,%ebx,4),%esi
  800eb2:	85 f6                	test   %esi,%esi
  800eb4:	75 19                	jne    800ecf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eb6:	53                   	push   %ebx
  800eb7:	68 05 2e 80 00       	push   $0x802e05
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	ff 75 08             	pushl  0x8(%ebp)
  800ec2:	e8 5e 02 00 00       	call   801125 <printfmt>
  800ec7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eca:	e9 49 02 00 00       	jmp    801118 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ecf:	56                   	push   %esi
  800ed0:	68 0e 2e 80 00       	push   $0x802e0e
  800ed5:	ff 75 0c             	pushl  0xc(%ebp)
  800ed8:	ff 75 08             	pushl  0x8(%ebp)
  800edb:	e8 45 02 00 00       	call   801125 <printfmt>
  800ee0:	83 c4 10             	add    $0x10,%esp
			break;
  800ee3:	e9 30 02 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ee8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eeb:	83 c0 04             	add    $0x4,%eax
  800eee:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef4:	83 e8 04             	sub    $0x4,%eax
  800ef7:	8b 30                	mov    (%eax),%esi
  800ef9:	85 f6                	test   %esi,%esi
  800efb:	75 05                	jne    800f02 <vprintfmt+0x1a6>
				p = "(null)";
  800efd:	be 11 2e 80 00       	mov    $0x802e11,%esi
			if (width > 0 && padc != '-')
  800f02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f06:	7e 6d                	jle    800f75 <vprintfmt+0x219>
  800f08:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f0c:	74 67                	je     800f75 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f11:	83 ec 08             	sub    $0x8,%esp
  800f14:	50                   	push   %eax
  800f15:	56                   	push   %esi
  800f16:	e8 12 05 00 00       	call   80142d <strnlen>
  800f1b:	83 c4 10             	add    $0x10,%esp
  800f1e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f21:	eb 16                	jmp    800f39 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f23:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f27:	83 ec 08             	sub    $0x8,%esp
  800f2a:	ff 75 0c             	pushl  0xc(%ebp)
  800f2d:	50                   	push   %eax
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	ff d0                	call   *%eax
  800f33:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f36:	ff 4d e4             	decl   -0x1c(%ebp)
  800f39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f3d:	7f e4                	jg     800f23 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f3f:	eb 34                	jmp    800f75 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f41:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f45:	74 1c                	je     800f63 <vprintfmt+0x207>
  800f47:	83 fb 1f             	cmp    $0x1f,%ebx
  800f4a:	7e 05                	jle    800f51 <vprintfmt+0x1f5>
  800f4c:	83 fb 7e             	cmp    $0x7e,%ebx
  800f4f:	7e 12                	jle    800f63 <vprintfmt+0x207>
					putch('?', putdat);
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 0c             	pushl  0xc(%ebp)
  800f57:	6a 3f                	push   $0x3f
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	ff d0                	call   *%eax
  800f5e:	83 c4 10             	add    $0x10,%esp
  800f61:	eb 0f                	jmp    800f72 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f63:	83 ec 08             	sub    $0x8,%esp
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	53                   	push   %ebx
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	ff d0                	call   *%eax
  800f6f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f72:	ff 4d e4             	decl   -0x1c(%ebp)
  800f75:	89 f0                	mov    %esi,%eax
  800f77:	8d 70 01             	lea    0x1(%eax),%esi
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	0f be d8             	movsbl %al,%ebx
  800f7f:	85 db                	test   %ebx,%ebx
  800f81:	74 24                	je     800fa7 <vprintfmt+0x24b>
  800f83:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f87:	78 b8                	js     800f41 <vprintfmt+0x1e5>
  800f89:	ff 4d e0             	decl   -0x20(%ebp)
  800f8c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f90:	79 af                	jns    800f41 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f92:	eb 13                	jmp    800fa7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f94:	83 ec 08             	sub    $0x8,%esp
  800f97:	ff 75 0c             	pushl  0xc(%ebp)
  800f9a:	6a 20                	push   $0x20
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	ff d0                	call   *%eax
  800fa1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa4:	ff 4d e4             	decl   -0x1c(%ebp)
  800fa7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fab:	7f e7                	jg     800f94 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fad:	e9 66 01 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb2:	83 ec 08             	sub    $0x8,%esp
  800fb5:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb8:	8d 45 14             	lea    0x14(%ebp),%eax
  800fbb:	50                   	push   %eax
  800fbc:	e8 3c fd ff ff       	call   800cfd <getint>
  800fc1:	83 c4 10             	add    $0x10,%esp
  800fc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fcd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd0:	85 d2                	test   %edx,%edx
  800fd2:	79 23                	jns    800ff7 <vprintfmt+0x29b>
				putch('-', putdat);
  800fd4:	83 ec 08             	sub    $0x8,%esp
  800fd7:	ff 75 0c             	pushl  0xc(%ebp)
  800fda:	6a 2d                	push   $0x2d
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	ff d0                	call   *%eax
  800fe1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fea:	f7 d8                	neg    %eax
  800fec:	83 d2 00             	adc    $0x0,%edx
  800fef:	f7 da                	neg    %edx
  800ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ff7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ffe:	e9 bc 00 00 00       	jmp    8010bf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801003:	83 ec 08             	sub    $0x8,%esp
  801006:	ff 75 e8             	pushl  -0x18(%ebp)
  801009:	8d 45 14             	lea    0x14(%ebp),%eax
  80100c:	50                   	push   %eax
  80100d:	e8 84 fc ff ff       	call   800c96 <getuint>
  801012:	83 c4 10             	add    $0x10,%esp
  801015:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801018:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80101b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801022:	e9 98 00 00 00       	jmp    8010bf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801027:	83 ec 08             	sub    $0x8,%esp
  80102a:	ff 75 0c             	pushl  0xc(%ebp)
  80102d:	6a 58                	push   $0x58
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	ff d0                	call   *%eax
  801034:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801037:	83 ec 08             	sub    $0x8,%esp
  80103a:	ff 75 0c             	pushl  0xc(%ebp)
  80103d:	6a 58                	push   $0x58
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	ff d0                	call   *%eax
  801044:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801047:	83 ec 08             	sub    $0x8,%esp
  80104a:	ff 75 0c             	pushl  0xc(%ebp)
  80104d:	6a 58                	push   $0x58
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	ff d0                	call   *%eax
  801054:	83 c4 10             	add    $0x10,%esp
			break;
  801057:	e9 bc 00 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 0c             	pushl  0xc(%ebp)
  801062:	6a 30                	push   $0x30
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	ff d0                	call   *%eax
  801069:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80106c:	83 ec 08             	sub    $0x8,%esp
  80106f:	ff 75 0c             	pushl  0xc(%ebp)
  801072:	6a 78                	push   $0x78
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	ff d0                	call   *%eax
  801079:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80107c:	8b 45 14             	mov    0x14(%ebp),%eax
  80107f:	83 c0 04             	add    $0x4,%eax
  801082:	89 45 14             	mov    %eax,0x14(%ebp)
  801085:	8b 45 14             	mov    0x14(%ebp),%eax
  801088:	83 e8 04             	sub    $0x4,%eax
  80108b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80108d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801097:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80109e:	eb 1f                	jmp    8010bf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a0:	83 ec 08             	sub    $0x8,%esp
  8010a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a6:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a9:	50                   	push   %eax
  8010aa:	e8 e7 fb ff ff       	call   800c96 <getuint>
  8010af:	83 c4 10             	add    $0x10,%esp
  8010b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010b8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010bf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c6:	83 ec 04             	sub    $0x4,%esp
  8010c9:	52                   	push   %edx
  8010ca:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010cd:	50                   	push   %eax
  8010ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8010d4:	ff 75 0c             	pushl  0xc(%ebp)
  8010d7:	ff 75 08             	pushl  0x8(%ebp)
  8010da:	e8 00 fb ff ff       	call   800bdf <printnum>
  8010df:	83 c4 20             	add    $0x20,%esp
			break;
  8010e2:	eb 34                	jmp    801118 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010e4:	83 ec 08             	sub    $0x8,%esp
  8010e7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ea:	53                   	push   %ebx
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	ff d0                	call   *%eax
  8010f0:	83 c4 10             	add    $0x10,%esp
			break;
  8010f3:	eb 23                	jmp    801118 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010f5:	83 ec 08             	sub    $0x8,%esp
  8010f8:	ff 75 0c             	pushl  0xc(%ebp)
  8010fb:	6a 25                	push   $0x25
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	ff d0                	call   *%eax
  801102:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801105:	ff 4d 10             	decl   0x10(%ebp)
  801108:	eb 03                	jmp    80110d <vprintfmt+0x3b1>
  80110a:	ff 4d 10             	decl   0x10(%ebp)
  80110d:	8b 45 10             	mov    0x10(%ebp),%eax
  801110:	48                   	dec    %eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 25                	cmp    $0x25,%al
  801115:	75 f3                	jne    80110a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801117:	90                   	nop
		}
	}
  801118:	e9 47 fc ff ff       	jmp    800d64 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80111d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80111e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801121:	5b                   	pop    %ebx
  801122:	5e                   	pop    %esi
  801123:	5d                   	pop    %ebp
  801124:	c3                   	ret    

00801125 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80112b:	8d 45 10             	lea    0x10(%ebp),%eax
  80112e:	83 c0 04             	add    $0x4,%eax
  801131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801134:	8b 45 10             	mov    0x10(%ebp),%eax
  801137:	ff 75 f4             	pushl  -0xc(%ebp)
  80113a:	50                   	push   %eax
  80113b:	ff 75 0c             	pushl  0xc(%ebp)
  80113e:	ff 75 08             	pushl  0x8(%ebp)
  801141:	e8 16 fc ff ff       	call   800d5c <vprintfmt>
  801146:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801149:	90                   	nop
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80114f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801152:	8b 40 08             	mov    0x8(%eax),%eax
  801155:	8d 50 01             	lea    0x1(%eax),%edx
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80115e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801161:	8b 10                	mov    (%eax),%edx
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	8b 40 04             	mov    0x4(%eax),%eax
  801169:	39 c2                	cmp    %eax,%edx
  80116b:	73 12                	jae    80117f <sprintputch+0x33>
		*b->buf++ = ch;
  80116d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801170:	8b 00                	mov    (%eax),%eax
  801172:	8d 48 01             	lea    0x1(%eax),%ecx
  801175:	8b 55 0c             	mov    0xc(%ebp),%edx
  801178:	89 0a                	mov    %ecx,(%edx)
  80117a:	8b 55 08             	mov    0x8(%ebp),%edx
  80117d:	88 10                	mov    %dl,(%eax)
}
  80117f:	90                   	nop
  801180:	5d                   	pop    %ebp
  801181:	c3                   	ret    

00801182 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
  801185:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	8d 50 ff             	lea    -0x1(%eax),%edx
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	01 d0                	add    %edx,%eax
  801199:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80119c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a7:	74 06                	je     8011af <vsnprintf+0x2d>
  8011a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ad:	7f 07                	jg     8011b6 <vsnprintf+0x34>
		return -E_INVAL;
  8011af:	b8 03 00 00 00       	mov    $0x3,%eax
  8011b4:	eb 20                	jmp    8011d6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011b6:	ff 75 14             	pushl  0x14(%ebp)
  8011b9:	ff 75 10             	pushl  0x10(%ebp)
  8011bc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011bf:	50                   	push   %eax
  8011c0:	68 4c 11 80 00       	push   $0x80114c
  8011c5:	e8 92 fb ff ff       	call   800d5c <vprintfmt>
  8011ca:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011d6:	c9                   	leave  
  8011d7:	c3                   	ret    

008011d8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
  8011db:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011de:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e1:	83 c0 04             	add    $0x4,%eax
  8011e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ed:	50                   	push   %eax
  8011ee:	ff 75 0c             	pushl  0xc(%ebp)
  8011f1:	ff 75 08             	pushl  0x8(%ebp)
  8011f4:	e8 89 ff ff ff       	call   801182 <vsnprintf>
  8011f9:	83 c4 10             	add    $0x10,%esp
  8011fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
  801207:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80120a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80120e:	74 13                	je     801223 <readline+0x1f>
		cprintf("%s", prompt);
  801210:	83 ec 08             	sub    $0x8,%esp
  801213:	ff 75 08             	pushl  0x8(%ebp)
  801216:	68 70 2f 80 00       	push   $0x802f70
  80121b:	e8 62 f9 ff ff       	call   800b82 <cprintf>
  801220:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801223:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80122a:	83 ec 0c             	sub    $0xc,%esp
  80122d:	6a 00                	push   $0x0
  80122f:	e8 5d f5 ff ff       	call   800791 <iscons>
  801234:	83 c4 10             	add    $0x10,%esp
  801237:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80123a:	e8 04 f5 ff ff       	call   800743 <getchar>
  80123f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801242:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801246:	79 22                	jns    80126a <readline+0x66>
			if (c != -E_EOF)
  801248:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80124c:	0f 84 ad 00 00 00    	je     8012ff <readline+0xfb>
				cprintf("read error: %e\n", c);
  801252:	83 ec 08             	sub    $0x8,%esp
  801255:	ff 75 ec             	pushl  -0x14(%ebp)
  801258:	68 73 2f 80 00       	push   $0x802f73
  80125d:	e8 20 f9 ff ff       	call   800b82 <cprintf>
  801262:	83 c4 10             	add    $0x10,%esp
			return;
  801265:	e9 95 00 00 00       	jmp    8012ff <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80126a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80126e:	7e 34                	jle    8012a4 <readline+0xa0>
  801270:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801277:	7f 2b                	jg     8012a4 <readline+0xa0>
			if (echoing)
  801279:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80127d:	74 0e                	je     80128d <readline+0x89>
				cputchar(c);
  80127f:	83 ec 0c             	sub    $0xc,%esp
  801282:	ff 75 ec             	pushl  -0x14(%ebp)
  801285:	e8 71 f4 ff ff       	call   8006fb <cputchar>
  80128a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80128d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801290:	8d 50 01             	lea    0x1(%eax),%edx
  801293:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801296:	89 c2                	mov    %eax,%edx
  801298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129b:	01 d0                	add    %edx,%eax
  80129d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a0:	88 10                	mov    %dl,(%eax)
  8012a2:	eb 56                	jmp    8012fa <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012a4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012a8:	75 1f                	jne    8012c9 <readline+0xc5>
  8012aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012ae:	7e 19                	jle    8012c9 <readline+0xc5>
			if (echoing)
  8012b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b4:	74 0e                	je     8012c4 <readline+0xc0>
				cputchar(c);
  8012b6:	83 ec 0c             	sub    $0xc,%esp
  8012b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012bc:	e8 3a f4 ff ff       	call   8006fb <cputchar>
  8012c1:	83 c4 10             	add    $0x10,%esp

			i--;
  8012c4:	ff 4d f4             	decl   -0xc(%ebp)
  8012c7:	eb 31                	jmp    8012fa <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012c9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012cd:	74 0a                	je     8012d9 <readline+0xd5>
  8012cf:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012d3:	0f 85 61 ff ff ff    	jne    80123a <readline+0x36>
			if (echoing)
  8012d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012dd:	74 0e                	je     8012ed <readline+0xe9>
				cputchar(c);
  8012df:	83 ec 0c             	sub    $0xc,%esp
  8012e2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e5:	e8 11 f4 ff ff       	call   8006fb <cputchar>
  8012ea:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	01 d0                	add    %edx,%eax
  8012f5:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012f8:	eb 06                	jmp    801300 <readline+0xfc>
		}
	}
  8012fa:	e9 3b ff ff ff       	jmp    80123a <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012ff:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
  801305:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801308:	e8 73 0e 00 00       	call   802180 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80130d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801311:	74 13                	je     801326 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801313:	83 ec 08             	sub    $0x8,%esp
  801316:	ff 75 08             	pushl  0x8(%ebp)
  801319:	68 70 2f 80 00       	push   $0x802f70
  80131e:	e8 5f f8 ff ff       	call   800b82 <cprintf>
  801323:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80132d:	83 ec 0c             	sub    $0xc,%esp
  801330:	6a 00                	push   $0x0
  801332:	e8 5a f4 ff ff       	call   800791 <iscons>
  801337:	83 c4 10             	add    $0x10,%esp
  80133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80133d:	e8 01 f4 ff ff       	call   800743 <getchar>
  801342:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801345:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801349:	79 23                	jns    80136e <atomic_readline+0x6c>
			if (c != -E_EOF)
  80134b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80134f:	74 13                	je     801364 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801351:	83 ec 08             	sub    $0x8,%esp
  801354:	ff 75 ec             	pushl  -0x14(%ebp)
  801357:	68 73 2f 80 00       	push   $0x802f73
  80135c:	e8 21 f8 ff ff       	call   800b82 <cprintf>
  801361:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801364:	e8 31 0e 00 00       	call   80219a <sys_enable_interrupt>
			return;
  801369:	e9 9a 00 00 00       	jmp    801408 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80136e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801372:	7e 34                	jle    8013a8 <atomic_readline+0xa6>
  801374:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80137b:	7f 2b                	jg     8013a8 <atomic_readline+0xa6>
			if (echoing)
  80137d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801381:	74 0e                	je     801391 <atomic_readline+0x8f>
				cputchar(c);
  801383:	83 ec 0c             	sub    $0xc,%esp
  801386:	ff 75 ec             	pushl  -0x14(%ebp)
  801389:	e8 6d f3 ff ff       	call   8006fb <cputchar>
  80138e:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801394:	8d 50 01             	lea    0x1(%eax),%edx
  801397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80139a:	89 c2                	mov    %eax,%edx
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	01 d0                	add    %edx,%eax
  8013a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a4:	88 10                	mov    %dl,(%eax)
  8013a6:	eb 5b                	jmp    801403 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013a8:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013ac:	75 1f                	jne    8013cd <atomic_readline+0xcb>
  8013ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013b2:	7e 19                	jle    8013cd <atomic_readline+0xcb>
			if (echoing)
  8013b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013b8:	74 0e                	je     8013c8 <atomic_readline+0xc6>
				cputchar(c);
  8013ba:	83 ec 0c             	sub    $0xc,%esp
  8013bd:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c0:	e8 36 f3 ff ff       	call   8006fb <cputchar>
  8013c5:	83 c4 10             	add    $0x10,%esp
			i--;
  8013c8:	ff 4d f4             	decl   -0xc(%ebp)
  8013cb:	eb 36                	jmp    801403 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013cd:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013d1:	74 0a                	je     8013dd <atomic_readline+0xdb>
  8013d3:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013d7:	0f 85 60 ff ff ff    	jne    80133d <atomic_readline+0x3b>
			if (echoing)
  8013dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e1:	74 0e                	je     8013f1 <atomic_readline+0xef>
				cputchar(c);
  8013e3:	83 ec 0c             	sub    $0xc,%esp
  8013e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e9:	e8 0d f3 ff ff       	call   8006fb <cputchar>
  8013ee:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f7:	01 d0                	add    %edx,%eax
  8013f9:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013fc:	e8 99 0d 00 00       	call   80219a <sys_enable_interrupt>
			return;
  801401:	eb 05                	jmp    801408 <atomic_readline+0x106>
		}
	}
  801403:	e9 35 ff ff ff       	jmp    80133d <atomic_readline+0x3b>
}
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
  80140d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801417:	eb 06                	jmp    80141f <strlen+0x15>
		n++;
  801419:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80141c:	ff 45 08             	incl   0x8(%ebp)
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	84 c0                	test   %al,%al
  801426:	75 f1                	jne    801419 <strlen+0xf>
		n++;
	return n;
  801428:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
  801430:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801433:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80143a:	eb 09                	jmp    801445 <strnlen+0x18>
		n++;
  80143c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80143f:	ff 45 08             	incl   0x8(%ebp)
  801442:	ff 4d 0c             	decl   0xc(%ebp)
  801445:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801449:	74 09                	je     801454 <strnlen+0x27>
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	84 c0                	test   %al,%al
  801452:	75 e8                	jne    80143c <strnlen+0xf>
		n++;
	return n;
  801454:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801457:	c9                   	leave  
  801458:	c3                   	ret    

00801459 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
  80145c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801465:	90                   	nop
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8d 50 01             	lea    0x1(%eax),%edx
  80146c:	89 55 08             	mov    %edx,0x8(%ebp)
  80146f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801472:	8d 4a 01             	lea    0x1(%edx),%ecx
  801475:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801478:	8a 12                	mov    (%edx),%dl
  80147a:	88 10                	mov    %dl,(%eax)
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	84 c0                	test   %al,%al
  801480:	75 e4                	jne    801466 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801482:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
  80148a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801493:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80149a:	eb 1f                	jmp    8014bb <strncpy+0x34>
		*dst++ = *src;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8d 50 01             	lea    0x1(%eax),%edx
  8014a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a8:	8a 12                	mov    (%edx),%dl
  8014aa:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014af:	8a 00                	mov    (%eax),%al
  8014b1:	84 c0                	test   %al,%al
  8014b3:	74 03                	je     8014b8 <strncpy+0x31>
			src++;
  8014b5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014b8:	ff 45 fc             	incl   -0x4(%ebp)
  8014bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014be:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014c1:	72 d9                	jb     80149c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d8:	74 30                	je     80150a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014da:	eb 16                	jmp    8014f2 <strlcpy+0x2a>
			*dst++ = *src++;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	8d 50 01             	lea    0x1(%eax),%edx
  8014e2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014eb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014ee:	8a 12                	mov    (%edx),%dl
  8014f0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014f2:	ff 4d 10             	decl   0x10(%ebp)
  8014f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f9:	74 09                	je     801504 <strlcpy+0x3c>
  8014fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	84 c0                	test   %al,%al
  801502:	75 d8                	jne    8014dc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80150a:	8b 55 08             	mov    0x8(%ebp),%edx
  80150d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801510:	29 c2                	sub    %eax,%edx
  801512:	89 d0                	mov    %edx,%eax
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801519:	eb 06                	jmp    801521 <strcmp+0xb>
		p++, q++;
  80151b:	ff 45 08             	incl   0x8(%ebp)
  80151e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	8a 00                	mov    (%eax),%al
  801526:	84 c0                	test   %al,%al
  801528:	74 0e                	je     801538 <strcmp+0x22>
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	8a 10                	mov    (%eax),%dl
  80152f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	38 c2                	cmp    %al,%dl
  801536:	74 e3                	je     80151b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	0f b6 d0             	movzbl %al,%edx
  801540:	8b 45 0c             	mov    0xc(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	0f b6 c0             	movzbl %al,%eax
  801548:	29 c2                	sub    %eax,%edx
  80154a:	89 d0                	mov    %edx,%eax
}
  80154c:	5d                   	pop    %ebp
  80154d:	c3                   	ret    

0080154e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801551:	eb 09                	jmp    80155c <strncmp+0xe>
		n--, p++, q++;
  801553:	ff 4d 10             	decl   0x10(%ebp)
  801556:	ff 45 08             	incl   0x8(%ebp)
  801559:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80155c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801560:	74 17                	je     801579 <strncmp+0x2b>
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	8a 00                	mov    (%eax),%al
  801567:	84 c0                	test   %al,%al
  801569:	74 0e                	je     801579 <strncmp+0x2b>
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8a 10                	mov    (%eax),%dl
  801570:	8b 45 0c             	mov    0xc(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	38 c2                	cmp    %al,%dl
  801577:	74 da                	je     801553 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801579:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80157d:	75 07                	jne    801586 <strncmp+0x38>
		return 0;
  80157f:	b8 00 00 00 00       	mov    $0x0,%eax
  801584:	eb 14                	jmp    80159a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	8a 00                	mov    (%eax),%al
  80158b:	0f b6 d0             	movzbl %al,%edx
  80158e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801591:	8a 00                	mov    (%eax),%al
  801593:	0f b6 c0             	movzbl %al,%eax
  801596:	29 c2                	sub    %eax,%edx
  801598:	89 d0                	mov    %edx,%eax
}
  80159a:	5d                   	pop    %ebp
  80159b:	c3                   	ret    

0080159c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
  80159f:	83 ec 04             	sub    $0x4,%esp
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015a8:	eb 12                	jmp    8015bc <strchr+0x20>
		if (*s == c)
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015b2:	75 05                	jne    8015b9 <strchr+0x1d>
			return (char *) s;
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	eb 11                	jmp    8015ca <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015b9:	ff 45 08             	incl   0x8(%ebp)
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	8a 00                	mov    (%eax),%al
  8015c1:	84 c0                	test   %al,%al
  8015c3:	75 e5                	jne    8015aa <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
  8015cf:	83 ec 04             	sub    $0x4,%esp
  8015d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015d8:	eb 0d                	jmp    8015e7 <strfind+0x1b>
		if (*s == c)
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015e2:	74 0e                	je     8015f2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015e4:	ff 45 08             	incl   0x8(%ebp)
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	84 c0                	test   %al,%al
  8015ee:	75 ea                	jne    8015da <strfind+0xe>
  8015f0:	eb 01                	jmp    8015f3 <strfind+0x27>
		if (*s == c)
			break;
  8015f2:	90                   	nop
	return (char *) s;
  8015f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
  8015fb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801604:	8b 45 10             	mov    0x10(%ebp),%eax
  801607:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80160a:	eb 0e                	jmp    80161a <memset+0x22>
		*p++ = c;
  80160c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160f:	8d 50 01             	lea    0x1(%eax),%edx
  801612:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801615:	8b 55 0c             	mov    0xc(%ebp),%edx
  801618:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80161a:	ff 4d f8             	decl   -0x8(%ebp)
  80161d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801621:	79 e9                	jns    80160c <memset+0x14>
		*p++ = c;

	return v;
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
  80162b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80162e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801631:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80163a:	eb 16                	jmp    801652 <memcpy+0x2a>
		*d++ = *s++;
  80163c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163f:	8d 50 01             	lea    0x1(%eax),%edx
  801642:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801645:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801648:	8d 4a 01             	lea    0x1(%edx),%ecx
  80164b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80164e:	8a 12                	mov    (%edx),%dl
  801650:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	8d 50 ff             	lea    -0x1(%eax),%edx
  801658:	89 55 10             	mov    %edx,0x10(%ebp)
  80165b:	85 c0                	test   %eax,%eax
  80165d:	75 dd                	jne    80163c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
  801667:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80166a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801676:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801679:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80167c:	73 50                	jae    8016ce <memmove+0x6a>
  80167e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801681:	8b 45 10             	mov    0x10(%ebp),%eax
  801684:	01 d0                	add    %edx,%eax
  801686:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801689:	76 43                	jbe    8016ce <memmove+0x6a>
		s += n;
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801691:	8b 45 10             	mov    0x10(%ebp),%eax
  801694:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801697:	eb 10                	jmp    8016a9 <memmove+0x45>
			*--d = *--s;
  801699:	ff 4d f8             	decl   -0x8(%ebp)
  80169c:	ff 4d fc             	decl   -0x4(%ebp)
  80169f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a2:	8a 10                	mov    (%eax),%dl
  8016a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016af:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b2:	85 c0                	test   %eax,%eax
  8016b4:	75 e3                	jne    801699 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016b6:	eb 23                	jmp    8016db <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bb:	8d 50 01             	lea    0x1(%eax),%edx
  8016be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016c7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016ca:	8a 12                	mov    (%edx),%dl
  8016cc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d7:	85 c0                	test   %eax,%eax
  8016d9:	75 dd                	jne    8016b8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016de:	c9                   	leave  
  8016df:	c3                   	ret    

008016e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ef:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016f2:	eb 2a                	jmp    80171e <memcmp+0x3e>
		if (*s1 != *s2)
  8016f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f7:	8a 10                	mov    (%eax),%dl
  8016f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fc:	8a 00                	mov    (%eax),%al
  8016fe:	38 c2                	cmp    %al,%dl
  801700:	74 16                	je     801718 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801702:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	0f b6 d0             	movzbl %al,%edx
  80170a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170d:	8a 00                	mov    (%eax),%al
  80170f:	0f b6 c0             	movzbl %al,%eax
  801712:	29 c2                	sub    %eax,%edx
  801714:	89 d0                	mov    %edx,%eax
  801716:	eb 18                	jmp    801730 <memcmp+0x50>
		s1++, s2++;
  801718:	ff 45 fc             	incl   -0x4(%ebp)
  80171b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80171e:	8b 45 10             	mov    0x10(%ebp),%eax
  801721:	8d 50 ff             	lea    -0x1(%eax),%edx
  801724:	89 55 10             	mov    %edx,0x10(%ebp)
  801727:	85 c0                	test   %eax,%eax
  801729:	75 c9                	jne    8016f4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80172b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
  801735:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801738:	8b 55 08             	mov    0x8(%ebp),%edx
  80173b:	8b 45 10             	mov    0x10(%ebp),%eax
  80173e:	01 d0                	add    %edx,%eax
  801740:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801743:	eb 15                	jmp    80175a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	8a 00                	mov    (%eax),%al
  80174a:	0f b6 d0             	movzbl %al,%edx
  80174d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801750:	0f b6 c0             	movzbl %al,%eax
  801753:	39 c2                	cmp    %eax,%edx
  801755:	74 0d                	je     801764 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801757:	ff 45 08             	incl   0x8(%ebp)
  80175a:	8b 45 08             	mov    0x8(%ebp),%eax
  80175d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801760:	72 e3                	jb     801745 <memfind+0x13>
  801762:	eb 01                	jmp    801765 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801764:	90                   	nop
	return (void *) s;
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801770:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801777:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80177e:	eb 03                	jmp    801783 <strtol+0x19>
		s++;
  801780:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	3c 20                	cmp    $0x20,%al
  80178a:	74 f4                	je     801780 <strtol+0x16>
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	3c 09                	cmp    $0x9,%al
  801793:	74 eb                	je     801780 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801795:	8b 45 08             	mov    0x8(%ebp),%eax
  801798:	8a 00                	mov    (%eax),%al
  80179a:	3c 2b                	cmp    $0x2b,%al
  80179c:	75 05                	jne    8017a3 <strtol+0x39>
		s++;
  80179e:	ff 45 08             	incl   0x8(%ebp)
  8017a1:	eb 13                	jmp    8017b6 <strtol+0x4c>
	else if (*s == '-')
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	3c 2d                	cmp    $0x2d,%al
  8017aa:	75 0a                	jne    8017b6 <strtol+0x4c>
		s++, neg = 1;
  8017ac:	ff 45 08             	incl   0x8(%ebp)
  8017af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ba:	74 06                	je     8017c2 <strtol+0x58>
  8017bc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017c0:	75 20                	jne    8017e2 <strtol+0x78>
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	3c 30                	cmp    $0x30,%al
  8017c9:	75 17                	jne    8017e2 <strtol+0x78>
  8017cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ce:	40                   	inc    %eax
  8017cf:	8a 00                	mov    (%eax),%al
  8017d1:	3c 78                	cmp    $0x78,%al
  8017d3:	75 0d                	jne    8017e2 <strtol+0x78>
		s += 2, base = 16;
  8017d5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017d9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017e0:	eb 28                	jmp    80180a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017e6:	75 15                	jne    8017fd <strtol+0x93>
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	8a 00                	mov    (%eax),%al
  8017ed:	3c 30                	cmp    $0x30,%al
  8017ef:	75 0c                	jne    8017fd <strtol+0x93>
		s++, base = 8;
  8017f1:	ff 45 08             	incl   0x8(%ebp)
  8017f4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017fb:	eb 0d                	jmp    80180a <strtol+0xa0>
	else if (base == 0)
  8017fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801801:	75 07                	jne    80180a <strtol+0xa0>
		base = 10;
  801803:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	3c 2f                	cmp    $0x2f,%al
  801811:	7e 19                	jle    80182c <strtol+0xc2>
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	3c 39                	cmp    $0x39,%al
  80181a:	7f 10                	jg     80182c <strtol+0xc2>
			dig = *s - '0';
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	8a 00                	mov    (%eax),%al
  801821:	0f be c0             	movsbl %al,%eax
  801824:	83 e8 30             	sub    $0x30,%eax
  801827:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80182a:	eb 42                	jmp    80186e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	3c 60                	cmp    $0x60,%al
  801833:	7e 19                	jle    80184e <strtol+0xe4>
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	3c 7a                	cmp    $0x7a,%al
  80183c:	7f 10                	jg     80184e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	0f be c0             	movsbl %al,%eax
  801846:	83 e8 57             	sub    $0x57,%eax
  801849:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80184c:	eb 20                	jmp    80186e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80184e:	8b 45 08             	mov    0x8(%ebp),%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	3c 40                	cmp    $0x40,%al
  801855:	7e 39                	jle    801890 <strtol+0x126>
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	8a 00                	mov    (%eax),%al
  80185c:	3c 5a                	cmp    $0x5a,%al
  80185e:	7f 30                	jg     801890 <strtol+0x126>
			dig = *s - 'A' + 10;
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	8a 00                	mov    (%eax),%al
  801865:	0f be c0             	movsbl %al,%eax
  801868:	83 e8 37             	sub    $0x37,%eax
  80186b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801871:	3b 45 10             	cmp    0x10(%ebp),%eax
  801874:	7d 19                	jge    80188f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801876:	ff 45 08             	incl   0x8(%ebp)
  801879:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801880:	89 c2                	mov    %eax,%edx
  801882:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801885:	01 d0                	add    %edx,%eax
  801887:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80188a:	e9 7b ff ff ff       	jmp    80180a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80188f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801890:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801894:	74 08                	je     80189e <strtol+0x134>
		*endptr = (char *) s;
  801896:	8b 45 0c             	mov    0xc(%ebp),%eax
  801899:	8b 55 08             	mov    0x8(%ebp),%edx
  80189c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80189e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a2:	74 07                	je     8018ab <strtol+0x141>
  8018a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a7:	f7 d8                	neg    %eax
  8018a9:	eb 03                	jmp    8018ae <strtol+0x144>
  8018ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <ltostr>:

void
ltostr(long value, char *str)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018c4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018c8:	79 13                	jns    8018dd <ltostr+0x2d>
	{
		neg = 1;
  8018ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018d7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018da:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018e5:	99                   	cltd   
  8018e6:	f7 f9                	idiv   %ecx
  8018e8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ee:	8d 50 01             	lea    0x1(%eax),%edx
  8018f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018f4:	89 c2                	mov    %eax,%edx
  8018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f9:	01 d0                	add    %edx,%eax
  8018fb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018fe:	83 c2 30             	add    $0x30,%edx
  801901:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801903:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801906:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80190b:	f7 e9                	imul   %ecx
  80190d:	c1 fa 02             	sar    $0x2,%edx
  801910:	89 c8                	mov    %ecx,%eax
  801912:	c1 f8 1f             	sar    $0x1f,%eax
  801915:	29 c2                	sub    %eax,%edx
  801917:	89 d0                	mov    %edx,%eax
  801919:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80191c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80191f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801924:	f7 e9                	imul   %ecx
  801926:	c1 fa 02             	sar    $0x2,%edx
  801929:	89 c8                	mov    %ecx,%eax
  80192b:	c1 f8 1f             	sar    $0x1f,%eax
  80192e:	29 c2                	sub    %eax,%edx
  801930:	89 d0                	mov    %edx,%eax
  801932:	c1 e0 02             	shl    $0x2,%eax
  801935:	01 d0                	add    %edx,%eax
  801937:	01 c0                	add    %eax,%eax
  801939:	29 c1                	sub    %eax,%ecx
  80193b:	89 ca                	mov    %ecx,%edx
  80193d:	85 d2                	test   %edx,%edx
  80193f:	75 9c                	jne    8018dd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801941:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801948:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80194b:	48                   	dec    %eax
  80194c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80194f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801953:	74 3d                	je     801992 <ltostr+0xe2>
		start = 1 ;
  801955:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80195c:	eb 34                	jmp    801992 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80195e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801961:	8b 45 0c             	mov    0xc(%ebp),%eax
  801964:	01 d0                	add    %edx,%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80196b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80196e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801971:	01 c2                	add    %eax,%edx
  801973:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801976:	8b 45 0c             	mov    0xc(%ebp),%eax
  801979:	01 c8                	add    %ecx,%eax
  80197b:	8a 00                	mov    (%eax),%al
  80197d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80197f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801982:	8b 45 0c             	mov    0xc(%ebp),%eax
  801985:	01 c2                	add    %eax,%edx
  801987:	8a 45 eb             	mov    -0x15(%ebp),%al
  80198a:	88 02                	mov    %al,(%edx)
		start++ ;
  80198c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80198f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801992:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801995:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801998:	7c c4                	jl     80195e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80199a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80199d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a0:	01 d0                	add    %edx,%eax
  8019a2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019a5:	90                   	nop
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
  8019ab:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019ae:	ff 75 08             	pushl  0x8(%ebp)
  8019b1:	e8 54 fa ff ff       	call   80140a <strlen>
  8019b6:	83 c4 04             	add    $0x4,%esp
  8019b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019bc:	ff 75 0c             	pushl  0xc(%ebp)
  8019bf:	e8 46 fa ff ff       	call   80140a <strlen>
  8019c4:	83 c4 04             	add    $0x4,%esp
  8019c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019d8:	eb 17                	jmp    8019f1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e0:	01 c2                	add    %eax,%edx
  8019e2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	01 c8                	add    %ecx,%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019ee:	ff 45 fc             	incl   -0x4(%ebp)
  8019f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019f7:	7c e1                	jl     8019da <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a07:	eb 1f                	jmp    801a28 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a0c:	8d 50 01             	lea    0x1(%eax),%edx
  801a0f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a12:	89 c2                	mov    %eax,%edx
  801a14:	8b 45 10             	mov    0x10(%ebp),%eax
  801a17:	01 c2                	add    %eax,%edx
  801a19:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1f:	01 c8                	add    %ecx,%eax
  801a21:	8a 00                	mov    (%eax),%al
  801a23:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a25:	ff 45 f8             	incl   -0x8(%ebp)
  801a28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a2b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a2e:	7c d9                	jl     801a09 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a30:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c6 00 00             	movb   $0x0,(%eax)
}
  801a3b:	90                   	nop
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a41:	8b 45 14             	mov    0x14(%ebp),%eax
  801a44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a4a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4d:	8b 00                	mov    (%eax),%eax
  801a4f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a56:	8b 45 10             	mov    0x10(%ebp),%eax
  801a59:	01 d0                	add    %edx,%eax
  801a5b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a61:	eb 0c                	jmp    801a6f <strsplit+0x31>
			*string++ = 0;
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	8d 50 01             	lea    0x1(%eax),%edx
  801a69:	89 55 08             	mov    %edx,0x8(%ebp)
  801a6c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	8a 00                	mov    (%eax),%al
  801a74:	84 c0                	test   %al,%al
  801a76:	74 18                	je     801a90 <strsplit+0x52>
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	8a 00                	mov    (%eax),%al
  801a7d:	0f be c0             	movsbl %al,%eax
  801a80:	50                   	push   %eax
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	e8 13 fb ff ff       	call   80159c <strchr>
  801a89:	83 c4 08             	add    $0x8,%esp
  801a8c:	85 c0                	test   %eax,%eax
  801a8e:	75 d3                	jne    801a63 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a90:	8b 45 08             	mov    0x8(%ebp),%eax
  801a93:	8a 00                	mov    (%eax),%al
  801a95:	84 c0                	test   %al,%al
  801a97:	74 5a                	je     801af3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a99:	8b 45 14             	mov    0x14(%ebp),%eax
  801a9c:	8b 00                	mov    (%eax),%eax
  801a9e:	83 f8 0f             	cmp    $0xf,%eax
  801aa1:	75 07                	jne    801aaa <strsplit+0x6c>
		{
			return 0;
  801aa3:	b8 00 00 00 00       	mov    $0x0,%eax
  801aa8:	eb 66                	jmp    801b10 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aaa:	8b 45 14             	mov    0x14(%ebp),%eax
  801aad:	8b 00                	mov    (%eax),%eax
  801aaf:	8d 48 01             	lea    0x1(%eax),%ecx
  801ab2:	8b 55 14             	mov    0x14(%ebp),%edx
  801ab5:	89 0a                	mov    %ecx,(%edx)
  801ab7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801abe:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac1:	01 c2                	add    %eax,%edx
  801ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac8:	eb 03                	jmp    801acd <strsplit+0x8f>
			string++;
  801aca:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	8a 00                	mov    (%eax),%al
  801ad2:	84 c0                	test   %al,%al
  801ad4:	74 8b                	je     801a61 <strsplit+0x23>
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	8a 00                	mov    (%eax),%al
  801adb:	0f be c0             	movsbl %al,%eax
  801ade:	50                   	push   %eax
  801adf:	ff 75 0c             	pushl  0xc(%ebp)
  801ae2:	e8 b5 fa ff ff       	call   80159c <strchr>
  801ae7:	83 c4 08             	add    $0x8,%esp
  801aea:	85 c0                	test   %eax,%eax
  801aec:	74 dc                	je     801aca <strsplit+0x8c>
			string++;
	}
  801aee:	e9 6e ff ff ff       	jmp    801a61 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801af3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801af4:	8b 45 14             	mov    0x14(%ebp),%eax
  801af7:	8b 00                	mov    (%eax),%eax
  801af9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b00:	8b 45 10             	mov    0x10(%ebp),%eax
  801b03:	01 d0                	add    %edx,%eax
  801b05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b0b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
  801b15:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801b18:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801b1f:	76 0a                	jbe    801b2b <malloc+0x19>
		return NULL;
  801b21:	b8 00 00 00 00       	mov    $0x0,%eax
  801b26:	e9 ad 02 00 00       	jmp    801dd8 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	c1 e8 0c             	shr    $0xc,%eax
  801b31:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801b34:	8b 45 08             	mov    0x8(%ebp),%eax
  801b37:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b3c:	85 c0                	test   %eax,%eax
  801b3e:	74 03                	je     801b43 <malloc+0x31>
		num++;
  801b40:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801b43:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b48:	85 c0                	test   %eax,%eax
  801b4a:	75 71                	jne    801bbd <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801b4c:	a1 04 30 80 00       	mov    0x803004,%eax
  801b51:	83 ec 08             	sub    $0x8,%esp
  801b54:	ff 75 08             	pushl  0x8(%ebp)
  801b57:	50                   	push   %eax
  801b58:	e8 ba 05 00 00       	call   802117 <sys_allocateMem>
  801b5d:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801b60:	a1 04 30 80 00       	mov    0x803004,%eax
  801b65:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6b:	c1 e0 0c             	shl    $0xc,%eax
  801b6e:	89 c2                	mov    %eax,%edx
  801b70:	a1 04 30 80 00       	mov    0x803004,%eax
  801b75:	01 d0                	add    %edx,%eax
  801b77:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801b7c:	a1 30 30 80 00       	mov    0x803030,%eax
  801b81:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b84:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801b8b:	a1 30 30 80 00       	mov    0x803030,%eax
  801b90:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801b93:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801b9a:	a1 30 30 80 00       	mov    0x803030,%eax
  801b9f:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801ba6:	01 00 00 00 
		sizeofarray++;
  801baa:	a1 30 30 80 00       	mov    0x803030,%eax
  801baf:	40                   	inc    %eax
  801bb0:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801bb5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801bb8:	e9 1b 02 00 00       	jmp    801dd8 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801bbd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801bc4:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801bcb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801bd2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801bd9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801be0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801be7:	eb 72                	jmp    801c5b <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801be9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801bec:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801bf3:	85 c0                	test   %eax,%eax
  801bf5:	75 12                	jne    801c09 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801bf7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801bfa:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801c01:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801c04:	ff 45 dc             	incl   -0x24(%ebp)
  801c07:	eb 4f                	jmp    801c58 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c0c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801c0f:	7d 39                	jge    801c4a <malloc+0x138>
  801c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c14:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c17:	7c 31                	jl     801c4a <malloc+0x138>
					{
						min=count;
  801c19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801c1f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c22:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c29:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c2c:	c1 e2 0c             	shl    $0xc,%edx
  801c2f:	29 d0                	sub    %edx,%eax
  801c31:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801c34:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c37:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801c3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801c3d:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801c44:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c47:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801c4a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801c51:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801c58:	ff 45 d4             	incl   -0x2c(%ebp)
  801c5b:	a1 30 30 80 00       	mov    0x803030,%eax
  801c60:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801c63:	7c 84                	jl     801be9 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801c65:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801c69:	0f 85 e3 00 00 00    	jne    801d52 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801c6f:	83 ec 08             	sub    $0x8,%esp
  801c72:	ff 75 08             	pushl  0x8(%ebp)
  801c75:	ff 75 e0             	pushl  -0x20(%ebp)
  801c78:	e8 9a 04 00 00       	call   802117 <sys_allocateMem>
  801c7d:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801c80:	a1 30 30 80 00       	mov    0x803030,%eax
  801c85:	40                   	inc    %eax
  801c86:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801c8b:	a1 30 30 80 00       	mov    0x803030,%eax
  801c90:	48                   	dec    %eax
  801c91:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c94:	eb 42                	jmp    801cd8 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801c96:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c99:	48                   	dec    %eax
  801c9a:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801ca1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ca4:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801cab:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cae:	48                   	dec    %eax
  801caf:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801cb6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cb9:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801cc0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cc3:	48                   	dec    %eax
  801cc4:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801ccb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cce:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801cd5:	ff 4d d0             	decl   -0x30(%ebp)
  801cd8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cdb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cde:	7f b6                	jg     801c96 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801ce0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ce3:	40                   	inc    %eax
  801ce4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801ce7:	8b 55 08             	mov    0x8(%ebp),%edx
  801cea:	01 ca                	add    %ecx,%edx
  801cec:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801cf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801cf6:	8d 50 01             	lea    0x1(%eax),%edx
  801cf9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801cfc:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801d03:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801d06:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801d0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d10:	40                   	inc    %eax
  801d11:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801d18:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801d1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d22:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801d29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d2c:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801d2f:	eb 11                	jmp    801d42 <malloc+0x230>
				{
					changed[index] = 1;
  801d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d34:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801d3b:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801d3f:	ff 45 cc             	incl   -0x34(%ebp)
  801d42:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801d45:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d48:	7c e7                	jl     801d31 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801d4a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d4d:	e9 86 00 00 00       	jmp    801dd8 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801d52:	a1 04 30 80 00       	mov    0x803004,%eax
  801d57:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801d5c:	29 c2                	sub    %eax,%edx
  801d5e:	89 d0                	mov    %edx,%eax
  801d60:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d63:	73 07                	jae    801d6c <malloc+0x25a>
						return NULL;
  801d65:	b8 00 00 00 00       	mov    $0x0,%eax
  801d6a:	eb 6c                	jmp    801dd8 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801d6c:	a1 04 30 80 00       	mov    0x803004,%eax
  801d71:	83 ec 08             	sub    $0x8,%esp
  801d74:	ff 75 08             	pushl  0x8(%ebp)
  801d77:	50                   	push   %eax
  801d78:	e8 9a 03 00 00       	call   802117 <sys_allocateMem>
  801d7d:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801d80:	a1 04 30 80 00       	mov    0x803004,%eax
  801d85:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d8b:	c1 e0 0c             	shl    $0xc,%eax
  801d8e:	89 c2                	mov    %eax,%edx
  801d90:	a1 04 30 80 00       	mov    0x803004,%eax
  801d95:	01 d0                	add    %edx,%eax
  801d97:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801d9c:	a1 30 30 80 00       	mov    0x803030,%eax
  801da1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801da4:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801dab:	a1 30 30 80 00       	mov    0x803030,%eax
  801db0:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801db3:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801dba:	a1 30 30 80 00       	mov    0x803030,%eax
  801dbf:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801dc6:	01 00 00 00 
					sizeofarray++;
  801dca:	a1 30 30 80 00       	mov    0x803030,%eax
  801dcf:	40                   	inc    %eax
  801dd0:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801dd5:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801dd8:	c9                   	leave  
  801dd9:	c3                   	ret    

00801dda <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
  801ddd:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801de0:	8b 45 08             	mov    0x8(%ebp),%eax
  801de3:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801de6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801ded:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801df4:	eb 30                	jmp    801e26 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801df6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801df9:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801e00:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801e03:	75 1e                	jne    801e23 <free+0x49>
  801e05:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e08:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801e0f:	83 f8 01             	cmp    $0x1,%eax
  801e12:	75 0f                	jne    801e23 <free+0x49>
			is_found = 1;
  801e14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801e1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801e21:	eb 0d                	jmp    801e30 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801e23:	ff 45 ec             	incl   -0x14(%ebp)
  801e26:	a1 30 30 80 00       	mov    0x803030,%eax
  801e2b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801e2e:	7c c6                	jl     801df6 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801e30:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801e34:	75 3a                	jne    801e70 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801e36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e39:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801e40:	c1 e0 0c             	shl    $0xc,%eax
  801e43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801e46:	83 ec 08             	sub    $0x8,%esp
  801e49:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e4c:	ff 75 e8             	pushl  -0x18(%ebp)
  801e4f:	e8 a7 02 00 00       	call   8020fb <sys_freeMem>
  801e54:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e5a:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801e61:	00 00 00 00 
		changes++;
  801e65:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801e6a:	40                   	inc    %eax
  801e6b:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801e70:	90                   	nop
  801e71:	c9                   	leave  
  801e72:	c3                   	ret    

00801e73 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
  801e76:	83 ec 18             	sub    $0x18,%esp
  801e79:	8b 45 10             	mov    0x10(%ebp),%eax
  801e7c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801e7f:	83 ec 04             	sub    $0x4,%esp
  801e82:	68 84 2f 80 00       	push   $0x802f84
  801e87:	68 b6 00 00 00       	push   $0xb6
  801e8c:	68 a7 2f 80 00       	push   $0x802fa7
  801e91:	e8 4a ea ff ff       	call   8008e0 <_panic>

00801e96 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
  801e99:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e9c:	83 ec 04             	sub    $0x4,%esp
  801e9f:	68 84 2f 80 00       	push   $0x802f84
  801ea4:	68 bb 00 00 00       	push   $0xbb
  801ea9:	68 a7 2f 80 00       	push   $0x802fa7
  801eae:	e8 2d ea ff ff       	call   8008e0 <_panic>

00801eb3 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
  801eb6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801eb9:	83 ec 04             	sub    $0x4,%esp
  801ebc:	68 84 2f 80 00       	push   $0x802f84
  801ec1:	68 c0 00 00 00       	push   $0xc0
  801ec6:	68 a7 2f 80 00       	push   $0x802fa7
  801ecb:	e8 10 ea ff ff       	call   8008e0 <_panic>

00801ed0 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801ed0:	55                   	push   %ebp
  801ed1:	89 e5                	mov    %esp,%ebp
  801ed3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ed6:	83 ec 04             	sub    $0x4,%esp
  801ed9:	68 84 2f 80 00       	push   $0x802f84
  801ede:	68 c4 00 00 00       	push   $0xc4
  801ee3:	68 a7 2f 80 00       	push   $0x802fa7
  801ee8:	e8 f3 e9 ff ff       	call   8008e0 <_panic>

00801eed <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
  801ef0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ef3:	83 ec 04             	sub    $0x4,%esp
  801ef6:	68 84 2f 80 00       	push   $0x802f84
  801efb:	68 c9 00 00 00       	push   $0xc9
  801f00:	68 a7 2f 80 00       	push   $0x802fa7
  801f05:	e8 d6 e9 ff ff       	call   8008e0 <_panic>

00801f0a <shrink>:
}
void shrink(uint32 newSize) {
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
  801f0d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f10:	83 ec 04             	sub    $0x4,%esp
  801f13:	68 84 2f 80 00       	push   $0x802f84
  801f18:	68 cc 00 00 00       	push   $0xcc
  801f1d:	68 a7 2f 80 00       	push   $0x802fa7
  801f22:	e8 b9 e9 ff ff       	call   8008e0 <_panic>

00801f27 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
  801f2a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f2d:	83 ec 04             	sub    $0x4,%esp
  801f30:	68 84 2f 80 00       	push   $0x802f84
  801f35:	68 d0 00 00 00       	push   $0xd0
  801f3a:	68 a7 2f 80 00       	push   $0x802fa7
  801f3f:	e8 9c e9 ff ff       	call   8008e0 <_panic>

00801f44 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
  801f47:	57                   	push   %edi
  801f48:	56                   	push   %esi
  801f49:	53                   	push   %ebx
  801f4a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f53:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f56:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f59:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f5c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f5f:	cd 30                	int    $0x30
  801f61:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f64:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f67:	83 c4 10             	add    $0x10,%esp
  801f6a:	5b                   	pop    %ebx
  801f6b:	5e                   	pop    %esi
  801f6c:	5f                   	pop    %edi
  801f6d:	5d                   	pop    %ebp
  801f6e:	c3                   	ret    

00801f6f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f6f:	55                   	push   %ebp
  801f70:	89 e5                	mov    %esp,%ebp
  801f72:	83 ec 04             	sub    $0x4,%esp
  801f75:	8b 45 10             	mov    0x10(%ebp),%eax
  801f78:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f7b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	52                   	push   %edx
  801f87:	ff 75 0c             	pushl  0xc(%ebp)
  801f8a:	50                   	push   %eax
  801f8b:	6a 00                	push   $0x0
  801f8d:	e8 b2 ff ff ff       	call   801f44 <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
}
  801f95:	90                   	nop
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <sys_cgetc>:

int
sys_cgetc(void)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 01                	push   $0x1
  801fa7:	e8 98 ff ff ff       	call   801f44 <syscall>
  801fac:	83 c4 18             	add    $0x18,%esp
}
  801faf:	c9                   	leave  
  801fb0:	c3                   	ret    

00801fb1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801fb1:	55                   	push   %ebp
  801fb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	50                   	push   %eax
  801fc0:	6a 05                	push   $0x5
  801fc2:	e8 7d ff ff ff       	call   801f44 <syscall>
  801fc7:	83 c4 18             	add    $0x18,%esp
}
  801fca:	c9                   	leave  
  801fcb:	c3                   	ret    

00801fcc <sys_getenvid>:

int32 sys_getenvid(void)
{
  801fcc:	55                   	push   %ebp
  801fcd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 02                	push   $0x2
  801fdb:	e8 64 ff ff ff       	call   801f44 <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
}
  801fe3:	c9                   	leave  
  801fe4:	c3                   	ret    

00801fe5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801fe5:	55                   	push   %ebp
  801fe6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 03                	push   $0x3
  801ff4:	e8 4b ff ff ff       	call   801f44 <syscall>
  801ff9:	83 c4 18             	add    $0x18,%esp
}
  801ffc:	c9                   	leave  
  801ffd:	c3                   	ret    

00801ffe <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ffe:	55                   	push   %ebp
  801fff:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 04                	push   $0x4
  80200d:	e8 32 ff ff ff       	call   801f44 <syscall>
  802012:	83 c4 18             	add    $0x18,%esp
}
  802015:	c9                   	leave  
  802016:	c3                   	ret    

00802017 <sys_env_exit>:


void sys_env_exit(void)
{
  802017:	55                   	push   %ebp
  802018:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 06                	push   $0x6
  802026:	e8 19 ff ff ff       	call   801f44 <syscall>
  80202b:	83 c4 18             	add    $0x18,%esp
}
  80202e:	90                   	nop
  80202f:	c9                   	leave  
  802030:	c3                   	ret    

00802031 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802031:	55                   	push   %ebp
  802032:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802034:	8b 55 0c             	mov    0xc(%ebp),%edx
  802037:	8b 45 08             	mov    0x8(%ebp),%eax
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	52                   	push   %edx
  802041:	50                   	push   %eax
  802042:	6a 07                	push   $0x7
  802044:	e8 fb fe ff ff       	call   801f44 <syscall>
  802049:	83 c4 18             	add    $0x18,%esp
}
  80204c:	c9                   	leave  
  80204d:	c3                   	ret    

0080204e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80204e:	55                   	push   %ebp
  80204f:	89 e5                	mov    %esp,%ebp
  802051:	56                   	push   %esi
  802052:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802053:	8b 75 18             	mov    0x18(%ebp),%esi
  802056:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802059:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80205c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80205f:	8b 45 08             	mov    0x8(%ebp),%eax
  802062:	56                   	push   %esi
  802063:	53                   	push   %ebx
  802064:	51                   	push   %ecx
  802065:	52                   	push   %edx
  802066:	50                   	push   %eax
  802067:	6a 08                	push   $0x8
  802069:	e8 d6 fe ff ff       	call   801f44 <syscall>
  80206e:	83 c4 18             	add    $0x18,%esp
}
  802071:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802074:	5b                   	pop    %ebx
  802075:	5e                   	pop    %esi
  802076:	5d                   	pop    %ebp
  802077:	c3                   	ret    

00802078 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80207b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207e:	8b 45 08             	mov    0x8(%ebp),%eax
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	52                   	push   %edx
  802088:	50                   	push   %eax
  802089:	6a 09                	push   $0x9
  80208b:	e8 b4 fe ff ff       	call   801f44 <syscall>
  802090:	83 c4 18             	add    $0x18,%esp
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	ff 75 0c             	pushl  0xc(%ebp)
  8020a1:	ff 75 08             	pushl  0x8(%ebp)
  8020a4:	6a 0a                	push   $0xa
  8020a6:	e8 99 fe ff ff       	call   801f44 <syscall>
  8020ab:	83 c4 18             	add    $0x18,%esp
}
  8020ae:	c9                   	leave  
  8020af:	c3                   	ret    

008020b0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8020b0:	55                   	push   %ebp
  8020b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 0b                	push   $0xb
  8020bf:	e8 80 fe ff ff       	call   801f44 <syscall>
  8020c4:	83 c4 18             	add    $0x18,%esp
}
  8020c7:	c9                   	leave  
  8020c8:	c3                   	ret    

008020c9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020c9:	55                   	push   %ebp
  8020ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 0c                	push   $0xc
  8020d8:	e8 67 fe ff ff       	call   801f44 <syscall>
  8020dd:	83 c4 18             	add    $0x18,%esp
}
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 0d                	push   $0xd
  8020f1:	e8 4e fe ff ff       	call   801f44 <syscall>
  8020f6:	83 c4 18             	add    $0x18,%esp
}
  8020f9:	c9                   	leave  
  8020fa:	c3                   	ret    

008020fb <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8020fb:	55                   	push   %ebp
  8020fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	ff 75 0c             	pushl  0xc(%ebp)
  802107:	ff 75 08             	pushl  0x8(%ebp)
  80210a:	6a 11                	push   $0x11
  80210c:	e8 33 fe ff ff       	call   801f44 <syscall>
  802111:	83 c4 18             	add    $0x18,%esp
	return;
  802114:	90                   	nop
}
  802115:	c9                   	leave  
  802116:	c3                   	ret    

00802117 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802117:	55                   	push   %ebp
  802118:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80211a:	6a 00                	push   $0x0
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	ff 75 0c             	pushl  0xc(%ebp)
  802123:	ff 75 08             	pushl  0x8(%ebp)
  802126:	6a 12                	push   $0x12
  802128:	e8 17 fe ff ff       	call   801f44 <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
	return ;
  802130:	90                   	nop
}
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802136:	6a 00                	push   $0x0
  802138:	6a 00                	push   $0x0
  80213a:	6a 00                	push   $0x0
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 0e                	push   $0xe
  802142:	e8 fd fd ff ff       	call   801f44 <syscall>
  802147:	83 c4 18             	add    $0x18,%esp
}
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	ff 75 08             	pushl  0x8(%ebp)
  80215a:	6a 0f                	push   $0xf
  80215c:	e8 e3 fd ff ff       	call   801f44 <syscall>
  802161:	83 c4 18             	add    $0x18,%esp
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	6a 10                	push   $0x10
  802175:	e8 ca fd ff ff       	call   801f44 <syscall>
  80217a:	83 c4 18             	add    $0x18,%esp
}
  80217d:	90                   	nop
  80217e:	c9                   	leave  
  80217f:	c3                   	ret    

00802180 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802180:	55                   	push   %ebp
  802181:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 14                	push   $0x14
  80218f:	e8 b0 fd ff ff       	call   801f44 <syscall>
  802194:	83 c4 18             	add    $0x18,%esp
}
  802197:	90                   	nop
  802198:	c9                   	leave  
  802199:	c3                   	ret    

0080219a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80219a:	55                   	push   %ebp
  80219b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 15                	push   $0x15
  8021a9:	e8 96 fd ff ff       	call   801f44 <syscall>
  8021ae:	83 c4 18             	add    $0x18,%esp
}
  8021b1:	90                   	nop
  8021b2:	c9                   	leave  
  8021b3:	c3                   	ret    

008021b4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8021b4:	55                   	push   %ebp
  8021b5:	89 e5                	mov    %esp,%ebp
  8021b7:	83 ec 04             	sub    $0x4,%esp
  8021ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8021bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8021c0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021c4:	6a 00                	push   $0x0
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	50                   	push   %eax
  8021cd:	6a 16                	push   $0x16
  8021cf:	e8 70 fd ff ff       	call   801f44 <syscall>
  8021d4:	83 c4 18             	add    $0x18,%esp
}
  8021d7:	90                   	nop
  8021d8:	c9                   	leave  
  8021d9:	c3                   	ret    

008021da <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8021da:	55                   	push   %ebp
  8021db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 17                	push   $0x17
  8021e9:	e8 56 fd ff ff       	call   801f44 <syscall>
  8021ee:	83 c4 18             	add    $0x18,%esp
}
  8021f1:	90                   	nop
  8021f2:	c9                   	leave  
  8021f3:	c3                   	ret    

008021f4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8021f4:	55                   	push   %ebp
  8021f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8021f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	ff 75 0c             	pushl  0xc(%ebp)
  802203:	50                   	push   %eax
  802204:	6a 18                	push   $0x18
  802206:	e8 39 fd ff ff       	call   801f44 <syscall>
  80220b:	83 c4 18             	add    $0x18,%esp
}
  80220e:	c9                   	leave  
  80220f:	c3                   	ret    

00802210 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802210:	55                   	push   %ebp
  802211:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802213:	8b 55 0c             	mov    0xc(%ebp),%edx
  802216:	8b 45 08             	mov    0x8(%ebp),%eax
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	52                   	push   %edx
  802220:	50                   	push   %eax
  802221:	6a 1b                	push   $0x1b
  802223:	e8 1c fd ff ff       	call   801f44 <syscall>
  802228:	83 c4 18             	add    $0x18,%esp
}
  80222b:	c9                   	leave  
  80222c:	c3                   	ret    

0080222d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80222d:	55                   	push   %ebp
  80222e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802230:	8b 55 0c             	mov    0xc(%ebp),%edx
  802233:	8b 45 08             	mov    0x8(%ebp),%eax
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	52                   	push   %edx
  80223d:	50                   	push   %eax
  80223e:	6a 19                	push   $0x19
  802240:	e8 ff fc ff ff       	call   801f44 <syscall>
  802245:	83 c4 18             	add    $0x18,%esp
}
  802248:	90                   	nop
  802249:	c9                   	leave  
  80224a:	c3                   	ret    

0080224b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80224b:	55                   	push   %ebp
  80224c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80224e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802251:	8b 45 08             	mov    0x8(%ebp),%eax
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	52                   	push   %edx
  80225b:	50                   	push   %eax
  80225c:	6a 1a                	push   $0x1a
  80225e:	e8 e1 fc ff ff       	call   801f44 <syscall>
  802263:	83 c4 18             	add    $0x18,%esp
}
  802266:	90                   	nop
  802267:	c9                   	leave  
  802268:	c3                   	ret    

00802269 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802269:	55                   	push   %ebp
  80226a:	89 e5                	mov    %esp,%ebp
  80226c:	83 ec 04             	sub    $0x4,%esp
  80226f:	8b 45 10             	mov    0x10(%ebp),%eax
  802272:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802275:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802278:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80227c:	8b 45 08             	mov    0x8(%ebp),%eax
  80227f:	6a 00                	push   $0x0
  802281:	51                   	push   %ecx
  802282:	52                   	push   %edx
  802283:	ff 75 0c             	pushl  0xc(%ebp)
  802286:	50                   	push   %eax
  802287:	6a 1c                	push   $0x1c
  802289:	e8 b6 fc ff ff       	call   801f44 <syscall>
  80228e:	83 c4 18             	add    $0x18,%esp
}
  802291:	c9                   	leave  
  802292:	c3                   	ret    

00802293 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802293:	55                   	push   %ebp
  802294:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802296:	8b 55 0c             	mov    0xc(%ebp),%edx
  802299:	8b 45 08             	mov    0x8(%ebp),%eax
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 00                	push   $0x0
  8022a2:	52                   	push   %edx
  8022a3:	50                   	push   %eax
  8022a4:	6a 1d                	push   $0x1d
  8022a6:	e8 99 fc ff ff       	call   801f44 <syscall>
  8022ab:	83 c4 18             	add    $0x18,%esp
}
  8022ae:	c9                   	leave  
  8022af:	c3                   	ret    

008022b0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8022b0:	55                   	push   %ebp
  8022b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8022b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	51                   	push   %ecx
  8022c1:	52                   	push   %edx
  8022c2:	50                   	push   %eax
  8022c3:	6a 1e                	push   $0x1e
  8022c5:	e8 7a fc ff ff       	call   801f44 <syscall>
  8022ca:	83 c4 18             	add    $0x18,%esp
}
  8022cd:	c9                   	leave  
  8022ce:	c3                   	ret    

008022cf <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8022cf:	55                   	push   %ebp
  8022d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8022d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d8:	6a 00                	push   $0x0
  8022da:	6a 00                	push   $0x0
  8022dc:	6a 00                	push   $0x0
  8022de:	52                   	push   %edx
  8022df:	50                   	push   %eax
  8022e0:	6a 1f                	push   $0x1f
  8022e2:	e8 5d fc ff ff       	call   801f44 <syscall>
  8022e7:	83 c4 18             	add    $0x18,%esp
}
  8022ea:	c9                   	leave  
  8022eb:	c3                   	ret    

008022ec <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8022ec:	55                   	push   %ebp
  8022ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 00                	push   $0x0
  8022f5:	6a 00                	push   $0x0
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 20                	push   $0x20
  8022fb:	e8 44 fc ff ff       	call   801f44 <syscall>
  802300:	83 c4 18             	add    $0x18,%esp
}
  802303:	c9                   	leave  
  802304:	c3                   	ret    

00802305 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802305:	55                   	push   %ebp
  802306:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802308:	8b 45 08             	mov    0x8(%ebp),%eax
  80230b:	6a 00                	push   $0x0
  80230d:	ff 75 14             	pushl  0x14(%ebp)
  802310:	ff 75 10             	pushl  0x10(%ebp)
  802313:	ff 75 0c             	pushl  0xc(%ebp)
  802316:	50                   	push   %eax
  802317:	6a 21                	push   $0x21
  802319:	e8 26 fc ff ff       	call   801f44 <syscall>
  80231e:	83 c4 18             	add    $0x18,%esp
}
  802321:	c9                   	leave  
  802322:	c3                   	ret    

00802323 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802323:	55                   	push   %ebp
  802324:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802326:	8b 45 08             	mov    0x8(%ebp),%eax
  802329:	6a 00                	push   $0x0
  80232b:	6a 00                	push   $0x0
  80232d:	6a 00                	push   $0x0
  80232f:	6a 00                	push   $0x0
  802331:	50                   	push   %eax
  802332:	6a 22                	push   $0x22
  802334:	e8 0b fc ff ff       	call   801f44 <syscall>
  802339:	83 c4 18             	add    $0x18,%esp
}
  80233c:	90                   	nop
  80233d:	c9                   	leave  
  80233e:	c3                   	ret    

0080233f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80233f:	55                   	push   %ebp
  802340:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802342:	8b 45 08             	mov    0x8(%ebp),%eax
  802345:	6a 00                	push   $0x0
  802347:	6a 00                	push   $0x0
  802349:	6a 00                	push   $0x0
  80234b:	6a 00                	push   $0x0
  80234d:	50                   	push   %eax
  80234e:	6a 23                	push   $0x23
  802350:	e8 ef fb ff ff       	call   801f44 <syscall>
  802355:	83 c4 18             	add    $0x18,%esp
}
  802358:	90                   	nop
  802359:	c9                   	leave  
  80235a:	c3                   	ret    

0080235b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80235b:	55                   	push   %ebp
  80235c:	89 e5                	mov    %esp,%ebp
  80235e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802361:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802364:	8d 50 04             	lea    0x4(%eax),%edx
  802367:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80236a:	6a 00                	push   $0x0
  80236c:	6a 00                	push   $0x0
  80236e:	6a 00                	push   $0x0
  802370:	52                   	push   %edx
  802371:	50                   	push   %eax
  802372:	6a 24                	push   $0x24
  802374:	e8 cb fb ff ff       	call   801f44 <syscall>
  802379:	83 c4 18             	add    $0x18,%esp
	return result;
  80237c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80237f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802382:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802385:	89 01                	mov    %eax,(%ecx)
  802387:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80238a:	8b 45 08             	mov    0x8(%ebp),%eax
  80238d:	c9                   	leave  
  80238e:	c2 04 00             	ret    $0x4

00802391 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802391:	55                   	push   %ebp
  802392:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	ff 75 10             	pushl  0x10(%ebp)
  80239b:	ff 75 0c             	pushl  0xc(%ebp)
  80239e:	ff 75 08             	pushl  0x8(%ebp)
  8023a1:	6a 13                	push   $0x13
  8023a3:	e8 9c fb ff ff       	call   801f44 <syscall>
  8023a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8023ab:	90                   	nop
}
  8023ac:	c9                   	leave  
  8023ad:	c3                   	ret    

008023ae <sys_rcr2>:
uint32 sys_rcr2()
{
  8023ae:	55                   	push   %ebp
  8023af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8023b1:	6a 00                	push   $0x0
  8023b3:	6a 00                	push   $0x0
  8023b5:	6a 00                	push   $0x0
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 25                	push   $0x25
  8023bd:	e8 82 fb ff ff       	call   801f44 <syscall>
  8023c2:	83 c4 18             	add    $0x18,%esp
}
  8023c5:	c9                   	leave  
  8023c6:	c3                   	ret    

008023c7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8023c7:	55                   	push   %ebp
  8023c8:	89 e5                	mov    %esp,%ebp
  8023ca:	83 ec 04             	sub    $0x4,%esp
  8023cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8023d3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8023d7:	6a 00                	push   $0x0
  8023d9:	6a 00                	push   $0x0
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 00                	push   $0x0
  8023df:	50                   	push   %eax
  8023e0:	6a 26                	push   $0x26
  8023e2:	e8 5d fb ff ff       	call   801f44 <syscall>
  8023e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8023ea:	90                   	nop
}
  8023eb:	c9                   	leave  
  8023ec:	c3                   	ret    

008023ed <rsttst>:
void rsttst()
{
  8023ed:	55                   	push   %ebp
  8023ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8023f0:	6a 00                	push   $0x0
  8023f2:	6a 00                	push   $0x0
  8023f4:	6a 00                	push   $0x0
  8023f6:	6a 00                	push   $0x0
  8023f8:	6a 00                	push   $0x0
  8023fa:	6a 28                	push   $0x28
  8023fc:	e8 43 fb ff ff       	call   801f44 <syscall>
  802401:	83 c4 18             	add    $0x18,%esp
	return ;
  802404:	90                   	nop
}
  802405:	c9                   	leave  
  802406:	c3                   	ret    

00802407 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802407:	55                   	push   %ebp
  802408:	89 e5                	mov    %esp,%ebp
  80240a:	83 ec 04             	sub    $0x4,%esp
  80240d:	8b 45 14             	mov    0x14(%ebp),%eax
  802410:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802413:	8b 55 18             	mov    0x18(%ebp),%edx
  802416:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80241a:	52                   	push   %edx
  80241b:	50                   	push   %eax
  80241c:	ff 75 10             	pushl  0x10(%ebp)
  80241f:	ff 75 0c             	pushl  0xc(%ebp)
  802422:	ff 75 08             	pushl  0x8(%ebp)
  802425:	6a 27                	push   $0x27
  802427:	e8 18 fb ff ff       	call   801f44 <syscall>
  80242c:	83 c4 18             	add    $0x18,%esp
	return ;
  80242f:	90                   	nop
}
  802430:	c9                   	leave  
  802431:	c3                   	ret    

00802432 <chktst>:
void chktst(uint32 n)
{
  802432:	55                   	push   %ebp
  802433:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802435:	6a 00                	push   $0x0
  802437:	6a 00                	push   $0x0
  802439:	6a 00                	push   $0x0
  80243b:	6a 00                	push   $0x0
  80243d:	ff 75 08             	pushl  0x8(%ebp)
  802440:	6a 29                	push   $0x29
  802442:	e8 fd fa ff ff       	call   801f44 <syscall>
  802447:	83 c4 18             	add    $0x18,%esp
	return ;
  80244a:	90                   	nop
}
  80244b:	c9                   	leave  
  80244c:	c3                   	ret    

0080244d <inctst>:

void inctst()
{
  80244d:	55                   	push   %ebp
  80244e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	6a 00                	push   $0x0
  802458:	6a 00                	push   $0x0
  80245a:	6a 2a                	push   $0x2a
  80245c:	e8 e3 fa ff ff       	call   801f44 <syscall>
  802461:	83 c4 18             	add    $0x18,%esp
	return ;
  802464:	90                   	nop
}
  802465:	c9                   	leave  
  802466:	c3                   	ret    

00802467 <gettst>:
uint32 gettst()
{
  802467:	55                   	push   %ebp
  802468:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80246a:	6a 00                	push   $0x0
  80246c:	6a 00                	push   $0x0
  80246e:	6a 00                	push   $0x0
  802470:	6a 00                	push   $0x0
  802472:	6a 00                	push   $0x0
  802474:	6a 2b                	push   $0x2b
  802476:	e8 c9 fa ff ff       	call   801f44 <syscall>
  80247b:	83 c4 18             	add    $0x18,%esp
}
  80247e:	c9                   	leave  
  80247f:	c3                   	ret    

00802480 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802480:	55                   	push   %ebp
  802481:	89 e5                	mov    %esp,%ebp
  802483:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802486:	6a 00                	push   $0x0
  802488:	6a 00                	push   $0x0
  80248a:	6a 00                	push   $0x0
  80248c:	6a 00                	push   $0x0
  80248e:	6a 00                	push   $0x0
  802490:	6a 2c                	push   $0x2c
  802492:	e8 ad fa ff ff       	call   801f44 <syscall>
  802497:	83 c4 18             	add    $0x18,%esp
  80249a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80249d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8024a1:	75 07                	jne    8024aa <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8024a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8024a8:	eb 05                	jmp    8024af <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8024aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024af:	c9                   	leave  
  8024b0:	c3                   	ret    

008024b1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8024b1:	55                   	push   %ebp
  8024b2:	89 e5                	mov    %esp,%ebp
  8024b4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024b7:	6a 00                	push   $0x0
  8024b9:	6a 00                	push   $0x0
  8024bb:	6a 00                	push   $0x0
  8024bd:	6a 00                	push   $0x0
  8024bf:	6a 00                	push   $0x0
  8024c1:	6a 2c                	push   $0x2c
  8024c3:	e8 7c fa ff ff       	call   801f44 <syscall>
  8024c8:	83 c4 18             	add    $0x18,%esp
  8024cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8024ce:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8024d2:	75 07                	jne    8024db <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8024d4:	b8 01 00 00 00       	mov    $0x1,%eax
  8024d9:	eb 05                	jmp    8024e0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8024db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024e0:	c9                   	leave  
  8024e1:	c3                   	ret    

008024e2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8024e2:	55                   	push   %ebp
  8024e3:	89 e5                	mov    %esp,%ebp
  8024e5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024e8:	6a 00                	push   $0x0
  8024ea:	6a 00                	push   $0x0
  8024ec:	6a 00                	push   $0x0
  8024ee:	6a 00                	push   $0x0
  8024f0:	6a 00                	push   $0x0
  8024f2:	6a 2c                	push   $0x2c
  8024f4:	e8 4b fa ff ff       	call   801f44 <syscall>
  8024f9:	83 c4 18             	add    $0x18,%esp
  8024fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8024ff:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802503:	75 07                	jne    80250c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802505:	b8 01 00 00 00       	mov    $0x1,%eax
  80250a:	eb 05                	jmp    802511 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80250c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802511:	c9                   	leave  
  802512:	c3                   	ret    

00802513 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802513:	55                   	push   %ebp
  802514:	89 e5                	mov    %esp,%ebp
  802516:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802519:	6a 00                	push   $0x0
  80251b:	6a 00                	push   $0x0
  80251d:	6a 00                	push   $0x0
  80251f:	6a 00                	push   $0x0
  802521:	6a 00                	push   $0x0
  802523:	6a 2c                	push   $0x2c
  802525:	e8 1a fa ff ff       	call   801f44 <syscall>
  80252a:	83 c4 18             	add    $0x18,%esp
  80252d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802530:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802534:	75 07                	jne    80253d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802536:	b8 01 00 00 00       	mov    $0x1,%eax
  80253b:	eb 05                	jmp    802542 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80253d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802542:	c9                   	leave  
  802543:	c3                   	ret    

00802544 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802544:	55                   	push   %ebp
  802545:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802547:	6a 00                	push   $0x0
  802549:	6a 00                	push   $0x0
  80254b:	6a 00                	push   $0x0
  80254d:	6a 00                	push   $0x0
  80254f:	ff 75 08             	pushl  0x8(%ebp)
  802552:	6a 2d                	push   $0x2d
  802554:	e8 eb f9 ff ff       	call   801f44 <syscall>
  802559:	83 c4 18             	add    $0x18,%esp
	return ;
  80255c:	90                   	nop
}
  80255d:	c9                   	leave  
  80255e:	c3                   	ret    

0080255f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80255f:	55                   	push   %ebp
  802560:	89 e5                	mov    %esp,%ebp
  802562:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802563:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802566:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802569:	8b 55 0c             	mov    0xc(%ebp),%edx
  80256c:	8b 45 08             	mov    0x8(%ebp),%eax
  80256f:	6a 00                	push   $0x0
  802571:	53                   	push   %ebx
  802572:	51                   	push   %ecx
  802573:	52                   	push   %edx
  802574:	50                   	push   %eax
  802575:	6a 2e                	push   $0x2e
  802577:	e8 c8 f9 ff ff       	call   801f44 <syscall>
  80257c:	83 c4 18             	add    $0x18,%esp
}
  80257f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802582:	c9                   	leave  
  802583:	c3                   	ret    

00802584 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802584:	55                   	push   %ebp
  802585:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802587:	8b 55 0c             	mov    0xc(%ebp),%edx
  80258a:	8b 45 08             	mov    0x8(%ebp),%eax
  80258d:	6a 00                	push   $0x0
  80258f:	6a 00                	push   $0x0
  802591:	6a 00                	push   $0x0
  802593:	52                   	push   %edx
  802594:	50                   	push   %eax
  802595:	6a 2f                	push   $0x2f
  802597:	e8 a8 f9 ff ff       	call   801f44 <syscall>
  80259c:	83 c4 18             	add    $0x18,%esp
}
  80259f:	c9                   	leave  
  8025a0:	c3                   	ret    
  8025a1:	66 90                	xchg   %ax,%ax
  8025a3:	90                   	nop

008025a4 <__udivdi3>:
  8025a4:	55                   	push   %ebp
  8025a5:	57                   	push   %edi
  8025a6:	56                   	push   %esi
  8025a7:	53                   	push   %ebx
  8025a8:	83 ec 1c             	sub    $0x1c,%esp
  8025ab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025af:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025bb:	89 ca                	mov    %ecx,%edx
  8025bd:	89 f8                	mov    %edi,%eax
  8025bf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025c3:	85 f6                	test   %esi,%esi
  8025c5:	75 2d                	jne    8025f4 <__udivdi3+0x50>
  8025c7:	39 cf                	cmp    %ecx,%edi
  8025c9:	77 65                	ja     802630 <__udivdi3+0x8c>
  8025cb:	89 fd                	mov    %edi,%ebp
  8025cd:	85 ff                	test   %edi,%edi
  8025cf:	75 0b                	jne    8025dc <__udivdi3+0x38>
  8025d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8025d6:	31 d2                	xor    %edx,%edx
  8025d8:	f7 f7                	div    %edi
  8025da:	89 c5                	mov    %eax,%ebp
  8025dc:	31 d2                	xor    %edx,%edx
  8025de:	89 c8                	mov    %ecx,%eax
  8025e0:	f7 f5                	div    %ebp
  8025e2:	89 c1                	mov    %eax,%ecx
  8025e4:	89 d8                	mov    %ebx,%eax
  8025e6:	f7 f5                	div    %ebp
  8025e8:	89 cf                	mov    %ecx,%edi
  8025ea:	89 fa                	mov    %edi,%edx
  8025ec:	83 c4 1c             	add    $0x1c,%esp
  8025ef:	5b                   	pop    %ebx
  8025f0:	5e                   	pop    %esi
  8025f1:	5f                   	pop    %edi
  8025f2:	5d                   	pop    %ebp
  8025f3:	c3                   	ret    
  8025f4:	39 ce                	cmp    %ecx,%esi
  8025f6:	77 28                	ja     802620 <__udivdi3+0x7c>
  8025f8:	0f bd fe             	bsr    %esi,%edi
  8025fb:	83 f7 1f             	xor    $0x1f,%edi
  8025fe:	75 40                	jne    802640 <__udivdi3+0x9c>
  802600:	39 ce                	cmp    %ecx,%esi
  802602:	72 0a                	jb     80260e <__udivdi3+0x6a>
  802604:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802608:	0f 87 9e 00 00 00    	ja     8026ac <__udivdi3+0x108>
  80260e:	b8 01 00 00 00       	mov    $0x1,%eax
  802613:	89 fa                	mov    %edi,%edx
  802615:	83 c4 1c             	add    $0x1c,%esp
  802618:	5b                   	pop    %ebx
  802619:	5e                   	pop    %esi
  80261a:	5f                   	pop    %edi
  80261b:	5d                   	pop    %ebp
  80261c:	c3                   	ret    
  80261d:	8d 76 00             	lea    0x0(%esi),%esi
  802620:	31 ff                	xor    %edi,%edi
  802622:	31 c0                	xor    %eax,%eax
  802624:	89 fa                	mov    %edi,%edx
  802626:	83 c4 1c             	add    $0x1c,%esp
  802629:	5b                   	pop    %ebx
  80262a:	5e                   	pop    %esi
  80262b:	5f                   	pop    %edi
  80262c:	5d                   	pop    %ebp
  80262d:	c3                   	ret    
  80262e:	66 90                	xchg   %ax,%ax
  802630:	89 d8                	mov    %ebx,%eax
  802632:	f7 f7                	div    %edi
  802634:	31 ff                	xor    %edi,%edi
  802636:	89 fa                	mov    %edi,%edx
  802638:	83 c4 1c             	add    $0x1c,%esp
  80263b:	5b                   	pop    %ebx
  80263c:	5e                   	pop    %esi
  80263d:	5f                   	pop    %edi
  80263e:	5d                   	pop    %ebp
  80263f:	c3                   	ret    
  802640:	bd 20 00 00 00       	mov    $0x20,%ebp
  802645:	89 eb                	mov    %ebp,%ebx
  802647:	29 fb                	sub    %edi,%ebx
  802649:	89 f9                	mov    %edi,%ecx
  80264b:	d3 e6                	shl    %cl,%esi
  80264d:	89 c5                	mov    %eax,%ebp
  80264f:	88 d9                	mov    %bl,%cl
  802651:	d3 ed                	shr    %cl,%ebp
  802653:	89 e9                	mov    %ebp,%ecx
  802655:	09 f1                	or     %esi,%ecx
  802657:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80265b:	89 f9                	mov    %edi,%ecx
  80265d:	d3 e0                	shl    %cl,%eax
  80265f:	89 c5                	mov    %eax,%ebp
  802661:	89 d6                	mov    %edx,%esi
  802663:	88 d9                	mov    %bl,%cl
  802665:	d3 ee                	shr    %cl,%esi
  802667:	89 f9                	mov    %edi,%ecx
  802669:	d3 e2                	shl    %cl,%edx
  80266b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80266f:	88 d9                	mov    %bl,%cl
  802671:	d3 e8                	shr    %cl,%eax
  802673:	09 c2                	or     %eax,%edx
  802675:	89 d0                	mov    %edx,%eax
  802677:	89 f2                	mov    %esi,%edx
  802679:	f7 74 24 0c          	divl   0xc(%esp)
  80267d:	89 d6                	mov    %edx,%esi
  80267f:	89 c3                	mov    %eax,%ebx
  802681:	f7 e5                	mul    %ebp
  802683:	39 d6                	cmp    %edx,%esi
  802685:	72 19                	jb     8026a0 <__udivdi3+0xfc>
  802687:	74 0b                	je     802694 <__udivdi3+0xf0>
  802689:	89 d8                	mov    %ebx,%eax
  80268b:	31 ff                	xor    %edi,%edi
  80268d:	e9 58 ff ff ff       	jmp    8025ea <__udivdi3+0x46>
  802692:	66 90                	xchg   %ax,%ax
  802694:	8b 54 24 08          	mov    0x8(%esp),%edx
  802698:	89 f9                	mov    %edi,%ecx
  80269a:	d3 e2                	shl    %cl,%edx
  80269c:	39 c2                	cmp    %eax,%edx
  80269e:	73 e9                	jae    802689 <__udivdi3+0xe5>
  8026a0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026a3:	31 ff                	xor    %edi,%edi
  8026a5:	e9 40 ff ff ff       	jmp    8025ea <__udivdi3+0x46>
  8026aa:	66 90                	xchg   %ax,%ax
  8026ac:	31 c0                	xor    %eax,%eax
  8026ae:	e9 37 ff ff ff       	jmp    8025ea <__udivdi3+0x46>
  8026b3:	90                   	nop

008026b4 <__umoddi3>:
  8026b4:	55                   	push   %ebp
  8026b5:	57                   	push   %edi
  8026b6:	56                   	push   %esi
  8026b7:	53                   	push   %ebx
  8026b8:	83 ec 1c             	sub    $0x1c,%esp
  8026bb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026bf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026c7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026cf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026d3:	89 f3                	mov    %esi,%ebx
  8026d5:	89 fa                	mov    %edi,%edx
  8026d7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026db:	89 34 24             	mov    %esi,(%esp)
  8026de:	85 c0                	test   %eax,%eax
  8026e0:	75 1a                	jne    8026fc <__umoddi3+0x48>
  8026e2:	39 f7                	cmp    %esi,%edi
  8026e4:	0f 86 a2 00 00 00    	jbe    80278c <__umoddi3+0xd8>
  8026ea:	89 c8                	mov    %ecx,%eax
  8026ec:	89 f2                	mov    %esi,%edx
  8026ee:	f7 f7                	div    %edi
  8026f0:	89 d0                	mov    %edx,%eax
  8026f2:	31 d2                	xor    %edx,%edx
  8026f4:	83 c4 1c             	add    $0x1c,%esp
  8026f7:	5b                   	pop    %ebx
  8026f8:	5e                   	pop    %esi
  8026f9:	5f                   	pop    %edi
  8026fa:	5d                   	pop    %ebp
  8026fb:	c3                   	ret    
  8026fc:	39 f0                	cmp    %esi,%eax
  8026fe:	0f 87 ac 00 00 00    	ja     8027b0 <__umoddi3+0xfc>
  802704:	0f bd e8             	bsr    %eax,%ebp
  802707:	83 f5 1f             	xor    $0x1f,%ebp
  80270a:	0f 84 ac 00 00 00    	je     8027bc <__umoddi3+0x108>
  802710:	bf 20 00 00 00       	mov    $0x20,%edi
  802715:	29 ef                	sub    %ebp,%edi
  802717:	89 fe                	mov    %edi,%esi
  802719:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80271d:	89 e9                	mov    %ebp,%ecx
  80271f:	d3 e0                	shl    %cl,%eax
  802721:	89 d7                	mov    %edx,%edi
  802723:	89 f1                	mov    %esi,%ecx
  802725:	d3 ef                	shr    %cl,%edi
  802727:	09 c7                	or     %eax,%edi
  802729:	89 e9                	mov    %ebp,%ecx
  80272b:	d3 e2                	shl    %cl,%edx
  80272d:	89 14 24             	mov    %edx,(%esp)
  802730:	89 d8                	mov    %ebx,%eax
  802732:	d3 e0                	shl    %cl,%eax
  802734:	89 c2                	mov    %eax,%edx
  802736:	8b 44 24 08          	mov    0x8(%esp),%eax
  80273a:	d3 e0                	shl    %cl,%eax
  80273c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802740:	8b 44 24 08          	mov    0x8(%esp),%eax
  802744:	89 f1                	mov    %esi,%ecx
  802746:	d3 e8                	shr    %cl,%eax
  802748:	09 d0                	or     %edx,%eax
  80274a:	d3 eb                	shr    %cl,%ebx
  80274c:	89 da                	mov    %ebx,%edx
  80274e:	f7 f7                	div    %edi
  802750:	89 d3                	mov    %edx,%ebx
  802752:	f7 24 24             	mull   (%esp)
  802755:	89 c6                	mov    %eax,%esi
  802757:	89 d1                	mov    %edx,%ecx
  802759:	39 d3                	cmp    %edx,%ebx
  80275b:	0f 82 87 00 00 00    	jb     8027e8 <__umoddi3+0x134>
  802761:	0f 84 91 00 00 00    	je     8027f8 <__umoddi3+0x144>
  802767:	8b 54 24 04          	mov    0x4(%esp),%edx
  80276b:	29 f2                	sub    %esi,%edx
  80276d:	19 cb                	sbb    %ecx,%ebx
  80276f:	89 d8                	mov    %ebx,%eax
  802771:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802775:	d3 e0                	shl    %cl,%eax
  802777:	89 e9                	mov    %ebp,%ecx
  802779:	d3 ea                	shr    %cl,%edx
  80277b:	09 d0                	or     %edx,%eax
  80277d:	89 e9                	mov    %ebp,%ecx
  80277f:	d3 eb                	shr    %cl,%ebx
  802781:	89 da                	mov    %ebx,%edx
  802783:	83 c4 1c             	add    $0x1c,%esp
  802786:	5b                   	pop    %ebx
  802787:	5e                   	pop    %esi
  802788:	5f                   	pop    %edi
  802789:	5d                   	pop    %ebp
  80278a:	c3                   	ret    
  80278b:	90                   	nop
  80278c:	89 fd                	mov    %edi,%ebp
  80278e:	85 ff                	test   %edi,%edi
  802790:	75 0b                	jne    80279d <__umoddi3+0xe9>
  802792:	b8 01 00 00 00       	mov    $0x1,%eax
  802797:	31 d2                	xor    %edx,%edx
  802799:	f7 f7                	div    %edi
  80279b:	89 c5                	mov    %eax,%ebp
  80279d:	89 f0                	mov    %esi,%eax
  80279f:	31 d2                	xor    %edx,%edx
  8027a1:	f7 f5                	div    %ebp
  8027a3:	89 c8                	mov    %ecx,%eax
  8027a5:	f7 f5                	div    %ebp
  8027a7:	89 d0                	mov    %edx,%eax
  8027a9:	e9 44 ff ff ff       	jmp    8026f2 <__umoddi3+0x3e>
  8027ae:	66 90                	xchg   %ax,%ax
  8027b0:	89 c8                	mov    %ecx,%eax
  8027b2:	89 f2                	mov    %esi,%edx
  8027b4:	83 c4 1c             	add    $0x1c,%esp
  8027b7:	5b                   	pop    %ebx
  8027b8:	5e                   	pop    %esi
  8027b9:	5f                   	pop    %edi
  8027ba:	5d                   	pop    %ebp
  8027bb:	c3                   	ret    
  8027bc:	3b 04 24             	cmp    (%esp),%eax
  8027bf:	72 06                	jb     8027c7 <__umoddi3+0x113>
  8027c1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027c5:	77 0f                	ja     8027d6 <__umoddi3+0x122>
  8027c7:	89 f2                	mov    %esi,%edx
  8027c9:	29 f9                	sub    %edi,%ecx
  8027cb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027cf:	89 14 24             	mov    %edx,(%esp)
  8027d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027d6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8027da:	8b 14 24             	mov    (%esp),%edx
  8027dd:	83 c4 1c             	add    $0x1c,%esp
  8027e0:	5b                   	pop    %ebx
  8027e1:	5e                   	pop    %esi
  8027e2:	5f                   	pop    %edi
  8027e3:	5d                   	pop    %ebp
  8027e4:	c3                   	ret    
  8027e5:	8d 76 00             	lea    0x0(%esi),%esi
  8027e8:	2b 04 24             	sub    (%esp),%eax
  8027eb:	19 fa                	sbb    %edi,%edx
  8027ed:	89 d1                	mov    %edx,%ecx
  8027ef:	89 c6                	mov    %eax,%esi
  8027f1:	e9 71 ff ff ff       	jmp    802767 <__umoddi3+0xb3>
  8027f6:	66 90                	xchg   %ax,%ax
  8027f8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8027fc:	72 ea                	jb     8027e8 <__umoddi3+0x134>
  8027fe:	89 d9                	mov    %ebx,%ecx
  802800:	e9 62 ff ff ff       	jmp    802767 <__umoddi3+0xb3>
