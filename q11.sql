select kind_out as out_type,count(kind_out) as number from wicket_taken group by kind_out order by number desc,out_type;
