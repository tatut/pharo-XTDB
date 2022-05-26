(require '[xtdb.api :as xt])

(xt/start-node {:xtdb.lucene/lucene-store {}
                :xtdb.http-server/server {:port 6666}})
(println "Started XTDB")

(read)

(System/exit 0)
