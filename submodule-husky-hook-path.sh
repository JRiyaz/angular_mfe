#!/usr/bin/env bash

if [ ! $PREVENT_WEBHOOKS ]
then
    cd projects/shell && git config core.hooksPath ../../.husky
    cd ../..
    cd projects/user && git config core.hooksPath ../../.husky
    cd ../..
    cd projects/inventory && git config core.hooksPath ../../.husky
fi