grammar Tiny;

/*---------------- PARSER INTERNALS ----------------*/

@parser::header
{
# symbol_table = []
}

/*---------------- LEXER RULES ----------------*/

COMMENT: '//' ~('\n')*       -> skip ;
SPACE: (' '|'\t'|'\r'|'\n')+ -> skip ;

PLUS  : '+' ;
TIMES : '*' ;
OP_PAR: '(' ; 
CL_PAR: ')' ;
OP_CUR: '{' ;
CL_CUR: '}' ; 

FUNC        :   'func'   ;
MAIN        :   'main'   ;
PRINTLN     :   'println';

NUMBER: '0'..'9'+ ;


/*---------------- PARSER RULES ----------------*/

program:
    {if 1:
        print('.source Test.src')
        print('.class  public Test')
        print('.super  java/lang/Object\n')
        print('.method public <init>()V')
        print('    aload_0')
        print('    invokenonvirtual java/lang/Object/<init>()V')
        print('    return')
        print('.end method\n')
    }
    main
    ;

main:
    FUNC MAIN OP_PAR CL_PAR OP_CUR
    {if True:
        print('.method public static main([Ljava/lang/String;)V\n')
    }
    ( statement )* 
    {if True:
        print('    return')
        print('.limit stack 10')
        print('.end method')
        # print('\n; symbol_table:', symbol_table)
    }
    CL_CUR
    ;

statement:
    st_println
    ;

st_println:
    PRINTLN OP_PAR 
    {if True:
        print('    getstatic java/lang/System/out Ljava/io/PrintStream;')

    } 
    expression
    {if True: 
        print('    invokevirtual java/io/PrintStream/println(I)V\n')
    }
    CL_PAR
    ;

expression:
    term ( op = PLUS expression
    {if 1:
        print('    iadd')
    }
    )?
    ;

term: factor ( op = TIMES term
    {if 1:
        print('    imul')
    }
    )?
    ;

factor: 
    NUMBER
    {if 1:
        print('    ldc ' + $NUMBER.text)
        # symbol_table.append($NUMBER.text)
    }
    | OP_PAR expression CL_PAR
    ;

