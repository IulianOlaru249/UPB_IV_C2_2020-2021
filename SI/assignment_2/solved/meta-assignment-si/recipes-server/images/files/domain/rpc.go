package domain

//RPCClientInterface models the behaviour of an RPC Client
type RPCClientInterface interface {
	SendMessage(service string, payload []byte) error
}
