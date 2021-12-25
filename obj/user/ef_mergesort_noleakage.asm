
obj/user/ef_mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 81 07 00 00       	call   8007b7 <libmain>
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
  800041:	e8 50 1f 00 00       	call   801f96 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 26 80 00       	push   $0x802620
  80004e:	e8 4b 0b 00 00       	call   800b9e <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 26 80 00       	push   $0x802622
  80005e:	e8 3b 0b 00 00       	call   800b9e <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 26 80 00       	push   $0x802638
  80006e:	e8 2b 0b 00 00       	call   800b9e <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 26 80 00       	push   $0x802622
  80007e:	e8 1b 0b 00 00       	call   800b9e <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 26 80 00       	push   $0x802620
  80008e:	e8 0b 0b 00 00       	call   800b9e <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		//readline("Enter the number of elements: ", Line);
		cprintf("Enter the number of elements: ");
  800096:	83 ec 0c             	sub    $0xc,%esp
  800099:	68 50 26 80 00       	push   $0x802650
  80009e:	e8 fb 0a 00 00       	call   800b9e <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 2000 ;
  8000a6:	c7 45 f0 d0 07 00 00 	movl   $0x7d0,-0x10(%ebp)
		cprintf("%d\n", NumOfElements) ;
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b3:	68 6f 26 80 00       	push   $0x80266f
  8000b8:	e8 e1 0a 00 00       	call   800b9e <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c3:	c1 e0 02             	shl    $0x2,%eax
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	50                   	push   %eax
  8000ca:	e8 59 18 00 00       	call   801928 <malloc>
  8000cf:	83 c4 10             	add    $0x10,%esp
  8000d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	68 74 26 80 00       	push   $0x802674
  8000dd:	e8 bc 0a 00 00       	call   800b9e <cprintf>
  8000e2:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	68 96 26 80 00       	push   $0x802696
  8000ed:	e8 ac 0a 00 00       	call   800b9e <cprintf>
  8000f2:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f5:	83 ec 0c             	sub    $0xc,%esp
  8000f8:	68 a4 26 80 00       	push   $0x8026a4
  8000fd:	e8 9c 0a 00 00       	call   800b9e <cprintf>
  800102:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 b3 26 80 00       	push   $0x8026b3
  80010d:	e8 8c 0a 00 00       	call   800b9e <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 c3 26 80 00       	push   $0x8026c3
  80011d:	e8 7c 0a 00 00       	call   800b9e <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
			//Chose = getchar() ;
			Chose = 'a';
  800125:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
			cputchar(Chose);
  800129:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	50                   	push   %eax
  800131:	e8 e1 05 00 00       	call   800717 <cputchar>
  800136:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800139:	83 ec 0c             	sub    $0xc,%esp
  80013c:	6a 0a                	push   $0xa
  80013e:	e8 d4 05 00 00       	call   800717 <cputchar>
  800143:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800146:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80014a:	74 0c                	je     800158 <_main+0x120>
  80014c:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800150:	74 06                	je     800158 <_main+0x120>
  800152:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800156:	75 bd                	jne    800115 <_main+0xdd>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800158:	e8 53 1e 00 00       	call   801fb0 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80015d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800161:	83 f8 62             	cmp    $0x62,%eax
  800164:	74 1d                	je     800183 <_main+0x14b>
  800166:	83 f8 63             	cmp    $0x63,%eax
  800169:	74 2b                	je     800196 <_main+0x15e>
  80016b:	83 f8 61             	cmp    $0x61,%eax
  80016e:	75 39                	jne    8001a9 <_main+0x171>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 f0             	pushl  -0x10(%ebp)
  800176:	ff 75 ec             	pushl  -0x14(%ebp)
  800179:	e8 f0 01 00 00       	call   80036e <InitializeAscending>
  80017e:	83 c4 10             	add    $0x10,%esp
			break ;
  800181:	eb 37                	jmp    8001ba <_main+0x182>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 f0             	pushl  -0x10(%ebp)
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	e8 0e 02 00 00       	call   80039f <InitializeDescending>
  800191:	83 c4 10             	add    $0x10,%esp
			break ;
  800194:	eb 24                	jmp    8001ba <_main+0x182>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800196:	83 ec 08             	sub    $0x8,%esp
  800199:	ff 75 f0             	pushl  -0x10(%ebp)
  80019c:	ff 75 ec             	pushl  -0x14(%ebp)
  80019f:	e8 30 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001a4:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a7:	eb 11                	jmp    8001ba <_main+0x182>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a9:	83 ec 08             	sub    $0x8,%esp
  8001ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8001af:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b2:	e8 1d 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001b7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	ff 75 f0             	pushl  -0x10(%ebp)
  8001c0:	6a 01                	push   $0x1
  8001c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c5:	e8 dc 02 00 00       	call   8004a6 <MSort>
  8001ca:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001cd:	e8 c4 1d 00 00       	call   801f96 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 cc 26 80 00       	push   $0x8026cc
  8001da:	e8 bf 09 00 00       	call   800b9e <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001e2:	e8 c9 1d 00 00       	call   801fb0 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ed:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f0:	e8 cf 00 00 00       	call   8002c4 <CheckSorted>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ff:	75 14                	jne    800215 <_main+0x1dd>
  800201:	83 ec 04             	sub    $0x4,%esp
  800204:	68 00 27 80 00       	push   $0x802700
  800209:	6a 4e                	push   $0x4e
  80020b:	68 22 27 80 00       	push   $0x802722
  800210:	e8 e7 06 00 00       	call   8008fc <_panic>
		else
		{
			sys_disable_interrupt();
  800215:	e8 7c 1d 00 00       	call   801f96 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 40 27 80 00       	push   $0x802740
  800222:	e8 77 09 00 00       	call   800b9e <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 74 27 80 00       	push   $0x802774
  800232:	e8 67 09 00 00       	call   800b9e <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 a8 27 80 00       	push   $0x8027a8
  800242:	e8 57 09 00 00       	call   800b9e <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80024a:	e8 61 1d 00 00       	call   801fb0 <sys_enable_interrupt>
		}

		free(Elements) ;
  80024f:	83 ec 0c             	sub    $0xc,%esp
  800252:	ff 75 ec             	pushl  -0x14(%ebp)
  800255:	e8 96 19 00 00       	call   801bf0 <free>
  80025a:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80025d:	e8 34 1d 00 00       	call   801f96 <sys_disable_interrupt>
			Chose = 0 ;
  800262:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800266:	eb 3e                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800268:	83 ec 0c             	sub    $0xc,%esp
  80026b:	68 da 27 80 00       	push   $0x8027da
  800270:	e8 29 09 00 00       	call   800b9e <cprintf>
  800275:	83 c4 10             	add    $0x10,%esp
				Chose = 'n' ;
  800278:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 8e 04 00 00       	call   800717 <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 81 04 00 00       	call   800717 <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 74 04 00 00       	call   800717 <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b6                	jne    800268 <_main+0x230>
				Chose = 'n' ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 f9 1c 00 00       	call   801fb0 <sys_enable_interrupt>

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
  800446:	68 20 26 80 00       	push   $0x802620
  80044b:	e8 4e 07 00 00       	call   800b9e <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 f8 27 80 00       	push   $0x8027f8
  80046d:	e8 2c 07 00 00       	call   800b9e <cprintf>
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
  800496:	68 6f 26 80 00       	push   $0x80266f
  80049b:	e8 fe 06 00 00       	call   800b9e <cprintf>
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
  80053c:	e8 e7 13 00 00       	call   801928 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 d2 13 00 00       	call   801928 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

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
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

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

	free(Left);
  8006f8:	83 ec 0c             	sub    $0xc,%esp
  8006fb:	ff 75 d8             	pushl  -0x28(%ebp)
  8006fe:	e8 ed 14 00 00       	call   801bf0 <free>
  800703:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d4             	pushl  -0x2c(%ebp)
  80070c:	e8 df 14 00 00       	call   801bf0 <free>
  800711:	83 c4 10             	add    $0x10,%esp

}
  800714:	90                   	nop
  800715:	c9                   	leave  
  800716:	c3                   	ret    

00800717 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800717:	55                   	push   %ebp
  800718:	89 e5                	mov    %esp,%ebp
  80071a:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800723:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800727:	83 ec 0c             	sub    $0xc,%esp
  80072a:	50                   	push   %eax
  80072b:	e8 9a 18 00 00       	call   801fca <sys_cputc>
  800730:	83 c4 10             	add    $0x10,%esp
}
  800733:	90                   	nop
  800734:	c9                   	leave  
  800735:	c3                   	ret    

00800736 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80073c:	e8 55 18 00 00       	call   801f96 <sys_disable_interrupt>
	char c = ch;
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800747:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074b:	83 ec 0c             	sub    $0xc,%esp
  80074e:	50                   	push   %eax
  80074f:	e8 76 18 00 00       	call   801fca <sys_cputc>
  800754:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800757:	e8 54 18 00 00       	call   801fb0 <sys_enable_interrupt>
}
  80075c:	90                   	nop
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <getchar>:

