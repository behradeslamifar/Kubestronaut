# Traffic management

## Egress
`outboundTrafficPolicy.mode=<ALLOW_ANY|REGISTRY_ONLY>`
`values.global.proxy.includeIPRanges|values.global.proxy.excludeIPRanges`

```bash
istioctl install --set profile=demo \
               --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY \
               --set values.global.proxy.includeIPRanges="10.0.0.1/24" \
               --set meshConfig.accessLogFile=/dev/stdout
```  
