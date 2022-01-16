package events

import (
	"domain"
	"log"
	"net/rpc"
)

const (
	RPCAddress = "localhost:42586"
)

//Enforce interface
var _ domain.RPCClientInterface = (*RPCClient)(nil)

// GoRPCClient is a global to use across api
var GoRPCClient RPCClient

type RPCClient struct {
	client rpc.Client
}

// NewRPCClient instantiates a client for inter process comm
func NewRPCClient() *RPCClient {
	newClient, err := rpc.Dial("tcp", RPCAddress)
	if err != nil {
		log.Fatal(err)
		return nil
	}

	return &RPCClient{
		client: *newClient,
	}
}

//SendMessage send messages to the rpc server
func (c *RPCClient) SendMessage(service string, payload []byte) error {
	var reply bool
	err := c.client.Call(service, payload, &reply)
	if err != nil {
		log.Fatal(err)
		return err
	}
	return nil
}
