package dshell.core.worker;

import dshell.core.interfaces.Consumer;
import dshell.core.misc.SystemMessage;

public class SocketToProcessThread implements Runnable {
    private volatile InternalBuffer internalBuffer;
    private int inputChannel;
    private Consumer nextOperator;

    public SocketToProcessThread(InternalBuffer internalBuffer, int inputChannel, Consumer nextOperator) {
        this.internalBuffer = internalBuffer;
        this.inputChannel = inputChannel;
        this.nextOperator = nextOperator;
    }

    @Override
    public void run() {
        Object data;

        while (true) {
            // NOTE: internalBuffer.read() is a blocking method
            data = internalBuffer.read();

            if (data instanceof SystemMessage.EndOfData)
                return;
            else {
                // invoking the operator's computation; after the computation, the data is sent via socket to next node
                // if this is split operator the data splitting will be done inside an operator and the data will be
                // outputted to the sockets that were created few lines before this
                nextOperator.next(inputChannel, data);
            }
        }
    }
}