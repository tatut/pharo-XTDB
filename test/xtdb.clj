(require '[xtdb.api :as xt])

(xt/start-node {:xtdb.lucene/lucene-store {}
                :xtdb.http-server/server {:port 6666}})
(println "Started XTDB")

(Thread/sleep (* 1000 60 5)) ; sleep for five minutes

(System/exit 0)