int
getchar(void)
{
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800765:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80076c:	eb 08                	jmp    800776 <getchar+0x17>
	{
		c = sys_cgetc();
  80076e:	e8 3b 16 00 00       	call   801dae <sys_cgetc>
  800773:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80077a:	74 f2                	je     80076e <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80077c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80077f:	c9                   	leave  
  800780:	c3                   	ret    

00800781 <atomic_getchar>:

int
atomic_getchar(void)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
  800784:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800787:	e8 0a 18 00 00       	call   801f96 <sys_disable_interrupt>
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800795:	e8 14 16 00 00       	call   801dae <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007a3:	e8 08 18 00 00       	call   801fb0 <sys_enable_interrupt>
	return c;
  8007a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <iscons>:

int iscons(int fdnum)
{
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007b5:	5d                   	pop    %ebp
  8007b6:	c3                   	ret    

008007b7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007b7:	55                   	push   %ebp
  8007b8:	89 e5                	mov    %esp,%ebp
  8007ba:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007bd:	e8 39 16 00 00       	call   801dfb <sys_getenvindex>
  8007c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c8:	89 d0                	mov    %edx,%eax
  8007ca:	c1 e0 03             	shl    $0x3,%eax
  8007cd:	01 d0                	add    %edx,%eax
  8007cf:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007d6:	01 c8                	add    %ecx,%eax
  8007d8:	01 c0                	add    %eax,%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	01 c0                	add    %eax,%eax
  8007de:	01 d0                	add    %edx,%eax
  8007e0:	89 c2                	mov    %eax,%edx
  8007e2:	c1 e2 05             	shl    $0x5,%edx
  8007e5:	29 c2                	sub    %eax,%edx
  8007e7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007ee:	89 c2                	mov    %eax,%edx
  8007f0:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007f6:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800800:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800806:	84 c0                	test   %al,%al
  800808:	74 0f                	je     800819 <libmain+0x62>
		binaryname = myEnv->prog_name;
  80080a:	a1 24 30 80 00       	mov    0x803024,%eax
  80080f:	05 40 3c 01 00       	add    $0x13c40,%eax
  800814:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800819:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80081d:	7e 0a                	jle    800829 <libmain+0x72>
		binaryname = argv[0];
  80081f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 08             	pushl  0x8(%ebp)
  800832:	e8 01 f8 ff ff       	call   800038 <_main>
  800837:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80083a:	e8 57 17 00 00       	call   801f96 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80083f:	83 ec 0c             	sub    $0xc,%esp
  800842:	68 18 28 80 00       	push   $0x802818
  800847:	e8 52 03 00 00       	call   800b9e <cprintf>
  80084c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80084f:	a1 24 30 80 00       	mov    0x803024,%eax
  800854:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80085a:	a1 24 30 80 00       	mov    0x803024,%eax
  80085f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800865:	83 ec 04             	sub    $0x4,%esp
  800868:	52                   	push   %edx
  800869:	50                   	push   %eax
  80086a:	68 40 28 80 00       	push   $0x802840
  80086f:	e8 2a 03 00 00       	call   800b9e <cprintf>
  800874:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800877:	a1 24 30 80 00       	mov    0x803024,%eax
  80087c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800882:	a1 24 30 80 00       	mov    0x803024,%eax
  800887:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80088d:	83 ec 04             	sub    $0x4,%esp
  800890:	52                   	push   %edx
  800891:	50                   	push   %eax
  800892:	68 68 28 80 00       	push   $0x802868
  800897:	e8 02 03 00 00       	call   800b9e <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80089f:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a4:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8008aa:	83 ec 08             	sub    $0x8,%esp
  8008ad:	50                   	push   %eax
  8008ae:	68 a9 28 80 00       	push   $0x8028a9
  8008b3:	e8 e6 02 00 00       	call   800b9e <cprintf>
  8008b8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008bb:	83 ec 0c             	sub    $0xc,%esp
  8008be:	68 18 28 80 00       	push   $0x802818
  8008c3:	e8 d6 02 00 00       	call   800b9e <cprintf>
  8008c8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008cb:	e8 e0 16 00 00       	call   801fb0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008d0:	e8 19 00 00 00       	call   8008ee <exit>
}
  8008d5:	90                   	nop
  8008d6:	c9                   	leave  
  8008d7:	c3                   	ret    

008008d8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008d8:	55                   	push   %ebp
  8008d9:	89 e5                	mov    %esp,%ebp
  8008db:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008de:	83 ec 0c             	sub    $0xc,%esp
  8008e1:	6a 00                	push   $0x0
  8008e3:	e8 df 14 00 00       	call   801dc7 <sys_env_destroy>
  8008e8:	83 c4 10             	add    $0x10,%esp
}
  8008eb:	90                   	nop
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <exit>:

void
exit(void)
{
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008f4:	e8 34 15 00 00       	call   801e2d <sys_env_exit>
}
  8008f9:	90                   	nop
  8008fa:	c9                   	leave  
  8008fb:	c3                   	ret    

008008fc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
  8008ff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800902:	8d 45 10             	lea    0x10(%ebp),%eax
  800905:	83 c0 04             	add    $0x4,%eax
  800908:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80090b:	a1 18 31 80 00       	mov    0x803118,%eax
  800910:	85 c0                	test   %eax,%eax
  800912:	74 16                	je     80092a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800914:	a1 18 31 80 00       	mov    0x803118,%eax
  800919:	83 ec 08             	sub    $0x8,%esp
  80091c:	50                   	push   %eax
  80091d:	68 c0 28 80 00       	push   $0x8028c0
  800922:	e8 77 02 00 00       	call   800b9e <cprintf>
  800927:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80092a:	a1 00 30 80 00       	mov    0x803000,%eax
  80092f:	ff 75 0c             	pushl  0xc(%ebp)
  800932:	ff 75 08             	pushl  0x8(%ebp)
  800935:	50                   	push   %eax
  800936:	68 c5 28 80 00       	push   $0x8028c5
  80093b:	e8 5e 02 00 00       	call   800b9e <cprintf>
  800940:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800943:	8b 45 10             	mov    0x10(%ebp),%eax
  800946:	83 ec 08             	sub    $0x8,%esp
  800949:	ff 75 f4             	pushl  -0xc(%ebp)
  80094c:	50                   	push   %eax
  80094d:	e8 e1 01 00 00       	call   800b33 <vcprintf>
  800952:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800955:	83 ec 08             	sub    $0x8,%esp
  800958:	6a 00                	push   $0x0
  80095a:	68 e1 28 80 00       	push   $0x8028e1
  80095f:	e8 cf 01 00 00       	call   800b33 <vcprintf>
  800964:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800967:	e8 82 ff ff ff       	call   8008ee <exit>

	// should not return here
	while (1) ;
  80096c:	eb fe                	jmp    80096c <_panic+0x70>

0080096e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80096e:	55                   	push   %ebp
  80096f:	89 e5                	mov    %esp,%ebp
  800971:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800974:	a1 24 30 80 00       	mov    0x803024,%eax
  800979:	8b 50 74             	mov    0x74(%eax),%edx
  80097c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097f:	39 c2                	cmp    %eax,%edx
  800981:	74 14                	je     800997 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800983:	83 ec 04             	sub    $0x4,%esp
  800986:	68 e4 28 80 00       	push   $0x8028e4
  80098b:	6a 26                	push   $0x26
  80098d:	68 30 29 80 00       	push   $0x802930
  800992:	e8 65 ff ff ff       	call   8008fc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800997:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80099e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8009a5:	e9 b6 00 00 00       	jmp    800a60 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8009aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	01 d0                	add    %edx,%eax
  8009b9:	8b 00                	mov    (%eax),%eax
  8009bb:	85 c0                	test   %eax,%eax
  8009bd:	75 08                	jne    8009c7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009bf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009c2:	e9 96 00 00 00       	jmp    800a5d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009d5:	eb 5d                	jmp    800a34 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009d7:	a1 24 30 80 00       	mov    0x803024,%eax
  8009dc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009e5:	c1 e2 04             	shl    $0x4,%edx
  8009e8:	01 d0                	add    %edx,%eax
  8009ea:	8a 40 04             	mov    0x4(%eax),%al
  8009ed:	84 c0                	test   %al,%al
  8009ef:	75 40                	jne    800a31 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009f1:	a1 24 30 80 00       	mov    0x803024,%eax
  8009f6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009fc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ff:	c1 e2 04             	shl    $0x4,%edx
  800a02:	01 d0                	add    %edx,%eax
  800a04:	8b 00                	mov    (%eax),%eax
  800a06:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a09:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a0c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a11:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a16:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a20:	01 c8                	add    %ecx,%eax
  800a22:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a24:	39 c2                	cmp    %eax,%edx
  800a26:	75 09                	jne    800a31 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a28:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a2f:	eb 12                	jmp    800a43 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a31:	ff 45 e8             	incl   -0x18(%ebp)
  800a34:	a1 24 30 80 00       	mov    0x803024,%eax
  800a39:	8b 50 74             	mov    0x74(%eax),%edx
  800a3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3f:	39 c2                	cmp    %eax,%edx
  800a41:	77 94                	ja     8009d7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a47:	75 14                	jne    800a5d <CheckWSWithoutLastIndex+0xef>
			panic(
  800a49:	83 ec 04             	sub    $0x4,%esp
  800a4c:	68 3c 29 80 00       	push   $0x80293c
  800a51:	6a 3a                	push   $0x3a
  800a53:	68 30 29 80 00       	push   $0x802930
  800a58:	e8 9f fe ff ff       	call   8008fc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a5d:	ff 45 f0             	incl   -0x10(%ebp)
  800a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a63:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a66:	0f 8c 3e ff ff ff    	jl     8009aa <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a6c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a73:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a7a:	eb 20                	jmp    800a9c <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a7c:	a1 24 30 80 00       	mov    0x803024,%eax
  800a81:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a87:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a8a:	c1 e2 04             	shl    $0x4,%edx
  800a8d:	01 d0                	add    %edx,%eax
  800a8f:	8a 40 04             	mov    0x4(%eax),%al
  800a92:	3c 01                	cmp    $0x1,%al
  800a94:	75 03                	jne    800a99 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a96:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a99:	ff 45 e0             	incl   -0x20(%ebp)
  800a9c:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa1:	8b 50 74             	mov    0x74(%eax),%edx
  800aa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa7:	39 c2                	cmp    %eax,%edx
  800aa9:	77 d1                	ja     800a7c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aae:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ab1:	74 14                	je     800ac7 <CheckWSWithoutLastIndex+0x159>
		panic(
  800ab3:	83 ec 04             	sub    $0x4,%esp
  800ab6:	68 90 29 80 00       	push   $0x802990
  800abb:	6a 44                	push   $0x44
  800abd:	68 30 29 80 00       	push   $0x802930
  800ac2:	e8 35 fe ff ff       	call   8008fc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ac7:	90                   	nop
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	8d 48 01             	lea    0x1(%eax),%ecx
  800ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adb:	89 0a                	mov    %ecx,(%edx)
  800add:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae0:	88 d1                	mov    %dl,%cl
  800ae2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8b 00                	mov    (%eax),%eax
  800aee:	3d ff 00 00 00       	cmp    $0xff,%eax
  800af3:	75 2c                	jne    800b21 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800af5:	a0 28 30 80 00       	mov    0x803028,%al
  800afa:	0f b6 c0             	movzbl %al,%eax
  800afd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b00:	8b 12                	mov    (%edx),%edx
  800b02:	89 d1                	mov    %edx,%ecx
  800b04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b07:	83 c2 08             	add    $0x8,%edx
  800b0a:	83 ec 04             	sub    $0x4,%esp
  800b0d:	50                   	push   %eax
  800b0e:	51                   	push   %ecx
  800b0f:	52                   	push   %edx
  800b10:	e8 70 12 00 00       	call   801d85 <sys_cputs>
  800b15:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b24:	8b 40 04             	mov    0x4(%eax),%eax
  800b27:	8d 50 01             	lea    0x1(%eax),%edx
  800b2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b30:	90                   	nop
  800b31:	c9                   	leave  
  800b32:	c3                   	ret    

00800b33 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b33:	55                   	push   %ebp
  800b34:	89 e5                	mov    %esp,%ebp
  800b36:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b3c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b43:	00 00 00 
	b.cnt = 0;
  800b46:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b4d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b50:	ff 75 0c             	pushl  0xc(%ebp)
  800b53:	ff 75 08             	pushl  0x8(%ebp)
  800b56:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b5c:	50                   	push   %eax
  800b5d:	68 ca 0a 80 00       	push   $0x800aca
  800b62:	e8 11 02 00 00       	call   800d78 <vprintfmt>
  800b67:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b6a:	a0 28 30 80 00       	mov    0x803028,%al
  800b6f:	0f b6 c0             	movzbl %al,%eax
  800b72:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b78:	83 ec 04             	sub    $0x4,%esp
  800b7b:	50                   	push   %eax
  800b7c:	52                   	push   %edx
  800b7d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b83:	83 c0 08             	add    $0x8,%eax
  800b86:	50                   	push   %eax
  800b87:	e8 f9 11 00 00       	call   801d85 <sys_cputs>
  800b8c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b8f:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b96:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b9c:	c9                   	leave  
  800b9d:	c3                   	ret    

00800b9e <cprintf>:

int cprintf(const char *fmt, ...) {
  800b9e:	55                   	push   %ebp
  800b9f:	89 e5                	mov    %esp,%ebp
  800ba1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ba4:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bab:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	ff 75 f4             	pushl  -0xc(%ebp)
  800bba:	50                   	push   %eax
  800bbb:	e8 73 ff ff ff       	call   800b33 <vcprintf>
  800bc0:	83 c4 10             	add    $0x10,%esp
  800bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bc9:	c9                   	leave  
  800bca:	c3                   	ret    

00800bcb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bcb:	55                   	push   %ebp
  800bcc:	89 e5                	mov    %esp,%ebp
  800bce:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bd1:	e8 c0 13 00 00       	call   801f96 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bd6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	83 ec 08             	sub    $0x8,%esp
  800be2:	ff 75 f4             	pushl  -0xc(%ebp)
  800be5:	50                   	push   %eax
  800be6:	e8 48 ff ff ff       	call   800b33 <vcprintf>
  800beb:	83 c4 10             	add    $0x10,%esp
  800bee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bf1:	e8 ba 13 00 00       	call   801fb0 <sys_enable_interrupt>
	return cnt;
  800bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bf9:	c9                   	leave  
  800bfa:	c3                   	ret    

00800bfb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bfb:	55                   	push   %ebp
  800bfc:	89 e5                	mov    %esp,%ebp
  800bfe:	53                   	push   %ebx
  800bff:	83 ec 14             	sub    $0x14,%esp
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c08:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c0e:	8b 45 18             	mov    0x18(%ebp),%eax
  800c11:	ba 00 00 00 00       	mov    $0x0,%edx
  800c16:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c19:	77 55                	ja     800c70 <printnum+0x75>
  800c1b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c1e:	72 05                	jb     800c25 <printnum+0x2a>
  800c20:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c23:	77 4b                	ja     800c70 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c25:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c28:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c2b:	8b 45 18             	mov    0x18(%ebp),%eax
  800c2e:	ba 00 00 00 00       	mov    $0x0,%edx
  800c33:	52                   	push   %edx
  800c34:	50                   	push   %eax
  800c35:	ff 75 f4             	pushl  -0xc(%ebp)
  800c38:	ff 75 f0             	pushl  -0x10(%ebp)
  800c3b:	e8 78 17 00 00       	call   8023b8 <__udivdi3>
  800c40:	83 c4 10             	add    $0x10,%esp
  800c43:	83 ec 04             	sub    $0x4,%esp
  800c46:	ff 75 20             	pushl  0x20(%ebp)
  800c49:	53                   	push   %ebx
  800c4a:	ff 75 18             	pushl  0x18(%ebp)
  800c4d:	52                   	push   %edx
  800c4e:	50                   	push   %eax
  800c4f:	ff 75 0c             	pushl  0xc(%ebp)
  800c52:	ff 75 08             	pushl  0x8(%ebp)
  800c55:	e8 a1 ff ff ff       	call   800bfb <printnum>
  800c5a:	83 c4 20             	add    $0x20,%esp
  800c5d:	eb 1a                	jmp    800c79 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c5f:	83 ec 08             	sub    $0x8,%esp
  800c62:	ff 75 0c             	pushl  0xc(%ebp)
  800c65:	ff 75 20             	pushl  0x20(%ebp)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	ff d0                	call   *%eax
  800c6d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c70:	ff 4d 1c             	decl   0x1c(%ebp)
  800c73:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c77:	7f e6                	jg     800c5f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c79:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c7c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c87:	53                   	push   %ebx
  800c88:	51                   	push   %ecx
  800c89:	52                   	push   %edx
  800c8a:	50                   	push   %eax
  800c8b:	e8 38 18 00 00       	call   8024c8 <__umoddi3>
  800c90:	83 c4 10             	add    $0x10,%esp
  800c93:	05 f4 2b 80 00       	add    $0x802bf4,%eax
  800c98:	8a 00                	mov    (%eax),%al
  800c9a:	0f be c0             	movsbl %al,%eax
  800c9d:	83 ec 08             	sub    $0x8,%esp
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	50                   	push   %eax
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	ff d0                	call   *%eax
  800ca9:	83 c4 10             	add    $0x10,%esp
}
  800cac:	90                   	nop
  800cad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cb0:	c9                   	leave  
  800cb1:	c3                   	ret    

00800cb2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cb2:	55                   	push   %ebp
  800cb3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cb5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cb9:	7e 1c                	jle    800cd7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8b 00                	mov    (%eax),%eax
  800cc0:	8d 50 08             	lea    0x8(%eax),%edx
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	89 10                	mov    %edx,(%eax)
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8b 00                	mov    (%eax),%eax
  800ccd:	83 e8 08             	sub    $0x8,%eax
  800cd0:	8b 50 04             	mov    0x4(%eax),%edx
  800cd3:	8b 00                	mov    (%eax),%eax
  800cd5:	eb 40                	jmp    800d17 <getuint+0x65>
	else if (lflag)
  800cd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cdb:	74 1e                	je     800cfb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8b 00                	mov    (%eax),%eax
  800ce2:	8d 50 04             	lea    0x4(%eax),%edx
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	89 10                	mov    %edx,(%eax)
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8b 00                	mov    (%eax),%eax
  800cef:	83 e8 04             	sub    $0x4,%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	ba 00 00 00 00       	mov    $0x0,%edx
  800cf9:	eb 1c                	jmp    800d17 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8b 00                	mov    (%eax),%eax
  800d00:	8d 50 04             	lea    0x4(%eax),%edx
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	89 10                	mov    %edx,(%eax)
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	83 e8 04             	sub    $0x4,%eax
  800d10:	8b 00                	mov    (%eax),%eax
  800d12:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d17:	5d                   	pop    %ebp
  800d18:	c3                   	ret    

00800d19 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d19:	55                   	push   %ebp
  800d1a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d1c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d20:	7e 1c                	jle    800d3e <getint+0x25>
		return va_arg(*ap, long long);
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8b 00                	mov    (%eax),%eax
  800d27:	8d 50 08             	lea    0x8(%eax),%edx
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	89 10                	mov    %edx,(%eax)
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8b 00                	mov    (%eax),%eax
  800d34:	83 e8 08             	sub    $0x8,%eax
  800d37:	8b 50 04             	mov    0x4(%eax),%edx
  800d3a:	8b 00                	mov    (%eax),%eax
  800d3c:	eb 38                	jmp    800d76 <getint+0x5d>
	else if (lflag)
  800d3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d42:	74 1a                	je     800d5e <getint+0x45>
		return va_arg(*ap, long);
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8b 00                	mov    (%eax),%eax
  800d49:	8d 50 04             	lea    0x4(%eax),%edx
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	89 10                	mov    %edx,(%eax)
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8b 00                	mov    (%eax),%eax
  800d56:	83 e8 04             	sub    $0x4,%eax
  800d59:	8b 00                	mov    (%eax),%eax
  800d5b:	99                   	cltd   
  800d5c:	eb 18                	jmp    800d76 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8b 00                	mov    (%eax),%eax
  800d63:	8d 50 04             	lea    0x4(%eax),%edx
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	89 10                	mov    %edx,(%eax)
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8b 00                	mov    (%eax),%eax
  800d70:	83 e8 04             	sub    $0x4,%eax
  800d73:	8b 00                	mov    (%eax),%eax
  800d75:	99                   	cltd   
}
  800d76:	5d                   	pop    %ebp
  800d77:	c3                   	ret    

00800d78 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	56                   	push   %esi
  800d7c:	53                   	push   %ebx
  800d7d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d80:	eb 17                	jmp    800d99 <vprintfmt+0x21>
			if (ch == '\0')
  800d82:	85 db                	test   %ebx,%ebx
  800d84:	0f 84 af 03 00 00    	je     801139 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d8a:	83 ec 08             	sub    $0x8,%esp
  800d8d:	ff 75 0c             	pushl  0xc(%ebp)
  800d90:	53                   	push   %ebx
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	ff d0                	call   *%eax
  800d96:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d99:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9c:	8d 50 01             	lea    0x1(%eax),%edx
  800d9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	0f b6 d8             	movzbl %al,%ebx
  800da7:	83 fb 25             	cmp    $0x25,%ebx
  800daa:	75 d6                	jne    800d82 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800dac:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800db0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800db7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dbe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dc5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcf:	8d 50 01             	lea    0x1(%eax),%edx
  800dd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	0f b6 d8             	movzbl %al,%ebx
  800dda:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ddd:	83 f8 55             	cmp    $0x55,%eax
  800de0:	0f 87 2b 03 00 00    	ja     801111 <vprintfmt+0x399>
  800de6:	8b 04 85 18 2c 80 00 	mov    0x802c18(,%eax,4),%eax
  800ded:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800def:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800df3:	eb d7                	jmp    800dcc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800df5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800df9:	eb d1                	jmp    800dcc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dfb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e02:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e05:	89 d0                	mov    %edx,%eax
  800e07:	c1 e0 02             	shl    $0x2,%eax
  800e0a:	01 d0                	add    %edx,%eax
  800e0c:	01 c0                	add    %eax,%eax
  800e0e:	01 d8                	add    %ebx,%eax
  800e10:	83 e8 30             	sub    $0x30,%eax
  800e13:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e16:	8b 45 10             	mov    0x10(%ebp),%eax
  800e19:	8a 00                	mov    (%eax),%al
  800e1b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e1e:	83 fb 2f             	cmp    $0x2f,%ebx
  800e21:	7e 3e                	jle    800e61 <vprintfmt+0xe9>
  800e23:	83 fb 39             	cmp    $0x39,%ebx
  800e26:	7f 39                	jg     800e61 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e28:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e2b:	eb d5                	jmp    800e02 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e30:	83 c0 04             	add    $0x4,%eax
  800e33:	89 45 14             	mov    %eax,0x14(%ebp)
  800e36:	8b 45 14             	mov    0x14(%ebp),%eax
  800e39:	83 e8 04             	sub    $0x4,%eax
  800e3c:	8b 00                	mov    (%eax),%eax
  800e3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e41:	eb 1f                	jmp    800e62 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e47:	79 83                	jns    800dcc <vprintfmt+0x54>
				width = 0;
  800e49:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e50:	e9 77 ff ff ff       	jmp    800dcc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e55:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e5c:	e9 6b ff ff ff       	jmp    800dcc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e61:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e66:	0f 89 60 ff ff ff    	jns    800dcc <vprintfmt+0x54>
				width = precision, precision = -1;
  800e6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e6f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e72:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e79:	e9 4e ff ff ff       	jmp    800dcc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e7e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e81:	e9 46 ff ff ff       	jmp    800dcc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e86:	8b 45 14             	mov    0x14(%ebp),%eax
  800e89:	83 c0 04             	add    $0x4,%eax
  800e8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 e8 04             	sub    $0x4,%eax
  800e95:	8b 00                	mov    (%eax),%eax
  800e97:	83 ec 08             	sub    $0x8,%esp
  800e9a:	ff 75 0c             	pushl  0xc(%ebp)
  800e9d:	50                   	push   %eax
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	ff d0                	call   *%eax
  800ea3:	83 c4 10             	add    $0x10,%esp
			break;
  800ea6:	e9 89 02 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800eab:	8b 45 14             	mov    0x14(%ebp),%eax
  800eae:	83 c0 04             	add    $0x4,%eax
  800eb1:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb7:	83 e8 04             	sub    $0x4,%eax
  800eba:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ebc:	85 db                	test   %ebx,%ebx
  800ebe:	79 02                	jns    800ec2 <vprintfmt+0x14a>
				err = -err;
  800ec0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ec2:	83 fb 64             	cmp    $0x64,%ebx
  800ec5:	7f 0b                	jg     800ed2 <vprintfmt+0x15a>
  800ec7:	8b 34 9d 60 2a 80 00 	mov    0x802a60(,%ebx,4),%esi
  800ece:	85 f6                	test   %esi,%esi
  800ed0:	75 19                	jne    800eeb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ed2:	53                   	push   %ebx
  800ed3:	68 05 2c 80 00       	push   $0x802c05
  800ed8:	ff 75 0c             	pushl  0xc(%ebp)
  800edb:	ff 75 08             	pushl  0x8(%ebp)
  800ede:	e8 5e 02 00 00       	call   801141 <printfmt>
  800ee3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ee6:	e9 49 02 00 00       	jmp    801134 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eeb:	56                   	push   %esi
  800eec:	68 0e 2c 80 00       	push   $0x802c0e
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	ff 75 08             	pushl  0x8(%ebp)
  800ef7:	e8 45 02 00 00       	call   801141 <printfmt>
  800efc:	83 c4 10             	add    $0x10,%esp
			break;
  800eff:	e9 30 02 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f04:	8b 45 14             	mov    0x14(%ebp),%eax
  800f07:	83 c0 04             	add    $0x4,%eax
  800f0a:	89 45 14             	mov    %eax,0x14(%ebp)
  800f0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f10:	83 e8 04             	sub    $0x4,%eax
  800f13:	8b 30                	mov    (%eax),%esi
  800f15:	85 f6                	test   %esi,%esi
  800f17:	75 05                	jne    800f1e <vprintfmt+0x1a6>
				p = "(null)";
  800f19:	be 11 2c 80 00       	mov    $0x802c11,%esi
			if (width > 0 && padc != '-')
  800f1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f22:	7e 6d                	jle    800f91 <vprintfmt+0x219>
  800f24:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f28:	74 67                	je     800f91 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	50                   	push   %eax
  800f31:	56                   	push   %esi
  800f32:	e8 0c 03 00 00       	call   801243 <strnlen>
  800f37:	83 c4 10             	add    $0x10,%esp
  800f3a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f3d:	eb 16                	jmp    800f55 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f3f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f43:	83 ec 08             	sub    $0x8,%esp
  800f46:	ff 75 0c             	pushl  0xc(%ebp)
  800f49:	50                   	push   %eax
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	ff d0                	call   *%eax
  800f4f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f52:	ff 4d e4             	decl   -0x1c(%ebp)
  800f55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f59:	7f e4                	jg     800f3f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f5b:	eb 34                	jmp    800f91 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f5d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f61:	74 1c                	je     800f7f <vprintfmt+0x207>
  800f63:	83 fb 1f             	cmp    $0x1f,%ebx
  800f66:	7e 05                	jle    800f6d <vprintfmt+0x1f5>
  800f68:	83 fb 7e             	cmp    $0x7e,%ebx
  800f6b:	7e 12                	jle    800f7f <vprintfmt+0x207>
					putch('?', putdat);
  800f6d:	83 ec 08             	sub    $0x8,%esp
  800f70:	ff 75 0c             	pushl  0xc(%ebp)
  800f73:	6a 3f                	push   $0x3f
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	ff d0                	call   *%eax
  800f7a:	83 c4 10             	add    $0x10,%esp
  800f7d:	eb 0f                	jmp    800f8e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	53                   	push   %ebx
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	ff d0                	call   *%eax
  800f8b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f8e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f91:	89 f0                	mov    %esi,%eax
  800f93:	8d 70 01             	lea    0x1(%eax),%esi
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	0f be d8             	movsbl %al,%ebx
  800f9b:	85 db                	test   %ebx,%ebx
  800f9d:	74 24                	je     800fc3 <vprintfmt+0x24b>
  800f9f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa3:	78 b8                	js     800f5d <vprintfmt+0x1e5>
  800fa5:	ff 4d e0             	decl   -0x20(%ebp)
  800fa8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fac:	79 af                	jns    800f5d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fae:	eb 13                	jmp    800fc3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fb0:	83 ec 08             	sub    $0x8,%esp
  800fb3:	ff 75 0c             	pushl  0xc(%ebp)
  800fb6:	6a 20                	push   $0x20
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	ff d0                	call   *%eax
  800fbd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fc0:	ff 4d e4             	decl   -0x1c(%ebp)
  800fc3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fc7:	7f e7                	jg     800fb0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fc9:	e9 66 01 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fce:	83 ec 08             	sub    $0x8,%esp
  800fd1:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd4:	8d 45 14             	lea    0x14(%ebp),%eax
  800fd7:	50                   	push   %eax
  800fd8:	e8 3c fd ff ff       	call   800d19 <getint>
  800fdd:	83 c4 10             	add    $0x10,%esp
  800fe0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fe6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fec:	85 d2                	test   %edx,%edx
  800fee:	79 23                	jns    801013 <vprintfmt+0x29b>
				putch('-', putdat);
  800ff0:	83 ec 08             	sub    $0x8,%esp
  800ff3:	ff 75 0c             	pushl  0xc(%ebp)
  800ff6:	6a 2d                	push   $0x2d
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	ff d0                	call   *%eax
  800ffd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801000:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801003:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801006:	f7 d8                	neg    %eax
  801008:	83 d2 00             	adc    $0x0,%edx
  80100b:	f7 da                	neg    %edx
  80100d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801010:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801013:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101a:	e9 bc 00 00 00       	jmp    8010db <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80101f:	83 ec 08             	sub    $0x8,%esp
  801022:	ff 75 e8             	pushl  -0x18(%ebp)
  801025:	8d 45 14             	lea    0x14(%ebp),%eax
  801028:	50                   	push   %eax
  801029:	e8 84 fc ff ff       	call   800cb2 <getuint>
  80102e:	83 c4 10             	add    $0x10,%esp
  801031:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801034:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801037:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80103e:	e9 98 00 00 00       	jmp    8010db <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	6a 58                	push   $0x58
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	ff d0                	call   *%eax
  801050:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801053:	83 ec 08             	sub    $0x8,%esp
  801056:	ff 75 0c             	pushl  0xc(%ebp)
  801059:	6a 58                	push   $0x58
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	ff d0                	call   *%eax
  801060:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801063:	83 ec 08             	sub    $0x8,%esp
  801066:	ff 75 0c             	pushl  0xc(%ebp)
  801069:	6a 58                	push   $0x58
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	ff d0                	call   *%eax
  801070:	83 c4 10             	add    $0x10,%esp
			break;
  801073:	e9 bc 00 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801078:	83 ec 08             	sub    $0x8,%esp
  80107b:	ff 75 0c             	pushl  0xc(%ebp)
  80107e:	6a 30                	push   $0x30
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	ff d0                	call   *%eax
  801085:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801088:	83 ec 08             	sub    $0x8,%esp
  80108b:	ff 75 0c             	pushl  0xc(%ebp)
  80108e:	6a 78                	push   $0x78
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	ff d0                	call   *%eax
  801095:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801098:	8b 45 14             	mov    0x14(%ebp),%eax
  80109b:	83 c0 04             	add    $0x4,%eax
  80109e:	89 45 14             	mov    %eax,0x14(%ebp)
  8010a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a4:	83 e8 04             	sub    $0x4,%eax
  8010a7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010b3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010ba:	eb 1f                	jmp    8010db <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010bc:	83 ec 08             	sub    $0x8,%esp
  8010bf:	ff 75 e8             	pushl  -0x18(%ebp)
  8010c2:	8d 45 14             	lea    0x14(%ebp),%eax
  8010c5:	50                   	push   %eax
  8010c6:	e8 e7 fb ff ff       	call   800cb2 <getuint>
  8010cb:	83 c4 10             	add    $0x10,%esp
  8010ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010d4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010db:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e2:	83 ec 04             	sub    $0x4,%esp
  8010e5:	52                   	push   %edx
  8010e6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010e9:	50                   	push   %eax
  8010ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8010ed:	ff 75 f0             	pushl  -0x10(%ebp)
  8010f0:	ff 75 0c             	pushl  0xc(%ebp)
  8010f3:	ff 75 08             	pushl  0x8(%ebp)
  8010f6:	e8 00 fb ff ff       	call   800bfb <printnum>
  8010fb:	83 c4 20             	add    $0x20,%esp
			break;
  8010fe:	eb 34                	jmp    801134 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801100:	83 ec 08             	sub    $0x8,%esp
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	53                   	push   %ebx
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	ff d0                	call   *%eax
  80110c:	83 c4 10             	add    $0x10,%esp
			break;
  80110f:	eb 23                	jmp    801134 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801111:	83 ec 08             	sub    $0x8,%esp
  801114:	ff 75 0c             	pushl  0xc(%ebp)
  801117:	6a 25                	push   $0x25
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	ff d0                	call   *%eax
  80111e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801121:	ff 4d 10             	decl   0x10(%ebp)
  801124:	eb 03                	jmp    801129 <vprintfmt+0x3b1>
  801126:	ff 4d 10             	decl   0x10(%ebp)
  801129:	8b 45 10             	mov    0x10(%ebp),%eax
  80112c:	48                   	dec    %eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 25                	cmp    $0x25,%al
  801131:	75 f3                	jne    801126 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801133:	90                   	nop
		}
	}
  801134:	e9 47 fc ff ff       	jmp    800d80 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801139:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80113a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80113d:	5b                   	pop    %ebx
  80113e:	5e                   	pop    %esi
  80113f:	5d                   	pop    %ebp
  801140:	c3                   	ret    

