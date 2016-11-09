class TransactionController < BaseController


	def save
		@transaction = Transaction.main_query(code: params[:code], 
			quantity: params[:quantity],
			type_t: params[:type],
			data_trans: params[:data_trans],
			client_code: params[:client_code],
			value: params[:value],
			employee: current_employee.id
			)

		if @transaction[:status] == true
			@id_create = @transaction[:message]
			render '/product/transaction' , layout: false
		else
			render html: "<script>
			noty({text: ' #{@transaction[:message]}', layout: 'bottom', type: 'warning', timeout: 4000});
			</script>".html_safe

      	#render js: "noty({text: ' #{@transaction}', layout: 'bottom', type: 'warning', timeout: 4000});"
      end

  end

  def destroy 
  	transaction_d = Transaction.find(params[:id]).update(status_t: 0)
  	redirect_to product_path, notice: 'Feito! Você desfez a sua última ação.'
  end


  def search
  	@departments = Department.all
  	@initial_date = params[:initial_date]
  	@end_date = params[:end_date]
  	@transactions = HistoryQuery.main_query(initial_date: params[:initial_date], 
  		end_date: params[:end_date],
  		type: params[:type],
  		code: params[:code],
  		department: params[:department])
  end


end
