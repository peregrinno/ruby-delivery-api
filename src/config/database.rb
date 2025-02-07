require 'mongoid'

# Configuração do logger do Mongoid
Mongoid.logger.level = Logger::INFO
Mongo::Logger.logger.level = Logger::INFO

# Carrega a configuração do Mongoid
Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))

# Tenta estabelecer conexão
begin
  # Verifica a conexão
  Mongoid.default_client.database.command(ping: 1)
  puts "MongoDB conectado com sucesso!"
rescue Mongo::Error => e
  puts "Erro ao conectar ao MongoDB: #{e.message}"
  raise e
end 