00801141 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801141:	55                   	push   %ebp
  801142:	89 e5                	mov    %esp,%ebp
  801144:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801147:	8d 45 10             	lea    0x10(%ebp),%eax
  80114a:	83 c0 04             	add    $0x4,%eax
  80114d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801150:	8b 45 10             	mov    0x10(%ebp),%eax
  801153:	ff 75 f4             	pushl  -0xc(%ebp)
  801156:	50                   	push   %eax
  801157:	ff 75 0c             	pushl  0xc(%ebp)
  80115a:	ff 75 08             	pushl  0x8(%ebp)
  80115d:	e8 16 fc ff ff       	call   800d78 <vprintfmt>
  801162:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801165:	90                   	nop
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	8b 40 08             	mov    0x8(%eax),%eax
  801171:	8d 50 01             	lea    0x1(%eax),%edx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	8b 10                	mov    (%eax),%edx
  80117f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801182:	8b 40 04             	mov    0x4(%eax),%eax
  801185:	39 c2                	cmp    %eax,%edx
  801187:	73 12                	jae    80119b <sprintputch+0x33>
		*b->buf++ = ch;
  801189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118c:	8b 00                	mov    (%eax),%eax
  80118e:	8d 48 01             	lea    0x1(%eax),%ecx
  801191:	8b 55 0c             	mov    0xc(%ebp),%edx
  801194:	89 0a                	mov    %ecx,(%edx)
  801196:	8b 55 08             	mov    0x8(%ebp),%edx
  801199:	88 10                	mov    %dl,(%eax)
}
  80119b:	90                   	nop
  80119c:	5d                   	pop    %ebp
  80119d:	c3                   	ret    

