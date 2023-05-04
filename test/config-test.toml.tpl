# This is a TOML config file.
# For more information, see https://github.com/toml-lang/toml

###############################################################################
###                           Client Configuration                            ###
###############################################################################

# The network chain ID
chain-id = "{{ .Values.chainId }}"
# The keyring's backend, where the keys are stored (os|file|kwallet|pass|test|memory)
keyring-backend = "{{ .Values.keyringBackend }}"
# CLI output format (text|json)
output = "{{ .Values.output }}"
# <host>:<port> to Tendermint RPC interface for this chain
node = "{{ .Values.node }}"
# Transaction broadcasting mode (sync|async|block)
broadcast-mode = "{{ .Values.broadcastMode }}"