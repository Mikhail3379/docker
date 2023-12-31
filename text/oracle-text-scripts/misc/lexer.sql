-- run this bit once

begin
  begin  
    ctx_ddl.drop_preference('jp_lexer');
  exception when others then null;
  end;
  begin
    ctx_ddl.drop_policy('jp_policy');
  exception when others then null;
  end;
  ctx_ddl.create_preference('jp_lexer', 'japanese_lexer');
  ctx_ddl.create_policy(policy_name => 'jp_policy', lexer => 'jp_lexer');
end;
/

-- this creates the procedure

create or replace function get_jp_tokens ( document clob ) return clob is
  the_tokens ctx_doc.token_tab;
  workspace  clob;
  begin
     ctx_doc.policy_tokens( 
        policy_name => 'jp_policy',
        document    => document,
        restab      => the_tokens,
        language    => 'JP'
        );
     dbms_lob.createtemporary( workspace, true );
     for i in 1..the_tokens.count loop
  	 dbms_lob.append( workspace, the_tokens(i).token || ';' );
     end loop;
     return workspace;
  end;
/ 
show err

-- here we call it from SQL*Plus for test purposes - these look Japanese to me but who knows what they will look like when you get it!

variable foo clob
exec :foo := get_jp_tokens('    ラドクリフ、マラソン五輪代表に1万m出場にも含み ')