0080119e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80119e:	55                   	push   %ebp
  80119f:	89 e5                	mov    %esp,%ebp
  8011a1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	01 d0                	add    %edx,%eax
  8011b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c3:	74 06                	je     8011cb <vsnprintf+0x2d>
  8011c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011c9:	7f 07                	jg     8011d2 <vsnprintf+0x34>
		return -E_INVAL;
  8011cb:	b8 03 00 00 00       	mov    $0x3,%eax
  8011d0:	eb 20                	jmp    8011f2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011d2:	ff 75 14             	pushl  0x14(%ebp)
  8011d5:	ff 75 10             	pushl  0x10(%ebp)
  8011d8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011db:	50                   	push   %eax
  8011dc:	68 68 11 80 00       	push   $0x801168
  8011e1:	e8 92 fb ff ff       	call   800d78 <vprintfmt>
  8011e6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ec:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011fa:	8d 45 10             	lea    0x10(%ebp),%eax
  8011fd:	83 c0 04             	add    $0x4,%eax
  801200:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801203:	8b 45 10             	mov    0x10(%ebp),%eax
  801206:	ff 75 f4             	pushl  -0xc(%ebp)
  801209:	50                   	push   %eax
  80120a:	ff 75 0c             	pushl  0xc(%ebp)
  80120d:	ff 75 08             	pushl  0x8(%ebp)
  801210:	e8 89 ff ff ff       	call   80119e <vsnprintf>
  801215:	83 c4 10             	add    $0x10,%esp
  801218:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80121b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80121e:	c9                   	leave  
  80121f:	c3                   	ret    

00801220 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801220:	55                   	push   %ebp
  801221:	89 e5                	mov    %esp,%ebp
  801223:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801226:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80122d:	eb 06                	jmp    801235 <strlen+0x15>
		n++;
  80122f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801232:	ff 45 08             	incl   0x8(%ebp)
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	84 c0                	test   %al,%al
  80123c:	75 f1                	jne    80122f <strlen+0xf>
		n++;
	return n;
  80123e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
  801246:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801249:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801250:	eb 09                	jmp    80125b <strnlen+0x18>
		n++;
  801252:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801255:	ff 45 08             	incl   0x8(%ebp)
  801258:	ff 4d 0c             	decl   0xc(%ebp)
  80125b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80125f:	74 09                	je     80126a <strnlen+0x27>
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	8a 00                	mov    (%eax),%al
  801266:	84 c0                	test   %al,%al
  801268:	75 e8                	jne    801252 <strnlen+0xf>
		n++;
	return n;
  80126a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
  801272:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801275:	8b 45 08             	mov    0x8(%ebp),%eax
  801278:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80127b:	90                   	nop
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	8d 50 01             	lea    0x1(%eax),%edx
  801282:	89 55 08             	mov    %edx,0x8(%ebp)
  801285:	8b 55 0c             	mov    0xc(%ebp),%edx
  801288:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80128e:	8a 12                	mov    (%edx),%dl
  801290:	88 10                	mov    %dl,(%eax)
  801292:	8a 00                	mov    (%eax),%al
  801294:	84 c0                	test   %al,%al
  801296:	75 e4                	jne    80127c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801298:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
  8012a0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b0:	eb 1f                	jmp    8012d1 <strncpy+0x34>
		*dst++ = *src;
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8d 50 01             	lea    0x1(%eax),%edx
  8012b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8012bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012be:	8a 12                	mov    (%edx),%dl
  8012c0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	84 c0                	test   %al,%al
  8012c9:	74 03                	je     8012ce <strncpy+0x31>
			src++;
  8012cb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012ce:	ff 45 fc             	incl   -0x4(%ebp)
  8012d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012d7:	72 d9                	jb     8012b2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
  8012e1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ee:	74 30                	je     801320 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012f0:	eb 16                	jmp    801308 <strlcpy+0x2a>
			*dst++ = *src++;
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	8d 50 01             	lea    0x1(%eax),%edx
  8012f8:	89 55 08             	mov    %edx,0x8(%ebp)
  8012fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801301:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801304:	8a 12                	mov    (%edx),%dl
  801306:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801308:	ff 4d 10             	decl   0x10(%ebp)
  80130b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80130f:	74 09                	je     80131a <strlcpy+0x3c>
  801311:	8b 45 0c             	mov    0xc(%ebp),%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	84 c0                	test   %al,%al
  801318:	75 d8                	jne    8012f2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801320:	8b 55 08             	mov    0x8(%ebp),%edx
  801323:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801326:	29 c2                	sub    %eax,%edx
  801328:	89 d0                	mov    %edx,%eax
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80132f:	eb 06                	jmp    801337 <strcmp+0xb>
		p++, q++;
  801331:	ff 45 08             	incl   0x8(%ebp)
  801334:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801337:	8b 45 08             	mov    0x8(%ebp),%eax
  80133a:	8a 00                	mov    (%eax),%al
  80133c:	84 c0                	test   %al,%al
  80133e:	74 0e                	je     80134e <strcmp+0x22>
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	8a 10                	mov    (%eax),%dl
  801345:	8b 45 0c             	mov    0xc(%ebp),%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	38 c2                	cmp    %al,%dl
  80134c:	74 e3                	je     801331 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	0f b6 d0             	movzbl %al,%edx
  801356:	8b 45 0c             	mov    0xc(%ebp),%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	0f b6 c0             	movzbl %al,%eax
  80135e:	29 c2                	sub    %eax,%edx
  801360:	89 d0                	mov    %edx,%eax
}
  801362:	5d                   	pop    %ebp
  801363:	c3                   	ret    

00801364 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801364:	55                   	push   %ebp
  801365:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801367:	eb 09                	jmp    801372 <strncmp+0xe>
		n--, p++, q++;
  801369:	ff 4d 10             	decl   0x10(%ebp)
  80136c:	ff 45 08             	incl   0x8(%ebp)
  80136f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801372:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801376:	74 17                	je     80138f <strncmp+0x2b>
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	84 c0                	test   %al,%al
  80137f:	74 0e                	je     80138f <strncmp+0x2b>
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8a 10                	mov    (%eax),%dl
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	38 c2                	cmp    %al,%dl
  80138d:	74 da                	je     801369 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80138f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801393:	75 07                	jne    80139c <strncmp+0x38>
		return 0;
  801395:	b8 00 00 00 00       	mov    $0x0,%eax
  80139a:	eb 14                	jmp    8013b0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	0f b6 d0             	movzbl %al,%edx
  8013a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f b6 c0             	movzbl %al,%eax
  8013ac:	29 c2                	sub    %eax,%edx
  8013ae:	89 d0                	mov    %edx,%eax
}
  8013b0:	5d                   	pop    %ebp
  8013b1:	c3                   	ret    

008013b2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
  8013b5:	83 ec 04             	sub    $0x4,%esp
  8013b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013be:	eb 12                	jmp    8013d2 <strchr+0x20>
		if (*s == c)
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013c8:	75 05                	jne    8013cf <strchr+0x1d>
			return (char *) s;
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	eb 11                	jmp    8013e0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013cf:	ff 45 08             	incl   0x8(%ebp)
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	84 c0                	test   %al,%al
  8013d9:	75 e5                	jne    8013c0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
  8013e5:	83 ec 04             	sub    $0x4,%esp
  8013e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ee:	eb 0d                	jmp    8013fd <strfind+0x1b>
		if (*s == c)
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f8:	74 0e                	je     801408 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013fa:	ff 45 08             	incl   0x8(%ebp)
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	84 c0                	test   %al,%al
  801404:	75 ea                	jne    8013f0 <strfind+0xe>
  801406:	eb 01                	jmp    801409 <strfind+0x27>
		if (*s == c)
			break;
  801408:	90                   	nop
	return (char *) s;
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
  801411:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80141a:	8b 45 10             	mov    0x10(%ebp),%eax
  80141d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801420:	eb 0e                	jmp    801430 <memset+0x22>
		*p++ = c;
  801422:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801425:	8d 50 01             	lea    0x1(%eax),%edx
  801428:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80142b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80142e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801430:	ff 4d f8             	decl   -0x8(%ebp)
  801433:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801437:	79 e9                	jns    801422 <memset+0x14>
		*p++ = c;

	return v;
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143c:	c9                   	leave  
  80143d:	c3                   	ret    

0080143e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
  801441:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801444:	8b 45 0c             	mov    0xc(%ebp),%eax
  801447:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801450:	eb 16                	jmp    801468 <memcpy+0x2a>
		*d++ = *s++;
  801452:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801455:	8d 50 01             	lea    0x1(%eax),%edx
  801458:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801461:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801464:	8a 12                	mov    (%edx),%dl
  801466:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801468:	8b 45 10             	mov    0x10(%ebp),%eax
  80146b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80146e:	89 55 10             	mov    %edx,0x10(%ebp)
  801471:	85 c0                	test   %eax,%eax
  801473:	75 dd                	jne    801452 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80148c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80148f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801492:	73 50                	jae    8014e4 <memmove+0x6a>
  801494:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801497:	8b 45 10             	mov    0x10(%ebp),%eax
  80149a:	01 d0                	add    %edx,%eax
  80149c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80149f:	76 43                	jbe    8014e4 <memmove+0x6a>
		s += n;
  8014a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014aa:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014ad:	eb 10                	jmp    8014bf <memmove+0x45>
			*--d = *--s;
  8014af:	ff 4d f8             	decl   -0x8(%ebp)
  8014b2:	ff 4d fc             	decl   -0x4(%ebp)
  8014b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b8:	8a 10                	mov    (%eax),%dl
  8014ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014bd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8014c8:	85 c0                	test   %eax,%eax
  8014ca:	75 e3                	jne    8014af <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014cc:	eb 23                	jmp    8014f1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d1:	8d 50 01             	lea    0x1(%eax),%edx
  8014d4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014dd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014e0:	8a 12                	mov    (%edx),%dl
  8014e2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ed:	85 c0                	test   %eax,%eax
  8014ef:	75 dd                	jne    8014ce <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
  8014f9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801502:	8b 45 0c             	mov    0xc(%ebp),%eax
  801505:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801508:	eb 2a                	jmp    801534 <memcmp+0x3e>
		if (*s1 != *s2)
  80150a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150d:	8a 10                	mov    (%eax),%dl
  80150f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801512:	8a 00                	mov    (%eax),%al
  801514:	38 c2                	cmp    %al,%dl
  801516:	74 16                	je     80152e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801518:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	0f b6 d0             	movzbl %al,%edx
  801520:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801523:	8a 00                	mov    (%eax),%al
  801525:	0f b6 c0             	movzbl %al,%eax
  801528:	29 c2                	sub    %eax,%edx
  80152a:	89 d0                	mov    %edx,%eax
  80152c:	eb 18                	jmp    801546 <memcmp+0x50>
		s1++, s2++;
  80152e:	ff 45 fc             	incl   -0x4(%ebp)
  801531:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801534:	8b 45 10             	mov    0x10(%ebp),%eax
  801537:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153a:	89 55 10             	mov    %edx,0x10(%ebp)
  80153d:	85 c0                	test   %eax,%eax
  80153f:	75 c9                	jne    80150a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801541:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
  80154b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80154e:	8b 55 08             	mov    0x8(%ebp),%edx
  801551:	8b 45 10             	mov    0x10(%ebp),%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801559:	eb 15                	jmp    801570 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	0f b6 d0             	movzbl %al,%edx
  801563:	8b 45 0c             	mov    0xc(%ebp),%eax
  801566:	0f b6 c0             	movzbl %al,%eax
  801569:	39 c2                	cmp    %eax,%edx
  80156b:	74 0d                	je     80157a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80156d:	ff 45 08             	incl   0x8(%ebp)
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801576:	72 e3                	jb     80155b <memfind+0x13>
  801578:	eb 01                	jmp    80157b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80157a:	90                   	nop
	return (void *) s;
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
  801583:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801586:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80158d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801594:	eb 03                	jmp    801599 <strtol+0x19>
		s++;
  801596:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 00                	mov    (%eax),%al
  80159e:	3c 20                	cmp    $0x20,%al
  8015a0:	74 f4                	je     801596 <strtol+0x16>
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	3c 09                	cmp    $0x9,%al
  8015a9:	74 eb                	je     801596 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	3c 2b                	cmp    $0x2b,%al
  8015b2:	75 05                	jne    8015b9 <strtol+0x39>
		s++;
  8015b4:	ff 45 08             	incl   0x8(%ebp)
  8015b7:	eb 13                	jmp    8015cc <strtol+0x4c>
	else if (*s == '-')
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	3c 2d                	cmp    $0x2d,%al
  8015c0:	75 0a                	jne    8015cc <strtol+0x4c>
		s++, neg = 1;
  8015c2:	ff 45 08             	incl   0x8(%ebp)
  8015c5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d0:	74 06                	je     8015d8 <strtol+0x58>
  8015d2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015d6:	75 20                	jne    8015f8 <strtol+0x78>
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	3c 30                	cmp    $0x30,%al
  8015df:	75 17                	jne    8015f8 <strtol+0x78>
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	40                   	inc    %eax
  8015e5:	8a 00                	mov    (%eax),%al
  8015e7:	3c 78                	cmp    $0x78,%al
  8015e9:	75 0d                	jne    8015f8 <strtol+0x78>
		s += 2, base = 16;
  8015eb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015ef:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015f6:	eb 28                	jmp    801620 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fc:	75 15                	jne    801613 <strtol+0x93>
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	8a 00                	mov    (%eax),%al
  801603:	3c 30                	cmp    $0x30,%al
  801605:	75 0c                	jne    801613 <strtol+0x93>
		s++, base = 8;
  801607:	ff 45 08             	incl   0x8(%ebp)
  80160a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801611:	eb 0d                	jmp    801620 <strtol+0xa0>
	else if (base == 0)
  801613:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801617:	75 07                	jne    801620 <strtol+0xa0>
		base = 10;
  801619:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	3c 2f                	cmp    $0x2f,%al
  801627:	7e 19                	jle    801642 <strtol+0xc2>
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	8a 00                	mov    (%eax),%al
  80162e:	3c 39                	cmp    $0x39,%al
  801630:	7f 10                	jg     801642 <strtol+0xc2>
			dig = *s - '0';
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	0f be c0             	movsbl %al,%eax
  80163a:	83 e8 30             	sub    $0x30,%eax
  80163d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801640:	eb 42                	jmp    801684 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	8a 00                	mov    (%eax),%al
  801647:	3c 60                	cmp    $0x60,%al
  801649:	7e 19                	jle    801664 <strtol+0xe4>
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	3c 7a                	cmp    $0x7a,%al
  801652:	7f 10                	jg     801664 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	0f be c0             	movsbl %al,%eax
  80165c:	83 e8 57             	sub    $0x57,%eax
  80165f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801662:	eb 20                	jmp    801684 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	3c 40                	cmp    $0x40,%al
  80166b:	7e 39                	jle    8016a6 <strtol+0x126>
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	3c 5a                	cmp    $0x5a,%al
  801674:	7f 30                	jg     8016a6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	0f be c0             	movsbl %al,%eax
  80167e:	83 e8 37             	sub    $0x37,%eax
  801681:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801687:	3b 45 10             	cmp    0x10(%ebp),%eax
  80168a:	7d 19                	jge    8016a5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80168c:	ff 45 08             	incl   0x8(%ebp)
  80168f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801692:	0f af 45 10          	imul   0x10(%ebp),%eax
  801696:	89 c2                	mov    %eax,%edx
  801698:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169b:	01 d0                	add    %edx,%eax
  80169d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016a0:	e9 7b ff ff ff       	jmp    801620 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016a5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016aa:	74 08                	je     8016b4 <strtol+0x134>
		*endptr = (char *) s;
  8016ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016af:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016b8:	74 07                	je     8016c1 <strtol+0x141>
  8016ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bd:	f7 d8                	neg    %eax
  8016bf:	eb 03                	jmp    8016c4 <strtol+0x144>
  8016c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <ltostr>:

