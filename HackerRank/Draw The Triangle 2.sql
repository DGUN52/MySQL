delimiter |

create procedure p(in val int)
begin
    declare pattern varchar(255);
    declare num int;
    
    set num = 0;
    
    while num < val do
        set num = num + 1;
        set pattern = repeat("* ", num);
        select pattern;
    end while;
end |

delimiter ;

call p(20);