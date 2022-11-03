class PessoasController < ApplicationController
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  # GET /pessoas
  def index
    @pessoas = Pessoa.all
  end

  # GET /pessoas/1
  def show
  end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
  end

  # GET /pessoas/1/edit
  def edit
  end

  # POST /pessoas
  def create
    @pessoa = Pessoa.new(pessoa_params)

    if @pessoa.save
      redirect_to @pessoa, notice: 'Pessoa was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pessoas/1
  def update
    if @pessoa.update(pessoa_params)
      redirect_to @pessoa, notice: 'Pessoa was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pessoas/1
  def destroy
    @pessoa.destroy
    redirect_to pessoas_url, notice: 'Pessoa was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pessoa_params
      params.require(:pessoa).permit(:nome)
    end
end