void
ltostr(long value, char *str)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
  8016c9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016de:	79 13                	jns    8016f3 <ltostr+0x2d>
	{
		neg = 1;
  8016e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ea:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016ed:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016f0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016fb:	99                   	cltd   
  8016fc:	f7 f9                	idiv   %ecx
  8016fe:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801701:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801704:	8d 50 01             	lea    0x1(%eax),%edx
  801707:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80170a:	89 c2                	mov    %eax,%edx
  80170c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170f:	01 d0                	add    %edx,%eax
  801711:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801714:	83 c2 30             	add    $0x30,%edx
  801717:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801719:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80171c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801721:	f7 e9                	imul   %ecx
  801723:	c1 fa 02             	sar    $0x2,%edx
  801726:	89 c8                	mov    %ecx,%eax
  801728:	c1 f8 1f             	sar    $0x1f,%eax
  80172b:	29 c2                	sub    %eax,%edx
  80172d:	89 d0                	mov    %edx,%eax
  80172f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801732:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801735:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80173a:	f7 e9                	imul   %ecx
  80173c:	c1 fa 02             	sar    $0x2,%edx
  80173f:	89 c8                	mov    %ecx,%eax
  801741:	c1 f8 1f             	sar    $0x1f,%eax
  801744:	29 c2                	sub    %eax,%edx
  801746:	89 d0                	mov    %edx,%eax
  801748:	c1 e0 02             	shl    $0x2,%eax
  80174b:	01 d0                	add    %edx,%eax
  80174d:	01 c0                	add    %eax,%eax
  80174f:	29 c1                	sub    %eax,%ecx
  801751:	89 ca                	mov    %ecx,%edx
  801753:	85 d2                	test   %edx,%edx
  801755:	75 9c                	jne    8016f3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80175e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801761:	48                   	dec    %eax
  801762:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801765:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801769:	74 3d                	je     8017a8 <ltostr+0xe2>
		start = 1 ;
  80176b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801772:	eb 34                	jmp    8017a8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801774:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801777:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177a:	01 d0                	add    %edx,%eax
  80177c:	8a 00                	mov    (%eax),%al
  80177e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801781:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801784:	8b 45 0c             	mov    0xc(%ebp),%eax
  801787:	01 c2                	add    %eax,%edx
  801789:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80178c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178f:	01 c8                	add    %ecx,%eax
  801791:	8a 00                	mov    (%eax),%al
  801793:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801795:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801798:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179b:	01 c2                	add    %eax,%edx
  80179d:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017a0:	88 02                	mov    %al,(%edx)
		start++ ;
  8017a2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017a5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017ae:	7c c4                	jl     801774 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017bb:	90                   	nop
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
  8017c1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017c4:	ff 75 08             	pushl  0x8(%ebp)
  8017c7:	e8 54 fa ff ff       	call   801220 <strlen>
  8017cc:	83 c4 04             	add    $0x4,%esp
  8017cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017d2:	ff 75 0c             	pushl  0xc(%ebp)
  8017d5:	e8 46 fa ff ff       	call   801220 <strlen>
  8017da:	83 c4 04             	add    $0x4,%esp
  8017dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017ee:	eb 17                	jmp    801807 <strcconcat+0x49>
		final[s] = str1[s] ;
  8017f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f6:	01 c2                	add    %eax,%edx
  8017f8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	01 c8                	add    %ecx,%eax
  801800:	8a 00                	mov    (%eax),%al
  801802:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801804:	ff 45 fc             	incl   -0x4(%ebp)
  801807:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80180a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80180d:	7c e1                	jl     8017f0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80180f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801816:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80181d:	eb 1f                	jmp    80183e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80181f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801822:	8d 50 01             	lea    0x1(%eax),%edx
  801825:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801828:	89 c2                	mov    %eax,%edx
  80182a:	8b 45 10             	mov    0x10(%ebp),%eax
  80182d:	01 c2                	add    %eax,%edx
  80182f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801832:	8b 45 0c             	mov    0xc(%ebp),%eax
  801835:	01 c8                	add    %ecx,%eax
  801837:	8a 00                	mov    (%eax),%al
  801839:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80183b:	ff 45 f8             	incl   -0x8(%ebp)
  80183e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801841:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801844:	7c d9                	jl     80181f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801846:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801849:	8b 45 10             	mov    0x10(%ebp),%eax
  80184c:	01 d0                	add    %edx,%eax
  80184e:	c6 00 00             	movb   $0x0,(%eax)
}
  801851:	90                   	nop
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801857:	8b 45 14             	mov    0x14(%ebp),%eax
  80185a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801860:	8b 45 14             	mov    0x14(%ebp),%eax
  801863:	8b 00                	mov    (%eax),%eax
  801865:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80186c:	8b 45 10             	mov    0x10(%ebp),%eax
  80186f:	01 d0                	add    %edx,%eax
  801871:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801877:	eb 0c                	jmp    801885 <strsplit+0x31>
			*string++ = 0;
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	8d 50 01             	lea    0x1(%eax),%edx
  80187f:	89 55 08             	mov    %edx,0x8(%ebp)
  801882:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	8a 00                	mov    (%eax),%al
  80188a:	84 c0                	test   %al,%al
  80188c:	74 18                	je     8018a6 <strsplit+0x52>
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	8a 00                	mov    (%eax),%al
  801893:	0f be c0             	movsbl %al,%eax
  801896:	50                   	push   %eax
  801897:	ff 75 0c             	pushl  0xc(%ebp)
  80189a:	e8 13 fb ff ff       	call   8013b2 <strchr>
  80189f:	83 c4 08             	add    $0x8,%esp
  8018a2:	85 c0                	test   %eax,%eax
  8018a4:	75 d3                	jne    801879 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	8a 00                	mov    (%eax),%al
  8018ab:	84 c0                	test   %al,%al
  8018ad:	74 5a                	je     801909 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018af:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b2:	8b 00                	mov    (%eax),%eax
  8018b4:	83 f8 0f             	cmp    $0xf,%eax
  8018b7:	75 07                	jne    8018c0 <strsplit+0x6c>
		{
			return 0;
  8018b9:	b8 00 00 00 00       	mov    $0x0,%eax
  8018be:	eb 66                	jmp    801926 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c3:	8b 00                	mov    (%eax),%eax
  8018c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8018c8:	8b 55 14             	mov    0x14(%ebp),%edx
  8018cb:	89 0a                	mov    %ecx,(%edx)
  8018cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d7:	01 c2                	add    %eax,%edx
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018de:	eb 03                	jmp    8018e3 <strsplit+0x8f>
			string++;
  8018e0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	8a 00                	mov    (%eax),%al
  8018e8:	84 c0                	test   %al,%al
  8018ea:	74 8b                	je     801877 <strsplit+0x23>
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	8a 00                	mov    (%eax),%al
  8018f1:	0f be c0             	movsbl %al,%eax
  8018f4:	50                   	push   %eax
  8018f5:	ff 75 0c             	pushl  0xc(%ebp)
  8018f8:	e8 b5 fa ff ff       	call   8013b2 <strchr>
  8018fd:	83 c4 08             	add    $0x8,%esp
  801900:	85 c0                	test   %eax,%eax
  801902:	74 dc                	je     8018e0 <strsplit+0x8c>
			string++;
	}
  801904:	e9 6e ff ff ff       	jmp    801877 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801909:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80190a:	8b 45 14             	mov    0x14(%ebp),%eax
  80190d:	8b 00                	mov    (%eax),%eax
  80190f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801916:	8b 45 10             	mov    0x10(%ebp),%eax
  801919:	01 d0                	add    %edx,%eax
  80191b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801921:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
  80192b:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80192e:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801935:	76 0a                	jbe    801941 <malloc+0x19>
		return NULL;
  801937:	b8 00 00 00 00       	mov    $0x0,%eax
  80193c:	e9 ad 02 00 00       	jmp    801bee <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801941:	8b 45 08             	mov    0x8(%ebp),%eax
  801944:	c1 e8 0c             	shr    $0xc,%eax
  801947:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  80194a:	8b 45 08             	mov    0x8(%ebp),%eax
  80194d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801952:	85 c0                	test   %eax,%eax
  801954:	74 03                	je     801959 <malloc+0x31>
		num++;
  801956:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801959:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80195e:	85 c0                	test   %eax,%eax
  801960:	75 71                	jne    8019d3 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801962:	a1 04 30 80 00       	mov    0x803004,%eax
  801967:	83 ec 08             	sub    $0x8,%esp
  80196a:	ff 75 08             	pushl  0x8(%ebp)
  80196d:	50                   	push   %eax
  80196e:	e8 ba 05 00 00       	call   801f2d <sys_allocateMem>
  801973:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801976:	a1 04 30 80 00       	mov    0x803004,%eax
  80197b:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  80197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801981:	c1 e0 0c             	shl    $0xc,%eax
  801984:	89 c2                	mov    %eax,%edx
  801986:	a1 04 30 80 00       	mov    0x803004,%eax
  80198b:	01 d0                	add    %edx,%eax
  80198d:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801992:	a1 30 30 80 00       	mov    0x803030,%eax
  801997:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80199a:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8019a1:	a1 30 30 80 00       	mov    0x803030,%eax
  8019a6:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8019a9:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  8019b0:	a1 30 30 80 00       	mov    0x803030,%eax
  8019b5:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8019bc:	01 00 00 00 
		sizeofarray++;
  8019c0:	a1 30 30 80 00       	mov    0x803030,%eax
  8019c5:	40                   	inc    %eax
  8019c6:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  8019cb:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8019ce:	e9 1b 02 00 00       	jmp    801bee <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8019d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8019da:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8019e1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  8019e8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8019ef:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8019f6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8019fd:	eb 72                	jmp    801a71 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8019ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a02:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a09:	85 c0                	test   %eax,%eax
  801a0b:	75 12                	jne    801a1f <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801a0d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a10:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a17:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801a1a:	ff 45 dc             	incl   -0x24(%ebp)
  801a1d:	eb 4f                	jmp    801a6e <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801a1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a22:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801a25:	7d 39                	jge    801a60 <malloc+0x138>
  801a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a2a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a2d:	7c 31                	jl     801a60 <malloc+0x138>
					{
						min=count;
  801a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a32:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801a35:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a38:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801a3f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a42:	c1 e2 0c             	shl    $0xc,%edx
  801a45:	29 d0                	sub    %edx,%eax
  801a47:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801a4a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a4d:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801a50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801a53:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801a5a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a5d:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801a60:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801a67:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801a6e:	ff 45 d4             	incl   -0x2c(%ebp)
  801a71:	a1 30 30 80 00       	mov    0x803030,%eax
  801a76:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801a79:	7c 84                	jl     8019ff <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801a7b:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801a7f:	0f 85 e3 00 00 00    	jne    801b68 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801a85:	83 ec 08             	sub    $0x8,%esp
  801a88:	ff 75 08             	pushl  0x8(%ebp)
  801a8b:	ff 75 e0             	pushl  -0x20(%ebp)
  801a8e:	e8 9a 04 00 00       	call   801f2d <sys_allocateMem>
  801a93:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801a96:	a1 30 30 80 00       	mov    0x803030,%eax
  801a9b:	40                   	inc    %eax
  801a9c:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801aa1:	a1 30 30 80 00       	mov    0x803030,%eax
  801aa6:	48                   	dec    %eax
  801aa7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801aaa:	eb 42                	jmp    801aee <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801aac:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801aaf:	48                   	dec    %eax
  801ab0:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801ab7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801aba:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801ac1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ac4:	48                   	dec    %eax
  801ac5:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801acc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801acf:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801ad6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ad9:	48                   	dec    %eax
  801ada:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801ae1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ae4:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801aeb:	ff 4d d0             	decl   -0x30(%ebp)
  801aee:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801af1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801af4:	7f b6                	jg     801aac <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801af6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801af9:	40                   	inc    %eax
  801afa:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801afd:	8b 55 08             	mov    0x8(%ebp),%edx
  801b00:	01 ca                	add    %ecx,%edx
  801b02:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801b09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b0c:	8d 50 01             	lea    0x1(%eax),%edx
  801b0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b12:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b19:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801b1c:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801b23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b26:	40                   	inc    %eax
  801b27:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801b2e:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b38:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801b3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b42:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801b45:	eb 11                	jmp    801b58 <malloc+0x230>
				{
					changed[index] = 1;
  801b47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b4a:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801b51:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801b55:	ff 45 cc             	incl   -0x34(%ebp)
  801b58:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801b5b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b5e:	7c e7                	jl     801b47 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801b60:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b63:	e9 86 00 00 00       	jmp    801bee <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801b68:	a1 04 30 80 00       	mov    0x803004,%eax
  801b6d:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801b72:	29 c2                	sub    %eax,%edx
  801b74:	89 d0                	mov    %edx,%eax
  801b76:	3b 45 08             	cmp    0x8(%ebp),%eax
  801b79:	73 07                	jae    801b82 <malloc+0x25a>
						return NULL;
  801b7b:	b8 00 00 00 00       	mov    $0x0,%eax
  801b80:	eb 6c                	jmp    801bee <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801b82:	a1 04 30 80 00       	mov    0x803004,%eax
  801b87:	83 ec 08             	sub    $0x8,%esp
  801b8a:	ff 75 08             	pushl  0x8(%ebp)
  801b8d:	50                   	push   %eax
  801b8e:	e8 9a 03 00 00       	call   801f2d <sys_allocateMem>
  801b93:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801b96:	a1 04 30 80 00       	mov    0x803004,%eax
  801b9b:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ba1:	c1 e0 0c             	shl    $0xc,%eax
  801ba4:	89 c2                	mov    %eax,%edx
  801ba6:	a1 04 30 80 00       	mov    0x803004,%eax
  801bab:	01 d0                	add    %edx,%eax
  801bad:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801bb2:	a1 30 30 80 00       	mov    0x803030,%eax
  801bb7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bba:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801bc1:	a1 30 30 80 00       	mov    0x803030,%eax
  801bc6:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801bc9:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801bd0:	a1 30 30 80 00       	mov    0x803030,%eax
  801bd5:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801bdc:	01 00 00 00 
					sizeofarray++;
  801be0:	a1 30 30 80 00       	mov    0x803030,%eax
  801be5:	40                   	inc    %eax
  801be6:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801beb:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801bee:	c9                   	leave  
  801bef:	c3                   	ret    

00801bf0 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
  801bf3:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf9:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801bfc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c03:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801c0a:	eb 30                	jmp    801c3c <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801c0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c0f:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c16:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c19:	75 1e                	jne    801c39 <free+0x49>
  801c1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c1e:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c25:	83 f8 01             	cmp    $0x1,%eax
  801c28:	75 0f                	jne    801c39 <free+0x49>
			is_found = 1;
  801c2a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801c31:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c34:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801c37:	eb 0d                	jmp    801c46 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c39:	ff 45 ec             	incl   -0x14(%ebp)
  801c3c:	a1 30 30 80 00       	mov    0x803030,%eax
  801c41:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801c44:	7c c6                	jl     801c0c <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801c46:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801c4a:	75 3a                	jne    801c86 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801c4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c4f:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801c56:	c1 e0 0c             	shl    $0xc,%eax
  801c59:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801c5c:	83 ec 08             	sub    $0x8,%esp
  801c5f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c62:	ff 75 e8             	pushl  -0x18(%ebp)
  801c65:	e8 a7 02 00 00       	call   801f11 <sys_freeMem>
  801c6a:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801c6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c70:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801c77:	00 00 00 00 
		changes++;
  801c7b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c80:	40                   	inc    %eax
  801c81:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801c86:	90                   	nop
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	83 ec 18             	sub    $0x18,%esp
  801c8f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c92:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c95:	83 ec 04             	sub    $0x4,%esp
  801c98:	68 70 2d 80 00       	push   $0x802d70
  801c9d:	68 b6 00 00 00       	push   $0xb6
  801ca2:	68 93 2d 80 00       	push   $0x802d93
  801ca7:	e8 50 ec ff ff       	call   8008fc <_panic>

00801cac <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801cac:	55                   	push   %ebp
  801cad:	89 e5                	mov    %esp,%ebp
  801caf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cb2:	83 ec 04             	sub    $0x4,%esp
  801cb5:	68 70 2d 80 00       	push   $0x802d70
  801cba:	68 bb 00 00 00       	push   $0xbb
  801cbf:	68 93 2d 80 00       	push   $0x802d93
  801cc4:	e8 33 ec ff ff       	call   8008fc <_panic>

00801cc9 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801cc9:	55                   	push   %ebp
  801cca:	89 e5                	mov    %esp,%ebp
  801ccc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ccf:	83 ec 04             	sub    $0x4,%esp
  801cd2:	68 70 2d 80 00       	push   $0x802d70
  801cd7:	68 c0 00 00 00       	push   $0xc0
  801cdc:	68 93 2d 80 00       	push   $0x802d93
  801ce1:	e8 16 ec ff ff       	call   8008fc <_panic>

00801ce6 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801ce6:	55                   	push   %ebp
  801ce7:	89 e5                	mov    %esp,%ebp
  801ce9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cec:	83 ec 04             	sub    $0x4,%esp
  801cef:	68 70 2d 80 00       	push   $0x802d70
  801cf4:	68 c4 00 00 00       	push   $0xc4
  801cf9:	68 93 2d 80 00       	push   $0x802d93
  801cfe:	e8 f9 eb ff ff       	call   8008fc <_panic>

00801d03 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801d03:	55                   	push   %ebp
  801d04:	89 e5                	mov    %esp,%ebp
  801d06:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d09:	83 ec 04             	sub    $0x4,%esp
  801d0c:	68 70 2d 80 00       	push   $0x802d70
  801d11:	68 c9 00 00 00       	push   $0xc9
  801d16:	68 93 2d 80 00       	push   $0x802d93
  801d1b:	e8 dc eb ff ff       	call   8008fc <_panic>

00801d20 <shrink>:
}
void shrink(uint32 newSize) {
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
  801d23:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d26:	83 ec 04             	sub    $0x4,%esp
  801d29:	68 70 2d 80 00       	push   $0x802d70
  801d2e:	68 cc 00 00 00       	push   $0xcc
  801d33:	68 93 2d 80 00       	push   $0x802d93
  801d38:	e8 bf eb ff ff       	call   8008fc <_panic>

00801d3d <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801d3d:	55                   	push   %ebp
  801d3e:	89 e5                	mov    %esp,%ebp
  801d40:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d43:	83 ec 04             	sub    $0x4,%esp
  801d46:	68 70 2d 80 00       	push   $0x802d70
  801d4b:	68 d0 00 00 00       	push   $0xd0
  801d50:	68 93 2d 80 00       	push   $0x802d93
  801d55:	e8 a2 eb ff ff       	call   8008fc <_panic>

00801d5a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
  801d5d:	57                   	push   %edi
  801d5e:	56                   	push   %esi
  801d5f:	53                   	push   %ebx
  801d60:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d63:	8b 45 08             	mov    0x8(%ebp),%eax
  801d66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d69:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d6c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d6f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d72:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d75:	cd 30                	int    $0x30
  801d77:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d7d:	83 c4 10             	add    $0x10,%esp
  801d80:	5b                   	pop    %ebx
  801d81:	5e                   	pop    %esi
  801d82:	5f                   	pop    %edi
  801d83:	5d                   	pop    %ebp
  801d84:	c3                   	ret    

00801d85 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
  801d88:	83 ec 04             	sub    $0x4,%esp
  801d8b:	8b 45 10             	mov    0x10(%ebp),%eax
  801d8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d91:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d95:	8b 45 08             	mov    0x8(%ebp),%eax
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	52                   	push   %edx
  801d9d:	ff 75 0c             	pushl  0xc(%ebp)
  801da0:	50                   	push   %eax
  801da1:	6a 00                	push   $0x0
  801da3:	e8 b2 ff ff ff       	call   801d5a <syscall>
  801da8:	83 c4 18             	add    $0x18,%esp
}
  801dab:	90                   	nop
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_cgetc>:

int
sys_cgetc(void)
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 01                	push   $0x1
  801dbd:	e8 98 ff ff ff       	call   801d5a <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801dca:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	50                   	push   %eax
  801dd6:	6a 05                	push   $0x5
  801dd8:	e8 7d ff ff ff       	call   801d5a <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
}
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 02                	push   $0x2
  801df1:	e8 64 ff ff ff       	call   801d5a <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 03                	push   $0x3
  801e0a:	e8 4b ff ff ff       	call   801d5a <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
}
  801e12:	c9                   	leave  
  801e13:	c3                   	ret    

