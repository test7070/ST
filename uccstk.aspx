<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string date;
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString = "";
        public void Page_Load()
        {
        	string db = "st";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;
           // connectionString = "Data Source=125.227.231.15,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=st";

			var item = new ParaIn();
            if (Request.QueryString["date"] != null && Request.QueryString["date"].Length > 0)
            {
                item.date = Request.QueryString["date"];
            }
            
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"uccstk_1:--uccstk_1  裕承隆庫存成本
	SET QUOTED_IDENTIFIER OFF 
	declare @cmd nvarchar(max) 

	declare @n int
	declare @listrc2 table(
		tablea nvarchar(20),
		tableas nvarchar(20),
		accy nvarchar(20)
	)
	insert into @listrc2(tablea,tableas,accy)
	SELECT TABLE_NAME 
	,replace(TABLE_NAME,'rc2','rc2s')
	,replace(TABLE_NAME,'rc2','')
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'rc2[0-9][0-9][0-9]'
	
	declare @listina table(
		tablea nvarchar(20),
		tableas nvarchar(20),
		accy nvarchar(20)
	)
	insert into @listina(tablea,tableas,accy)
	SELECT TABLE_NAME 
	,replace(TABLE_NAME,'ina','inas')
	,replace(TABLE_NAME,'ina','')
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'ina[0-9][0-9][0-9]'
	
	declare @listcut table(
		tablea nvarchar(20),
		tableas nvarchar(20),
		accy nvarchar(20)
	)
	insert into @listcut(tablea,tableas,accy)
	SELECT TABLE_NAME 
	,replace(TABLE_NAME,'cut','cuts')
	,replace(TABLE_NAME,'cut','')
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'cut[0-9][0-9][0-9]'
	
	declare @listcub table(
		tablea nvarchar(20),
		tableas nvarchar(20),
		tableat nvarchar(20),
		tableau nvarchar(20),
		accy nvarchar(20)
	)
	insert into @listcub(tablea,tableas,tableat,tableau,accy)
	SELECT TABLE_NAME 
	,replace(TABLE_NAME,'cub','cubs')
	,replace(TABLE_NAME,'cub','cubt')
	,replace(TABLE_NAME,'cub','cubu')
	,replace(TABLE_NAME,'cub','')
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'cub[0-9][0-9][0-9]'
	
	declare @listvcc table(
		tablea nvarchar(20),
		tableas nvarchar(20),
		accy nvarchar(20)
	)
	insert into @listvcc(tablea,tableas,accy)
	SELECT TABLE_NAME 
	,replace(TABLE_NAME,'vcc','vccs')
	,replace(TABLE_NAME,'vcc','')
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'vcc[0-9][0-9][0-9]'
	
	declare @listget table(
		tablea nvarchar(20),
		tableas nvarchar(20),
		accy nvarchar(20)
	)
	insert into @listget(tablea,tableas,accy)
	SELECT TABLE_NAME 
	,replace(TABLE_NAME,'get','gets')
	,replace(TABLE_NAME,'get','')
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'get[0-9][0-9][0-9]'
	----------------------------------------------------------------------------------
	IF OBJECT_ID('tempdb..#z_uccstk')is not null
	BEGIN
		set @cmd = 'drop table #z_uccstk'
		EXECUTE sp_executesql @cmd
	END
	create table #z_uccstk(
		isprice int,--是否已算出成本
		tablea nvarchar(20),
		accy nvarchar(10),
		noa nvarchar(20),
		noq nvarchar(10),
		datea nvarchar(10),
		uno nvarchar(50),
		mount float,
		[weight] float,
		price float,
		price2 float,
		cutprice float,
		[money] float,
		money2 float,
		memo nvarchar(max),
		productno nvarchar(20),
		style nvarchar(20),
		groupa nvarchar(20)
	)
	CREATE INDEX index01 ON #z_uccstk (tablea,accy,noa,noq)
	CREATE INDEX index02 ON #z_uccstk (uno)
	CREATE INDEX index03 ON #z_uccstk (tablea,accy,noa,productno,groupa)
	
	declare @tablea nvarchar(20)
	declare @tableas nvarchar(20)
	declare @tableat nvarchar(20)
	declare @tableau nvarchar(20)
	declare @accy nvarchar(10)
	----------------------------------------------------------------------------------
	--rc2 進貨金額即成本
	declare cursor_table cursor for
	select tablea,tableas,accy from @listrc2
	open cursor_table
	fetch next from cursor_table
	into @tablea,@tableas,@accy
	while(@@FETCH_STATUS <> -1)
	begin
		--deli 轉來的不計算
		set @cmd =
		"" select 1,'rc2s',@accy,a.noa,a.noq,b.datea""+
		"" ,a.uno,isnull(a.mount,0),isnull(a.[weight],0)""+
		"" ,case when d.noa is not null then a.sprice else case when isnull(a.weight,0)=0 then isnull(a.price,0) else isnull(a.total,0)/isnull(a.weight,0) end + case when isnull(a.[weight],0)=0 or isnull(c.weight,0)=0 then 0 else isnull(a.[weight],0)/c.weight*isnull(b.tranmoney,0)/isnull(a.[weight],0) end end""+
		"" ,case when d.noa is not null then a.sprice2 else case when isnull(a.weight,0)=0 then isnull(a.price,0) else isnull(a.total,0)/isnull(a.weight,0) end end""+
		"" ,round((case when isnull(a.weight,0)=0 then isnull(a.price,0) else isnull(a.total,0)/isnull(a.weight,0) end+case when isnull(a.[weight],0)=0 or isnull(c.weight,0)=0 then 0 else isnull(a.[weight],0)/c.weight*isnull(b.tranmoney,0)/isnull(a.[weight],0) end)*isnull(a.[weight],0),0)""+
		"" ,isnull(a.total,0)""+
		"" ,case when b.noa is null then '表頭遺失' else '' end""+
		"" ,a.productno""+
		"" from ""+@tableas+"" a left join ""+@tablea+"" b on a.noa=b.noa""+
		"" outer apply (select sum(isnull(weight,0)) weight from ""+@tableas+"" where noa=a.noa and not(lower(left(uno,1))='x' or lower(left(uno,1))='y' or lower(left(uno,1))='z')) c""+
		"" left join deli d on a.noa=d.rc2no""+
		"" where len(isnull(a.uno,''))>0""+
		"" and isnull(b.typea,'1')='1'""+
		"" and not(lower(left(a.uno,1))='x' or lower(left(a.uno,1))='y' or lower(left(a.uno,1))='z')""
		
		insert into #z_uccstk(isprice,tablea,accy,noa,noq,datea,uno,mount,[weight],price,price2,[money],money2,memo,productno)
		execute sp_executesql @cmd,N'@accy nvarchar(20)',@accy=@accy
		
		fetch next from cursor_table
		into @tablea,@tableas,@accy
	end
	close cursor_table
	deallocate cursor_table
	
	----------------------------------------------------------------------------------
	--廢料 X,Y,Z 不計算
	--ina 入庫金額即成本
	declare cursor_table cursor for
	select tablea,tableas,accy from @listina
	open cursor_table
	fetch next from cursor_table
	into @tablea,@tableas,@accy
	while(@@FETCH_STATUS <> -1)
	begin
		set @cmd =
		"" select 1,'inas',@accy,a.noa,a.noq,b.datea""+
		"" ,a.uno,isnull(a.mount,0),isnull(a.[weight],0)""+
		"" ,case when isnull(a.weight,0)=0 then isnull(a.price,0) else isnull(a.total,0)/isnull(a.weight,0) end+case when isnull(a.[weight],0)=0 or isnull(c.weight,0)=0 then 0 else isnull(a.[weight],0)/c.weight*isnull(b.tranmoney,0)/isnull(a.[weight],0) end""+
		"" ,case when isnull(a.weight,0)=0 then isnull(a.price,0) else isnull(a.total,0)/isnull(a.weight,0) end""+
		"" ,round((case when isnull(a.weight,0)=0 then isnull(a.price,0) else isnull(a.total,0)/isnull(a.weight,0) end+case when isnull(a.[weight],0)=0 or isnull(c.weight,0)=0 then 0 else isnull(a.[weight],0)/c.weight*isnull(b.tranmoney,0)/isnull(a.[weight],0) end)*isnull(a.[weight],0),0)""+
		"" ,isnull(a.total,0)""+
		"" ,case when b.noa is null then '表頭遺失' else '' end""+
		"" ,a.productno""+
		"" from ""+@tableas+"" a left join ""+@tablea+"" b on a.noa=b.noa""+
		"" outer apply (select sum(isnull(weight,0)) weight from ""+@tableas+"" where noa=a.noa and not(lower(left(uno,1))='x' or lower(left(uno,1))='y' or lower(left(uno,1))='z')) c""+
		"" where len(isnull(a.uno,''))>0 ""+
		"" and not(lower(left(a.uno,1))='x' or lower(left(a.uno,1))='y' or lower(left(a.uno,1))='z')""
		
		insert into #z_uccstk(isprice,tablea,accy,noa,noq,datea,uno,mount,[weight],price,price2,[money],money2,memo,productno)
		execute sp_executesql @cmd,N'@accy nvarchar(20)',@accy=@accy
		
		fetch next from cursor_table
		into @tablea,@tableas,@accy
	end
	close cursor_table
	deallocate cursor_table
	----------------------------------------------------------------------------------
	
	--cut 需再計算成本
	declare cursor_table cursor for
	select tablea,tableas,accy from @listcut
	open cursor_table
	fetch next from cursor_table
	into @tablea,@tableas,@accy
	while(@@FETCH_STATUS <> -1)
	begin
		set @cmd =
		"" select 0,'cuts',@accy,a.noa,a.noq,b.datea""+
		"" ,a.bno,isnull(a.mount,0),isnull(a.[wprice],0),isnull(a.[weight],0)""+
		"" ,case when b.noa is null then '表頭遺失' else '' end""+
		"" ,a.productno""+
		"" from ""+@tableas+"" a left join ""+@tablea+"" b on a.noa=b.noa""+
		"" where len(isnull(a.bno,''))>0 and len(isnull(a.waste,''))=0""+
		"" and not(lower(left(a.bno,1))='x' or lower(left(a.bno,1))='y' or lower(left(a.bno,1))='z')""
		
		insert into #z_uccstk(isprice,tablea,accy,noa,noq,datea,uno,mount,cutprice,[weight],memo,productno)
		execute sp_executesql @cmd,N'@accy nvarchar(20)',@accy=@accy
		
		fetch next from cursor_table
		into @tablea,@tableas,@accy
	end
	close cursor_table
	deallocate cursor_table

	----------------------------------------------------------------------------------
	--cub 需再計算成本
	declare cursor_table cursor for
	select tablea,tableas,tableat,tableau,accy from @listcub
	open cursor_table
	fetch next from cursor_table
	into @tablea,@tableas,@tableat,@tableau,@accy
	while(@@FETCH_STATUS <> -1)
	begin
		set @cmd =
		"" select case when (CHARINDEX('代工',b.memo)>0 or CHARINDEX('代工',b.memo2)>0) then 1 else 0 end ""+
		"" ,'cubu',@accy,a.noa,a.noq,a.datea""+
		"" ,a.uno,isnull(a.mount,0),isnull(a.[weight],0)""+
		"" ,case when b.noa is null then '表頭遺失' else '' end""+
		"" ,a.productno""+
		"" ,a.groupa""+
		"" ,0,0,0,0""+
		"" from ""+@tableau+"" a""+
		"" left join ""+@tablea+"" b on a.noa=b.noa""+
		"" where len(isnull(a.uno,''))>0""+
		"" and not(lower(left(a.uno,1))='x' or lower(left(a.uno,1))='y' or lower(left(a.uno,1))='z')""
		
		insert into #z_uccstk(isprice,tablea,accy,noa,noq,datea,uno,mount,[weight],memo,productno,groupa,price,price2,[money],money2)
		execute sp_executesql @cmd,N'@accy nvarchar(20)',@accy=@accy
		
		fetch next from cursor_table
		into @tablea,@tableas,@tableat,@tableau,@accy
	end
	close cursor_table
	deallocate cursor_table
	-----------------------------------------------------------------------------------
	--CNG 的運費要算, 會有一個問題
	--當3月進貨,4月調撥,  3月進貨成本就包含了4月調撥運費
	declare @cng_uno nvarchar(40)
	declare @cng_tranmoney float
	
	declare cursor_table cursor for
	select uno from #z_uccstk
	open cursor_table
	fetch next from cursor_table
	into @cng_uno
	while(@@FETCH_STATUS <> -1)
	begin
		select @cng_tranmoney=0
		select @cng_tranmoney=SUM(isnull(a.[weight],0)*isnull(b.[price],0)) 
		from view_cngs a
		left join view_cng b on a.noa=b.noa
		where b.noa is not null 
		and b.datea <= @t_date
		and a.uno = @cng_uno
		
		update #z_uccstk set [money] = isnull([money],0)+isnull(@cng_tranmoney,0) where uno=@cng_uno
		
		fetch next from cursor_table
		into @cng_uno
	end
	close cursor_table
	deallocate cursor_table
	
	update #z_uccstk set [price] = case when [weight]=0 then 0 else [money]/[weight] end
	-----------------------------------------------------------------------------------
	--批號不能重覆
	if exists(select uno from #z_uccstk group by uno having COUNT(1)>1)
	begin
		declare @err table(
			gno nvarchar(10),
			uno nvarchar(50),
			mount float,
			[weight] decimal(15,2),
			price decimal(15,2),
			[money] float,
			dime float,
			width float,
			lengthb float,
			radius float,
			size nvarchar(max),
			productno nvarchar(max),
			product nvarchar(max),
			class nvarchar(max),
			style nvarchar(10),
			spec nvarchar(max),
			kind nvarchar(10),
			csize nvarchar(max),
			cstyle nvarchar(max),
			memo nvarchar(max)
		)
		insert into @err(gno,uno,memo)
		select '4',uno,'【'+uno+'】批號重覆，請至批號履歷查詢明細。'  from #z_uccstk group by uno having COUNT(1)>1
		select ROW_NUMBER()over(order by isnull(kind,char(255)),isnull(style,char(255)),isnull(productno,char(255)),radius,dime,width,lengthb,uno) rr
		,'' a01,'' a02,'' a03
		,* 
		,style s1
		,productno ppn
		,product ppt
		,ghref = 'z_uno?$uno?'
		from @err
		return
	end
	----怕算太久,只重算365天內的
	--declare @datex nvarchar(20) = dbo.AD2ChineseEraName(dateadd(dd,-999,getdate()))
	--update #z_uccstk set isprice=1 where isprice=0 and datea<@datex
	-----------------------------------------------------------------------------------
	set @n = 5 --製程步驟需小於此數
	declare @noa nvarchar(20)
	declare @noq nvarchar(10)
	declare @buno nvarchar(50)
	declare @gweight float
	declare @bmoney float
	declare @bweight float
	declare @money float
	declare @weight float
	declare @price float
	declare @isprice float
	declare @tranmoney float
	
	declare @weight2 float
	
	declare @bmoney2 float
	declare @money2 float
	declare @price2 float
	declare @productno nvarchar(20)
	
	IF OBJECT_ID('tempdb..#z_uccstk_tmpa')is not null
	BEGIN
		drop table #z_uccstk_tmpa
	END
	create table #z_uccstk_tmpa(
		uno nvarchar(50),
		productno nvarchar(20),
		gweight float,
		isprice int,
		[money] float,
		money2 float
	)
	
	declare @tmpa table(
		tablea nvarchar(20)
		,accy nvarchar(20)
		,noa nvarchar(20)
		,noq nvarchar(10)
		,[weight] float
		,productno nvarchar(20)
		,groupa nvarchar(20)
	)
	----------------------------------------------
	declare @groupa nvarchar(20)
	----------------------------------------------
	update #z_uccstk set groupa=ISNULL(groupa,'')
	update #z_uccstk set memo='製程步驟大於'+CAST(@n as nvarchar)+'，無法找到成本金額。' where isprice=0 and len(isnull(memo,''))=0
	while @n>0
	begin
		---CUT
		declare cursor_table cursor for
		select tablea,accy,noa,noq,[weight] from #z_uccstk where isprice=0 and tablea='cuts'
		open cursor_table
		fetch next from cursor_table
		into @tablea,@accy,@noa,@noq,@weight
		while(@@FETCH_STATUS <> -1)
		begin
			select @buno='',@gweight=0,@tranmoney=0
			set @cmd =
			"" select @buno=uno,@gweight=gweight,@tranmoney=isnull(tranmoney,0) from cut""+@accy+"" where noa=@noa""
			execute sp_executesql @cmd,N'@noa nvarchar(20),@buno nvarchar(50) output,@gweight float output,@tranmoney float output'
			,@noa=@noa,@buno=@buno output,@gweight=@gweight output,@tranmoney=@tranmoney output
			if(len(@buno)=0 or @gweight=0)
			begin
				update #z_uccstk set price=0,[money]=0,memo='裁剪單異常' where tablea=@tablea and accy=@accy and noa=@noa and noq=@noq
			end
			else
			begin
				select @isprice=0,@bweight=0,@bmoney=0,@weight2=0
				--select @isprice=isprice,@bweight=[weight],@bmoney=[money],@bmoney2=ROUND([weight]*ISNULL(price2,0),0) from #z_uccstk where uno=@buno
				select @isprice=isprice,@bweight=@gweight,@bmoney=ROUND(@gweight*ISNULL(price,0),0),@bmoney2=ROUND(@gweight*ISNULL(price2,0),0) from #z_uccstk where uno=@buno
				select @weight2=SUM(ISNULL([weight],0)) from #z_uccstk where noa=@noa and tablea='cuts'
				if(@isprice=1 and ISNULL(@weight2,0)>0)
				begin
					set @money = @tranmoney + case when @weight2=0 then 0 else round(@bmoney*@weight/@weight2,0)end
					set @money2 = case when @weight2=0 then 0 else round(@bmoney2*@weight/@weight2,0)end
					set @price = case when @weight=0 then 0 else @money/@weight end
					set @price2 = case when @weight=0 then 0 else @money2/@weight end
					update #z_uccstk set isprice=1,price=@price+ISNULL(cutprice,0)+ISNULL(price,0),price2=@price2,[money]=@money+(ISNULL(cutprice,0)+ISNULL(price,0))*[weight],money2=@money2,memo='' where tablea=@tablea and accy=@accy and noa=@noa and noq=@noq
				end
			end
			fetch next from cursor_table
			into @tablea,@accy,@noa,@noq,@weight
		end
		close cursor_table
		deallocate cursor_table
		---CUB
		delete @tmpa
		insert into @tmpa
		select tablea,accy,noa,noq,[weight],productno,isnull(groupa,'') 
		from #z_uccstk where isprice=0 and tablea='cubu'
		
		declare cursor_table cursor for
		select * from @tmpa
		open cursor_table
		fetch next from cursor_table
		into @tablea,@accy,@noa,@noq,@weight,@productno,@groupa
		while(@@FETCH_STATUS <> -1)
		begin
			print @tablea+'_'+@accy+'_'+@noa+'_'+@noq
			if exists(select * from #z_uccstk where tablea=@tablea and accy=@accy and noa=@noa and noq=@noq and isprice=0)
			begin	
				delete #z_uccstk_tmpa	
				
				insert into #z_uccstk_tmpa(uno,productno,gweight,isprice,[money],[money2])
				select a.uno,b.productno,a.gweight 
					,ISNULL(c.isprice,0)
					,case when ISNULL(c.[weight],0)=0 then 0 else isnull(a.gweight,0)/ISNULL(c.[weight],0)*isnull(c.[money],0) end
					,case when ISNULL(c.[weight],0)=0 then 0 else isnull(a.gweight,0)/ISNULL(c.[weight],0)*isnull(c.[money2],0) end
				from view_cubt a
				left join view_uccb b on a.uno=b.uno
				left join #z_uccstk c on a.uno=c.uno
				where a.accy=@accy and a.noa=@noa and b.productno=@productno 
					and a.gweight>0  and ISNULL(a.groupa,'')=@groupa
					and b.uno is not null
				--select * from #z_uccstk_tmpa
				--set @cmd =
				--"" select a.uno,b.productno,a.gweight from cubt""+@accy+"" a ""
				--+"" left join view_uccb b on a.uno=b.uno""
				--+"" where a.noa=@noa and b.productno=@productno  and a.gweight>0  and ISNULL(a.groupa,'')=@groupa""
				--insert into #z_uccstk_tmpa(uno,productno,gweight)
				--execute sp_executesql @cmd,N'@noa nvarchar(20),@productno nvarchar(20),@groupa nvarchar(20)',@noa=@noa,@productno=@productno,@groupa=@groupa
	
				--update #z_uccstk_tmpa set isprice=ISNULL(b.isprice,0)
				--	,[money]=case when ISNULL(b.[weight],0)=0 then 0 else isnull(a.gweight,0)/ISNULL(b.[weight],0)*isnull(b.[money],0) end
				--	,[money2]=case when ISNULL(b.[weight],0)=0 then 0 else isnull(a.gweight,0)/ISNULL(b.[weight],0)*isnull(b.[money2],0) end
				--from #z_uccstk_tmpa a
				--left join #z_uccstk b on a.uno=b.uno
				
				if not exists(select top 1 * from #z_uccstk_tmpa where isprice=0) 
				begin
					if exists(select top 1  * from #z_uccstk_tmpa)
					begin
						select @bweight=0,@bmoney=0,@weight=0
						select @bweight=sum(gweight),@bmoney=SUM([money]),@bmoney2=SUM([money2]) from #z_uccstk_tmpa --where productno=@productno 
						select @weight=sum([weight])from #z_uccstk where tablea=@tablea and accy=@accy and noa=@noa and productno=@productno and groupa=@groupa
						--製管的成本攤提,用CUBU的產出重量,不用CUBT的領料重
						--同張CUB一起更新
						update #z_uccstk set isprice=1
						,[money]=case when @weight=0 then 0 else ROUND([weight]/@weight*@bmoney,0)end
						,[money2]=case when @weight=0 then 0 else ROUND([weight]/@weight*@bmoney2,0)end
						,price =case when @weight=0 or [weight]=0 then 0 else Round(ROUND([weight]/@weight*@bmoney,0)/[weight],4) end
						,price2 =case when @weight=0 or [weight]=0 then 0 else Round(ROUND([weight]/@weight*@bmoney2,0)/[weight],4) end
						,memo='' 
						where tablea=@tablea and accy=@accy and noa=@noa and productno=@productno and groupa=@groupa
					end
					else
					begin
						update #z_uccstk set isprice=1,price=0,[money]=0,money2=0
						where tablea=@tablea and accy=@accy and noa=@noa and productno=@productno and groupa=@groupa
					end
				end
			end
			fetch next from cursor_table
			into @tablea,@accy,@noa,@noq,@weight,@productno,@groupa
		end
		close cursor_table
		deallocate cursor_table
		--endcub
		set @n = @n - 1
	end
	drop table #z_uccstk_tmpa
	----------------------------------------------------------------------------------
	--重新入庫,單價無法計算,因此單價異常的改取平均
	update #z_uccstk set productno= b.productno,style=b.style
	from #z_uccstk a
	left join view_uccb b on a.uno=b.uno  
	
	update #z_uccstk set price = case when a.price>=isnull(d.price,0)*0.8 then a.price
							when isnull(d.price,0)!=0 then d.price 
							when isnull(c.price,0)!=0 then c.price
							else a.price end
	from #z_uccstk a  
	outer apply (select AVG(price) price from #z_uccstk where datea<='102/12/31' and a.productno=productno and a.style=style) c
	outer apply (select AVG(price) price from #z_uccstk where datea<='102/12/31' and a.productno=productno and a.style=style and price>=c.price*0.7) d
	left join view_cubu e on a.uno=e.uno
	where (a.style='1' or a.style='2' or a.style='3') and a.price<c.price*0.7 and a.datea<'103/04/01'
	----------------------------------------------------------------------------------
	----------------------------------------------------------------------------------
	--更新CUTS,CUBU SPRICE
	declare cursor_table cursor for
	select tablea,accy,noa,noq,price,price2 from #z_uccstk where tablea='cubu' or tablea='cuts' or tablea='inas' or tablea='rc2s' 
	open cursor_table
	fetch next from cursor_table
	into @tablea,@accy,@noa,@noq,@price,@price2
	while(@@FETCH_STATUS <> -1)
	begin
		set @cmd = 
		"" update ""+@tablea+@accy+"" set sprice=@price,sprice2=@price2""+
		"" where noa=@noa and noq=@noq""
		execute sp_executesql @cmd,N'@noa nvarchar(20),@noq nvarchar(10),@price float,@price2 float'
		,@noa=@noa,@noq=@noq,@price=@price,@price2=@price2
		
		fetch next from cursor_table
		into @tablea,@accy,@noa,@noq,@price,@price2
	end
	close cursor_table
	deallocate cursor_table
	
	--cubt
	declare cursor_table cursor for
	SELECT TABLE_NAME 
	FROM INFORMATION_SCHEMA.TABLES 
	where TABLE_NAME like 'cubt[0-9][0-9][0-9]%' 
	open cursor_table
	fetch next from cursor_table
	into @tablea
	while(@@FETCH_STATUS <> -1)
	begin
		set @cmd = ""update ""+@tablea+"" set sprice=b.sprice
		from ""+@tablea+"" a
		left join view_uccb b on a.uno=b.uno 
		where len(isnull(a.bno,''))>0""
		execute sp_executesql @cmd
		
		fetch next from cursor_table
		into @tablea
	end
	close cursor_table
	deallocate cursor_table
	drop table #z_uccstk
	select 'done' memo;";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.CommandTimeout = 0;
                cmd.Parameters.AddWithValue("@t_date", item.date);
                adapter.SelectCommand = cmd;
                cmd.ExecuteNonQuery(); 
                connSource.Close();
            }
            Response.Write("done");
        }
    </script>