00801e14 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e14:	55                   	push   %ebp
  801e15:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 04                	push   $0x4
  801e23:	e8 32 ff ff ff       	call   801d5a <syscall>
  801e28:	83 c4 18             	add    $0x18,%esp
}
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_env_exit>:


void sys_env_exit(void)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 06                	push   $0x6
  801e3c:	e8 19 ff ff ff       	call   801d5a <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	90                   	nop
  801e45:	c9                   	leave  
  801e46:	c3                   	ret    

00801e47 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e47:	55                   	push   %ebp
  801e48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	52                   	push   %edx
  801e57:	50                   	push   %eax
  801e58:	6a 07                	push   $0x7
  801e5a:	e8 fb fe ff ff       	call   801d5a <syscall>
  801e5f:	83 c4 18             	add    $0x18,%esp
}
  801e62:	c9                   	leave  
  801e63:	c3                   	ret    

00801e64 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e64:	55                   	push   %ebp
  801e65:	89 e5                	mov    %esp,%ebp
  801e67:	56                   	push   %esi
  801e68:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e69:	8b 75 18             	mov    0x18(%ebp),%esi
  801e6c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e6f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e72:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e75:	8b 45 08             	mov    0x8(%ebp),%eax
  801e78:	56                   	push   %esi
  801e79:	53                   	push   %ebx
  801e7a:	51                   	push   %ecx
  801e7b:	52                   	push   %edx
  801e7c:	50                   	push   %eax
  801e7d:	6a 08                	push   $0x8
  801e7f:	e8 d6 fe ff ff       	call   801d5a <syscall>
  801e84:	83 c4 18             	add    $0x18,%esp
}
  801e87:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e8a:	5b                   	pop    %ebx
  801e8b:	5e                   	pop    %esi
  801e8c:	5d                   	pop    %ebp
  801e8d:	c3                   	ret    

00801e8e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e8e:	55                   	push   %ebp
  801e8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e91:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e94:	8b 45 08             	mov    0x8(%ebp),%eax
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	52                   	push   %edx
  801e9e:	50                   	push   %eax
  801e9f:	6a 09                	push   $0x9
  801ea1:	e8 b4 fe ff ff       	call   801d5a <syscall>
  801ea6:	83 c4 18             	add    $0x18,%esp
}
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	ff 75 0c             	pushl  0xc(%ebp)
  801eb7:	ff 75 08             	pushl  0x8(%ebp)
  801eba:	6a 0a                	push   $0xa
  801ebc:	e8 99 fe ff ff       	call   801d5a <syscall>
  801ec1:	83 c4 18             	add    $0x18,%esp
}
  801ec4:	c9                   	leave  
  801ec5:	c3                   	ret    

00801ec6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ec6:	55                   	push   %ebp
  801ec7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 0b                	push   $0xb
  801ed5:	e8 80 fe ff ff       	call   801d5a <syscall>
  801eda:	83 c4 18             	add    $0x18,%esp
}
  801edd:	c9                   	leave  
  801ede:	c3                   	ret    

00801edf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801edf:	55                   	push   %ebp
  801ee0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 0c                	push   $0xc
  801eee:	e8 67 fe ff ff       	call   801d5a <syscall>
  801ef3:	83 c4 18             	add    $0x18,%esp
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 0d                	push   $0xd
  801f07:	e8 4e fe ff ff       	call   801d5a <syscall>
  801f0c:	83 c4 18             	add    $0x18,%esp
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	ff 75 0c             	pushl  0xc(%ebp)
  801f1d:	ff 75 08             	pushl  0x8(%ebp)
  801f20:	6a 11                	push   $0x11
  801f22:	e8 33 fe ff ff       	call   801d5a <syscall>
  801f27:	83 c4 18             	add    $0x18,%esp
	return;
  801f2a:	90                   	nop
}
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	ff 75 0c             	pushl  0xc(%ebp)
  801f39:	ff 75 08             	pushl  0x8(%ebp)
  801f3c:	6a 12                	push   $0x12
  801f3e:	e8 17 fe ff ff       	call   801d5a <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
	return ;
  801f46:	90                   	nop
}
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 0e                	push   $0xe
  801f58:	e8 fd fd ff ff       	call   801d5a <syscall>
  801f5d:	83 c4 18             	add    $0x18,%esp
}
  801f60:	c9                   	leave  
  801f61:	c3                   	ret    

00801f62 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f62:	55                   	push   %ebp
  801f63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	ff 75 08             	pushl  0x8(%ebp)
  801f70:	6a 0f                	push   $0xf
  801f72:	e8 e3 fd ff ff       	call   801d5a <syscall>
  801f77:	83 c4 18             	add    $0x18,%esp
}
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 10                	push   $0x10
  801f8b:	e8 ca fd ff ff       	call   801d5a <syscall>
  801f90:	83 c4 18             	add    $0x18,%esp
}
  801f93:	90                   	nop
  801f94:	c9                   	leave  
  801f95:	c3                   	ret    

00801f96 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f96:	55                   	push   %ebp
  801f97:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 14                	push   $0x14
  801fa5:	e8 b0 fd ff ff       	call   801d5a <syscall>
  801faa:	83 c4 18             	add    $0x18,%esp
}
  801fad:	90                   	nop
  801fae:	c9                   	leave  
  801faf:	c3                   	ret    

00801fb0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fb0:	55                   	push   %ebp
  801fb1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 15                	push   $0x15
  801fbf:	e8 96 fd ff ff       	call   801d5a <syscall>
  801fc4:	83 c4 18             	add    $0x18,%esp
}
  801fc7:	90                   	nop
  801fc8:	c9                   	leave  
  801fc9:	c3                   	ret    

00801fca <sys_cputc>:


void
sys_cputc(const char c)
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
  801fcd:	83 ec 04             	sub    $0x4,%esp
  801fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fd6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	50                   	push   %eax
  801fe3:	6a 16                	push   $0x16
  801fe5:	e8 70 fd ff ff       	call   801d5a <syscall>
  801fea:	83 c4 18             	add    $0x18,%esp
}
  801fed:	90                   	nop
  801fee:	c9                   	leave  
  801fef:	c3                   	ret    

00801ff0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ff0:	55                   	push   %ebp
  801ff1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 17                	push   $0x17
  801fff:	e8 56 fd ff ff       	call   801d5a <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
}
  802007:	90                   	nop
  802008:	c9                   	leave  
  802009:	c3                   	ret    

0080200a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80200a:	55                   	push   %ebp
  80200b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80200d:	8b 45 08             	mov    0x8(%ebp),%eax
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	ff 75 0c             	pushl  0xc(%ebp)
  802019:	50                   	push   %eax
  80201a:	6a 18                	push   $0x18
  80201c:	e8 39 fd ff ff       	call   801d5a <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
}
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802029:	8b 55 0c             	mov    0xc(%ebp),%edx
  80202c:	8b 45 08             	mov    0x8(%ebp),%eax
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	52                   	push   %edx
  802036:	50                   	push   %eax
  802037:	6a 1b                	push   $0x1b
  802039:	e8 1c fd ff ff       	call   801d5a <syscall>
  80203e:	83 c4 18             	add    $0x18,%esp
}
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802046:	8b 55 0c             	mov    0xc(%ebp),%edx
  802049:	8b 45 08             	mov    0x8(%ebp),%eax
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	52                   	push   %edx
  802053:	50                   	push   %eax
  802054:	6a 19                	push   $0x19
  802056:	e8 ff fc ff ff       	call   801d5a <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
}
  80205e:	90                   	nop
  80205f:	c9                   	leave  
  802060:	c3                   	ret    

00802061 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802061:	55                   	push   %ebp
  802062:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802064:	8b 55 0c             	mov    0xc(%ebp),%edx
  802067:	8b 45 08             	mov    0x8(%ebp),%eax
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	52                   	push   %edx
  802071:	50                   	push   %eax
  802072:	6a 1a                	push   $0x1a
  802074:	e8 e1 fc ff ff       	call   801d5a <syscall>
  802079:	83 c4 18             	add    $0x18,%esp
}
  80207c:	90                   	nop
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
  802082:	83 ec 04             	sub    $0x4,%esp
  802085:	8b 45 10             	mov    0x10(%ebp),%eax
  802088:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80208b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80208e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802092:	8b 45 08             	mov    0x8(%ebp),%eax
  802095:	6a 00                	push   $0x0
  802097:	51                   	push   %ecx
  802098:	52                   	push   %edx
  802099:	ff 75 0c             	pushl  0xc(%ebp)
  80209c:	50                   	push   %eax
  80209d:	6a 1c                	push   $0x1c
  80209f:	e8 b6 fc ff ff       	call   801d5a <syscall>
  8020a4:	83 c4 18             	add    $0x18,%esp
}
  8020a7:	c9                   	leave  
  8020a8:	c3                   	ret    

008020a9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020a9:	55                   	push   %ebp
  8020aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020af:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	52                   	push   %edx
  8020b9:	50                   	push   %eax
  8020ba:	6a 1d                	push   $0x1d
  8020bc:	e8 99 fc ff ff       	call   801d5a <syscall>
  8020c1:	83 c4 18             	add    $0x18,%esp
}
  8020c4:	c9                   	leave  
  8020c5:	c3                   	ret    

008020c6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020c6:	55                   	push   %ebp
  8020c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	51                   	push   %ecx
  8020d7:	52                   	push   %edx
  8020d8:	50                   	push   %eax
  8020d9:	6a 1e                	push   $0x1e
  8020db:	e8 7a fc ff ff       	call   801d5a <syscall>
  8020e0:	83 c4 18             	add    $0x18,%esp
}
  8020e3:	c9                   	leave  
  8020e4:	c3                   	ret    

008020e5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020e5:	55                   	push   %ebp
  8020e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	52                   	push   %edx
  8020f5:	50                   	push   %eax
  8020f6:	6a 1f                	push   $0x1f
  8020f8:	e8 5d fc ff ff       	call   801d5a <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
}
  802100:	c9                   	leave  
  802101:	c3                   	ret    

00802102 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802102:	55                   	push   %ebp
  802103:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	6a 00                	push   $0x0
  80210f:	6a 20                	push   $0x20
  802111:	e8 44 fc ff ff       	call   801d5a <syscall>
  802116:	83 c4 18             	add    $0x18,%esp
}
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80211e:	8b 45 08             	mov    0x8(%ebp),%eax
  802121:	6a 00                	push   $0x0
  802123:	ff 75 14             	pushl  0x14(%ebp)
  802126:	ff 75 10             	pushl  0x10(%ebp)
  802129:	ff 75 0c             	pushl  0xc(%ebp)
  80212c:	50                   	push   %eax
  80212d:	6a 21                	push   $0x21
  80212f:	e8 26 fc ff ff       	call   801d5a <syscall>
  802134:	83 c4 18             	add    $0x18,%esp
}
  802137:	c9                   	leave  
  802138:	c3                   	ret    

00802139 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802139:	55                   	push   %ebp
  80213a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80213c:	8b 45 08             	mov    0x8(%ebp),%eax
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 00                	push   $0x0
  802147:	50                   	push   %eax
  802148:	6a 22                	push   $0x22
  80214a:	e8 0b fc ff ff       	call   801d5a <syscall>
  80214f:	83 c4 18             	add    $0x18,%esp
}
  802152:	90                   	nop
  802153:	c9                   	leave  
  802154:	c3                   	ret    

00802155 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802155:	55                   	push   %ebp
  802156:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802158:	8b 45 08             	mov    0x8(%ebp),%eax
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	50                   	push   %eax
  802164:	6a 23                	push   $0x23
  802166:	e8 ef fb ff ff       	call   801d5a <syscall>
  80216b:	83 c4 18             	add    $0x18,%esp
}
  80216e:	90                   	nop
  80216f:	c9                   	leave  
  802170:	c3                   	ret    

00802171 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802171:	55                   	push   %ebp
  802172:	89 e5                	mov    %esp,%ebp
  802174:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802177:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80217a:	8d 50 04             	lea    0x4(%eax),%edx
  80217d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	52                   	push   %edx
  802187:	50                   	push   %eax
  802188:	6a 24                	push   $0x24
  80218a:	e8 cb fb ff ff       	call   801d5a <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
	return result;
  802192:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802195:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802198:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80219b:	89 01                	mov    %eax,(%ecx)
  80219d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a3:	c9                   	leave  
  8021a4:	c2 04 00             	ret    $0x4

008021a7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021a7:	55                   	push   %ebp
  8021a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 00                	push   $0x0
  8021ae:	ff 75 10             	pushl  0x10(%ebp)
  8021b1:	ff 75 0c             	pushl  0xc(%ebp)
  8021b4:	ff 75 08             	pushl  0x8(%ebp)
  8021b7:	6a 13                	push   $0x13
  8021b9:	e8 9c fb ff ff       	call   801d5a <syscall>
  8021be:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c1:	90                   	nop
}
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 25                	push   $0x25
  8021d3:	e8 82 fb ff ff       	call   801d5a <syscall>
  8021d8:	83 c4 18             	add    $0x18,%esp
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
  8021e0:	83 ec 04             	sub    $0x4,%esp
  8021e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021e9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	50                   	push   %eax
  8021f6:	6a 26                	push   $0x26
  8021f8:	e8 5d fb ff ff       	call   801d5a <syscall>
  8021fd:	83 c4 18             	add    $0x18,%esp
	return ;
  802200:	90                   	nop
}
  802201:	c9                   	leave  
  802202:	c3                   	ret    

00802203 <rsttst>:
void rsttst()
{
  802203:	55                   	push   %ebp
  802204:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 28                	push   $0x28
  802212:	e8 43 fb ff ff       	call   801d5a <syscall>
  802217:	83 c4 18             	add    $0x18,%esp
	return ;
  80221a:	90                   	nop
}
  80221b:	c9                   	leave  
  80221c:	c3                   	ret    

0080221d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80221d:	55                   	push   %ebp
  80221e:	89 e5                	mov    %esp,%ebp
  802220:	83 ec 04             	sub    $0x4,%esp
  802223:	8b 45 14             	mov    0x14(%ebp),%eax
  802226:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802229:	8b 55 18             	mov    0x18(%ebp),%edx
  80222c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802230:	52                   	push   %edx
  802231:	50                   	push   %eax
  802232:	ff 75 10             	pushl  0x10(%ebp)
  802235:	ff 75 0c             	pushl  0xc(%ebp)
  802238:	ff 75 08             	pushl  0x8(%ebp)
  80223b:	6a 27                	push   $0x27
  80223d:	e8 18 fb ff ff       	call   801d5a <syscall>
  802242:	83 c4 18             	add    $0x18,%esp
	return ;
  802245:	90                   	nop
}
  802246:	c9                   	leave  
  802247:	c3                   	ret    

00802248 <chktst>:
void chktst(uint32 n)
{
  802248:	55                   	push   %ebp
  802249:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80224b:	6a 00                	push   $0x0
  80224d:	6a 00                	push   $0x0
  80224f:	6a 00                	push   $0x0
  802251:	6a 00                	push   $0x0
  802253:	ff 75 08             	pushl  0x8(%ebp)
  802256:	6a 29                	push   $0x29
  802258:	e8 fd fa ff ff       	call   801d5a <syscall>
  80225d:	83 c4 18             	add    $0x18,%esp
	return ;
  802260:	90                   	nop
}
  802261:	c9                   	leave  
  802262:	c3                   	ret    

00802263 <inctst>:

void inctst()
{
  802263:	55                   	push   %ebp
  802264:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	6a 2a                	push   $0x2a
  802272:	e8 e3 fa ff ff       	call   801d5a <syscall>
  802277:	83 c4 18             	add    $0x18,%esp
	return ;
  80227a:	90                   	nop
}
  80227b:	c9                   	leave  
  80227c:	c3                   	ret    

0080227d <gettst>:
uint32 gettst()
{
  80227d:	55                   	push   %ebp
  80227e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802280:	6a 00                	push   $0x0
  802282:	6a 00                	push   $0x0
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	6a 00                	push   $0x0
  80228a:	6a 2b                	push   $0x2b
  80228c:	e8 c9 fa ff ff       	call   801d5a <syscall>
  802291:	83 c4 18             	add    $0x18,%esp
}
  802294:	c9                   	leave  
  802295:	c3                   	ret    

00802296 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802296:	55                   	push   %ebp
  802297:	89 e5                	mov    %esp,%ebp
  802299:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 00                	push   $0x0
  8022a2:	6a 00                	push   $0x0
  8022a4:	6a 00                	push   $0x0
  8022a6:	6a 2c                	push   $0x2c
  8022a8:	e8 ad fa ff ff       	call   801d5a <syscall>
  8022ad:	83 c4 18             	add    $0x18,%esp
  8022b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022b3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022b7:	75 07                	jne    8022c0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8022be:	eb 05                	jmp    8022c5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022c5:	c9                   	leave  
  8022c6:	c3                   	ret    

008022c7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022c7:	55                   	push   %ebp
  8022c8:	89 e5                	mov    %esp,%ebp
  8022ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 00                	push   $0x0
  8022d7:	6a 2c                	push   $0x2c
  8022d9:	e8 7c fa ff ff       	call   801d5a <syscall>
  8022de:	83 c4 18             	add    $0x18,%esp
  8022e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022e4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022e8:	75 07                	jne    8022f1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ef:	eb 05                	jmp    8022f6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022f6:	c9                   	leave  
  8022f7:	c3                   	ret    

008022f8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022f8:	55                   	push   %ebp
  8022f9:	89 e5                	mov    %esp,%ebp
  8022fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022fe:	6a 00                	push   $0x0
  802300:	6a 00                	push   $0x0
  802302:	6a 00                	push   $0x0
  802304:	6a 00                	push   $0x0
  802306:	6a 00                	push   $0x0
  802308:	6a 2c                	push   $0x2c
  80230a:	e8 4b fa ff ff       	call   801d5a <syscall>
  80230f:	83 c4 18             	add    $0x18,%esp
  802312:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802315:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802319:	75 07                	jne    802322 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80231b:	b8 01 00 00 00       	mov    $0x1,%eax
  802320:	eb 05                	jmp    802327 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802322:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802327:	c9                   	leave  
  802328:	c3                   	ret    

00802329 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802329:	55                   	push   %ebp
  80232a:	89 e5                	mov    %esp,%ebp
  80232c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80232f:	6a 00                	push   $0x0
  802331:	6a 00                	push   $0x0
  802333:	6a 00                	push   $0x0
  802335:	6a 00                	push   $0x0
  802337:	6a 00                	push   $0x0
  802339:	6a 2c                	push   $0x2c
  80233b:	e8 1a fa ff ff       	call   801d5a <syscall>
  802340:	83 c4 18             	add    $0x18,%esp
  802343:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802346:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80234a:	75 07                	jne    802353 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80234c:	b8 01 00 00 00       	mov    $0x1,%eax
  802351:	eb 05                	jmp    802358 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802353:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802358:	c9                   	leave  
  802359:	c3                   	ret    

0080235a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80235a:	55                   	push   %ebp
  80235b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80235d:	6a 00                	push   $0x0
  80235f:	6a 00                	push   $0x0
  802361:	6a 00                	push   $0x0
  802363:	6a 00                	push   $0x0
  802365:	ff 75 08             	pushl  0x8(%ebp)
  802368:	6a 2d                	push   $0x2d
  80236a:	e8 eb f9 ff ff       	call   801d5a <syscall>
  80236f:	83 c4 18             	add    $0x18,%esp
	return ;
  802372:	90                   	nop
}
  802373:	c9                   	leave  
  802374:	c3                   	ret    

00802375 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802375:	55                   	push   %ebp
  802376:	89 e5                	mov    %esp,%ebp
  802378:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802379:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80237c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80237f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802382:	8b 45 08             	mov    0x8(%ebp),%eax
  802385:	6a 00                	push   $0x0
  802387:	53                   	push   %ebx
  802388:	51                   	push   %ecx
  802389:	52                   	push   %edx
  80238a:	50                   	push   %eax
  80238b:	6a 2e                	push   $0x2e
  80238d:	e8 c8 f9 ff ff       	call   801d5a <syscall>
  802392:	83 c4 18             	add    $0x18,%esp
}
  802395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802398:	c9                   	leave  
  802399:	c3                   	ret    

0080239a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80239a:	55                   	push   %ebp
  80239b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80239d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 00                	push   $0x0
  8023a7:	6a 00                	push   $0x0
  8023a9:	52                   	push   %edx
  8023aa:	50                   	push   %eax
  8023ab:	6a 2f                	push   $0x2f
  8023ad:	e8 a8 f9 ff ff       	call   801d5a <syscall>
  8023b2:	83 c4 18             	add    $0x18,%esp
}
  8023b5:	c9                   	leave  
  8023b6:	c3                   	ret    
  8023b7:	90                   	nop

008023b8 <__udivdi3>:
  8023b8:	55                   	push   %ebp
  8023b9:	57                   	push   %edi
  8023ba:	56                   	push   %esi
  8023bb:	53                   	push   %ebx
  8023bc:	83 ec 1c             	sub    $0x1c,%esp
  8023bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023cf:	89 ca                	mov    %ecx,%edx
  8023d1:	89 f8                	mov    %edi,%eax
  8023d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023d7:	85 f6                	test   %esi,%esi
  8023d9:	75 2d                	jne    802408 <__udivdi3+0x50>
  8023db:	39 cf                	cmp    %ecx,%edi
  8023dd:	77 65                	ja     802444 <__udivdi3+0x8c>
  8023df:	89 fd                	mov    %edi,%ebp
  8023e1:	85 ff                	test   %edi,%edi
  8023e3:	75 0b                	jne    8023f0 <__udivdi3+0x38>
  8023e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ea:	31 d2                	xor    %edx,%edx
  8023ec:	f7 f7                	div    %edi
  8023ee:	89 c5                	mov    %eax,%ebp
  8023f0:	31 d2                	xor    %edx,%edx
  8023f2:	89 c8                	mov    %ecx,%eax
  8023f4:	f7 f5                	div    %ebp
  8023f6:	89 c1                	mov    %eax,%ecx
  8023f8:	89 d8                	mov    %ebx,%eax
  8023fa:	f7 f5                	div    %ebp
  8023fc:	89 cf                	mov    %ecx,%edi
  8023fe:	89 fa                	mov    %edi,%edx
  802400:	83 c4 1c             	add    $0x1c,%esp
  802403:	5b                   	pop    %ebx
  802404:	5e                   	pop    %esi
  802405:	5f                   	pop    %edi
  802406:	5d                   	pop    %ebp
  802407:	c3                   	ret    
  802408:	39 ce                	cmp    %ecx,%esi
  80240a:	77 28                	ja     802434 <__udivdi3+0x7c>
  80240c:	0f bd fe             	bsr    %esi,%edi
  80240f:	83 f7 1f             	xor    $0x1f,%edi
  802412:	75 40                	jne    802454 <__udivdi3+0x9c>
  802414:	39 ce                	cmp    %ecx,%esi
  802416:	72 0a                	jb     802422 <__udivdi3+0x6a>
  802418:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80241c:	0f 87 9e 00 00 00    	ja     8024c0 <__udivdi3+0x108>
  802422:	b8 01 00 00 00       	mov    $0x1,%eax
  802427:	89 fa                	mov    %edi,%edx
  802429:	83 c4 1c             	add    $0x1c,%esp
  80242c:	5b                   	pop    %ebx
  80242d:	5e                   	pop    %esi
  80242e:	5f                   	pop    %edi
  80242f:	5d                   	pop    %ebp
  802430:	c3                   	ret    
  802431:	8d 76 00             	lea    0x0(%esi),%esi
  802434:	31 ff                	xor    %edi,%edi
  802436:	31 c0                	xor    %eax,%eax
  802438:	89 fa                	mov    %edi,%edx
  80243a:	83 c4 1c             	add    $0x1c,%esp
  80243d:	5b                   	pop    %ebx
  80243e:	5e                   	pop    %esi
  80243f:	5f                   	pop    %edi
  802440:	5d                   	pop    %ebp
  802441:	c3                   	ret    
  802442:	66 90                	xchg   %ax,%ax
  802444:	89 d8                	mov    %ebx,%eax
  802446:	f7 f7                	div    %edi
  802448:	31 ff                	xor    %edi,%edi
  80244a:	89 fa                	mov    %edi,%edx
  80244c:	83 c4 1c             	add    $0x1c,%esp
  80244f:	5b                   	pop    %ebx
  802450:	5e                   	pop    %esi
  802451:	5f                   	pop    %edi
  802452:	5d                   	pop    %ebp
  802453:	c3                   	ret    
  802454:	bd 20 00 00 00       	mov    $0x20,%ebp
  802459:	89 eb                	mov    %ebp,%ebx
  80245b:	29 fb                	sub    %edi,%ebx
  80245d:	89 f9                	mov    %edi,%ecx
  80245f:	d3 e6                	shl    %cl,%esi
  802461:	89 c5                	mov    %eax,%ebp
  802463:	88 d9                	mov    %bl,%cl
  802465:	d3 ed                	shr    %cl,%ebp
  802467:	89 e9                	mov    %ebp,%ecx
  802469:	09 f1                	or     %esi,%ecx
  80246b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80246f:	89 f9                	mov    %edi,%ecx
  802471:	d3 e0                	shl    %cl,%eax
  802473:	89 c5                	mov    %eax,%ebp
  802475:	89 d6                	mov    %edx,%esi
  802477:	88 d9                	mov    %bl,%cl
  802479:	d3 ee                	shr    %cl,%esi
  80247b:	89 f9                	mov    %edi,%ecx
  80247d:	d3 e2                	shl    %cl,%edx
  80247f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802483:	88 d9                	mov    %bl,%cl
  802485:	d3 e8                	shr    %cl,%eax
  802487:	09 c2                	or     %eax,%edx
  802489:	89 d0                	mov    %edx,%eax
  80248b:	89 f2                	mov    %esi,%edx
  80248d:	f7 74 24 0c          	divl   0xc(%esp)
  802491:	89 d6                	mov    %edx,%esi
  802493:	89 c3                	mov    %eax,%ebx
  802495:	f7 e5                	mul    %ebp
  802497:	39 d6                	cmp    %edx,%esi
  802499:	72 19                	jb     8024b4 <__udivdi3+0xfc>
  80249b:	74 0b                	je     8024a8 <__udivdi3+0xf0>
  80249d:	89 d8                	mov    %ebx,%eax
  80249f:	31 ff                	xor    %edi,%edi
  8024a1:	e9 58 ff ff ff       	jmp    8023fe <__udivdi3+0x46>
  8024a6:	66 90                	xchg   %ax,%ax
  8024a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024ac:	89 f9                	mov    %edi,%ecx
  8024ae:	d3 e2                	shl    %cl,%edx
  8024b0:	39 c2                	cmp    %eax,%edx
  8024b2:	73 e9                	jae    80249d <__udivdi3+0xe5>
  8024b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024b7:	31 ff                	xor    %edi,%edi
  8024b9:	e9 40 ff ff ff       	jmp    8023fe <__udivdi3+0x46>
  8024be:	66 90                	xchg   %ax,%ax
  8024c0:	31 c0                	xor    %eax,%eax
  8024c2:	e9 37 ff ff ff       	jmp    8023fe <__udivdi3+0x46>
  8024c7:	90                   	nop

008024c8 <__umoddi3>:
  8024c8:	55                   	push   %ebp
  8024c9:	57                   	push   %edi
  8024ca:	56                   	push   %esi
  8024cb:	53                   	push   %ebx
  8024cc:	83 ec 1c             	sub    $0x1c,%esp
  8024cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024e7:	89 f3                	mov    %esi,%ebx
  8024e9:	89 fa                	mov    %edi,%edx
  8024eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024ef:	89 34 24             	mov    %esi,(%esp)
  8024f2:	85 c0                	test   %eax,%eax
  8024f4:	75 1a                	jne    802510 <__umoddi3+0x48>
  8024f6:	39 f7                	cmp    %esi,%edi
  8024f8:	0f 86 a2 00 00 00    	jbe    8025a0 <__umoddi3+0xd8>
  8024fe:	89 c8                	mov    %ecx,%eax
  802500:	89 f2                	mov    %esi,%edx
  802502:	f7 f7                	div    %edi
  802504:	89 d0                	mov    %edx,%eax
  802506:	31 d2                	xor    %edx,%edx
  802508:	83 c4 1c             	add    $0x1c,%esp
  80250b:	5b                   	pop    %ebx
  80250c:	5e                   	pop    %esi
  80250d:	5f                   	pop    %edi
  80250e:	5d                   	pop    %ebp
  80250f:	c3                   	ret    
  802510:	39 f0                	cmp    %esi,%eax
  802512:	0f 87 ac 00 00 00    	ja     8025c4 <__umoddi3+0xfc>
  802518:	0f bd e8             	bsr    %eax,%ebp
  80251b:	83 f5 1f             	xor    $0x1f,%ebp
  80251e:	0f 84 ac 00 00 00    	je     8025d0 <__umoddi3+0x108>
  802524:	bf 20 00 00 00       	mov    $0x20,%edi
  802529:	29 ef                	sub    %ebp,%edi
  80252b:	89 fe                	mov    %edi,%esi
  80252d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802531:	89 e9                	mov    %ebp,%ecx
  802533:	d3 e0                	shl    %cl,%eax
  802535:	89 d7                	mov    %edx,%edi
  802537:	89 f1                	mov    %esi,%ecx
  802539:	d3 ef                	shr    %cl,%edi
  80253b:	09 c7                	or     %eax,%edi
  80253d:	89 e9                	mov    %ebp,%ecx
  80253f:	d3 e2                	shl    %cl,%edx
  802541:	89 14 24             	mov    %edx,(%esp)
  802544:	89 d8                	mov    %ebx,%eax
  802546:	d3 e0                	shl    %cl,%eax
  802548:	89 c2                	mov    %eax,%edx
  80254a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80254e:	d3 e0                	shl    %cl,%eax
  802550:	89 44 24 04          	mov    %eax,0x4(%esp)
  802554:	8b 44 24 08          	mov    0x8(%esp),%eax
  802558:	89 f1                	mov    %esi,%ecx
  80255a:	d3 e8                	shr    %cl,%eax
  80255c:	09 d0                	or     %edx,%eax
  80255e:	d3 eb                	shr    %cl,%ebx
  802560:	89 da                	mov    %ebx,%edx
  802562:	f7 f7                	div    %edi
  802564:	89 d3                	mov    %edx,%ebx
  802566:	f7 24 24             	mull   (%esp)
  802569:	89 c6                	mov    %eax,%esi
  80256b:	89 d1                	mov    %edx,%ecx
  80256d:	39 d3                	cmp    %edx,%ebx
  80256f:	0f 82 87 00 00 00    	jb     8025fc <__umoddi3+0x134>
  802575:	0f 84 91 00 00 00    	je     80260c <__umoddi3+0x144>
  80257b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80257f:	29 f2                	sub    %esi,%edx
  802581:	19 cb                	sbb    %ecx,%ebx
  802583:	89 d8                	mov    %ebx,%eax
  802585:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802589:	d3 e0                	shl    %cl,%eax
  80258b:	89 e9                	mov    %ebp,%ecx
  80258d:	d3 ea                	shr    %cl,%edx
  80258f:	09 d0                	or     %edx,%eax
  802591:	89 e9                	mov    %ebp,%ecx
  802593:	d3 eb                	shr    %cl,%ebx
  802595:	89 da                	mov    %ebx,%edx
  802597:	83 c4 1c             	add    $0x1c,%esp
  80259a:	5b                   	pop    %ebx
  80259b:	5e                   	pop    %esi
  80259c:	5f                   	pop    %edi
  80259d:	5d                   	pop    %ebp
  80259e:	c3                   	ret    
  80259f:	90                   	nop
  8025a0:	89 fd                	mov    %edi,%ebp
  8025a2:	85 ff                	test   %edi,%edi
  8025a4:	75 0b                	jne    8025b1 <__umoddi3+0xe9>
  8025a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8025ab:	31 d2                	xor    %edx,%edx
  8025ad:	f7 f7                	div    %edi
  8025af:	89 c5                	mov    %eax,%ebp
  8025b1:	89 f0                	mov    %esi,%eax
  8025b3:	31 d2                	xor    %edx,%edx
  8025b5:	f7 f5                	div    %ebp
  8025b7:	89 c8                	mov    %ecx,%eax
  8025b9:	f7 f5                	div    %ebp
  8025bb:	89 d0                	mov    %edx,%eax
  8025bd:	e9 44 ff ff ff       	jmp    802506 <__umoddi3+0x3e>
  8025c2:	66 90                	xchg   %ax,%ax
  8025c4:	89 c8                	mov    %ecx,%eax
  8025c6:	89 f2                	mov    %esi,%edx
  8025c8:	83 c4 1c             	add    $0x1c,%esp
  8025cb:	5b                   	pop    %ebx
  8025cc:	5e                   	pop    %esi
  8025cd:	5f                   	pop    %edi
  8025ce:	5d                   	pop    %ebp
  8025cf:	c3                   	ret    
  8025d0:	3b 04 24             	cmp    (%esp),%eax
  8025d3:	72 06                	jb     8025db <__umoddi3+0x113>
  8025d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025d9:	77 0f                	ja     8025ea <__umoddi3+0x122>
  8025db:	89 f2                	mov    %esi,%edx
  8025dd:	29 f9                	sub    %edi,%ecx
  8025df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025e3:	89 14 24             	mov    %edx,(%esp)
  8025e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025ee:	8b 14 24             	mov    (%esp),%edx
  8025f1:	83 c4 1c             	add    $0x1c,%esp
  8025f4:	5b                   	pop    %ebx
  8025f5:	5e                   	pop    %esi
  8025f6:	5f                   	pop    %edi
  8025f7:	5d                   	pop    %ebp
  8025f8:	c3                   	ret    
  8025f9:	8d 76 00             	lea    0x0(%esi),%esi
  8025fc:	2b 04 24             	sub    (%esp),%eax
  8025ff:	19 fa                	sbb    %edi,%edx
  802601:	89 d1                	mov    %edx,%ecx
  802603:	89 c6                	mov    %eax,%esi
  802605:	e9 71 ff ff ff       	jmp    80257b <__umoddi3+0xb3>
  80260a:	66 90                	xchg   %ax,%ax
  80260c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802610:	72 ea                	jb     8025fc <__umoddi3+0x134>
  802612:	89 d9                	mov    %ebx,%ecx
  802614:	e9 62 ff ff ff       	jmp    80257b <__umoddi3+0xb3>
