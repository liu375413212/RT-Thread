#line 1 "..\\..\\src\\src_timer.c"
































 

#line 1 "..\\..\\include\\rtthread.h"





























 




#line 1 "..\\nuvoton_nuc240\\rtconfig.h"
 



 


 


 


 






 
 




 
 

 





 
 


 


 


 


 


 
 


 


 





 
 






 

 






 

 




 



 


 
 


 

 

 

 




 

 


#line 36 "..\\..\\include\\rtthread.h"
#line 1 "..\\..\\include\\rtdebug.h"


















 




#line 25 "..\\..\\include\\rtdebug.h"

 
#line 130 "..\\..\\include\\rtdebug.h"








#line 37 "..\\..\\include\\rtthread.h"
#line 1 "..\\..\\include\\rtdef.h"
































 




 
#line 40 "..\\..\\include\\rtdef.h"







 

 

 




 



 
typedef signed   char                   rt_int8_t;       
typedef signed   short                  rt_int16_t;      
typedef signed   long                   rt_int32_t;      
typedef unsigned char                   rt_uint8_t;      
typedef unsigned short                  rt_uint16_t;     
typedef unsigned long                   rt_uint32_t;     
typedef int                             rt_bool_t;       

 
typedef long                            rt_base_t;       
typedef unsigned long                   rt_ubase_t;      

typedef rt_base_t                       rt_err_t;        
typedef rt_uint32_t                     rt_time_t;       
typedef rt_uint32_t                     rt_tick_t;       
typedef rt_base_t                       rt_flag_t;       
typedef rt_ubase_t                      rt_size_t;       
typedef rt_ubase_t                      rt_dev_t;        
typedef rt_base_t                       rt_off_t;        

 



 

 





 
#line 1 "C:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdarg.h"
 
 
 





 










#line 27 "C:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdarg.h"








 

 
 
#line 57 "C:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdarg.h"
    typedef struct __va_list { void *__ap; } va_list;

   






 


   










 


   















 




   

 


   




 



   





 







#line 138 "C:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdarg.h"



#line 147 "C:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdarg.h"

 

#line 96 "..\\..\\include\\rtdef.h"
#line 102 "..\\..\\include\\rtdef.h"
     






#line 173 "..\\..\\include\\rtdef.h"

 

typedef int (*init_fn_t)(void);
#line 198 "..\\..\\include\\rtdef.h"

 

 
 

 

 

 

 


#line 224 "..\\..\\include\\rtdef.h"

 


 




 














 

 

 
#line 262 "..\\..\\include\\rtdef.h"

 







 








 







 


struct rt_list_node
{
    struct rt_list_node *next;                           
    struct rt_list_node *prev;                           
};
typedef struct rt_list_node rt_list_t;                   



 

 



 




 
struct rt_object
{
    char       name[8];                        
    rt_uint8_t type;                                     
    rt_uint8_t flag;                                     




    rt_list_t  list;                                     
};
typedef struct rt_object *rt_object_t;                   

















 
enum rt_object_class_type
{
    RT_Object_Class_Thread = 0,                          

    RT_Object_Class_Semaphore,                           


    RT_Object_Class_Mutex,                               


    RT_Object_Class_Event,                               


    RT_Object_Class_MailBox,                             


    RT_Object_Class_MessageQueue,                        





    RT_Object_Class_MemPool,                             


    RT_Object_Class_Device,                              

    RT_Object_Class_Timer,                               



    RT_Object_Class_Unknown,                             
    RT_Object_Class_Static = 0x80                        
};



 
struct rt_object_information
{
    enum rt_object_class_type type;                      
    rt_list_t                 object_list;               
    rt_size_t                 object_size;               
};



 
#line 396 "..\\..\\include\\rtdef.h"

 



 

 



 

















 






 
struct rt_timer
{
    struct rt_object parent;                             

    rt_list_t        row[1];

    void (*timeout_func)(void *parameter);               
    void            *parameter;                          

    rt_tick_t        init_tick;                          
    rt_tick_t        timeout_tick;                       
};
typedef struct rt_timer *rt_timer_t;

 



 

 



 



 
#line 468 "..\\..\\include\\rtdef.h"



 







 
struct rt_thread
{
     
    char        name[8];                       
    rt_uint8_t  type;                                    
    rt_uint8_t  flags;                                   





    rt_list_t   list;                                    
    rt_list_t   tlist;                                   

     
    void       *sp;                                      
    void       *entry;                                   
    void       *parameter;                               
    void       *stack_addr;                              
    rt_uint32_t stack_size;                              

     
    rt_err_t    error;                                   

    rt_uint8_t  stat;                                    

     
    rt_uint8_t  current_priority;                        
    rt_uint8_t  init_priority;                           




    rt_uint32_t number_mask;


     
    rt_uint32_t event_set;
    rt_uint8_t  event_info;


    rt_ubase_t  init_tick;                               
    rt_ubase_t  remaining_tick;                          

    struct rt_timer thread_timer;                        

    void (*cleanup)(struct rt_thread *tid);              

    rt_uint32_t user_data;                               
};
typedef struct rt_thread *rt_thread_t;

 



 

 



 











 
struct rt_ipc_object
{
    struct rt_object parent;                             

    rt_list_t        suspend_thread;                     
};




 
struct rt_semaphore
{
    struct rt_ipc_object parent;                         

    rt_uint16_t          value;                          
};
typedef struct rt_semaphore *rt_sem_t;





 
struct rt_mutex
{
    struct rt_ipc_object parent;                         

    rt_uint16_t          value;                          

    rt_uint8_t           original_priority;              
    rt_uint8_t           hold;                           

    struct rt_thread    *owner;                          
};
typedef struct rt_mutex *rt_mutex_t;





 






 
struct rt_event
{
    struct rt_ipc_object parent;                         

    rt_uint32_t          set;                            
};
typedef struct rt_event *rt_event_t;





 
struct rt_mailbox
{
    struct rt_ipc_object parent;                         

    rt_uint32_t         *msg_pool;                       

    rt_uint16_t          size;                           

    rt_uint16_t          entry;                          
    rt_uint16_t          in_offset;                      
    rt_uint16_t          out_offset;                     

    rt_list_t            suspend_sender_thread;          
};
typedef struct rt_mailbox *rt_mailbox_t;





 
struct rt_messagequeue
{
    struct rt_ipc_object parent;                         

    void                *msg_pool;                       

    rt_uint16_t          msg_size;                       
    rt_uint16_t          max_msgs;                       

    rt_uint16_t          entry;                          

    void                *msg_queue_head;                 
    void                *msg_queue_tail;                 
    void                *msg_queue_free;                 
};
typedef struct rt_messagequeue *rt_mq_t;


 



 

 




 

#line 706 "..\\..\\include\\rtdef.h"




 
struct rt_mempool
{
    struct rt_object parent;                             

    void            *start_address;                      
    rt_size_t        size;                               

    rt_size_t        block_size;                         
    rt_uint8_t      *block_list;                         

    rt_size_t        block_total_count;                  
    rt_size_t        block_free_count;                   

    rt_list_t        suspend_thread;                     
    rt_size_t        suspend_thread_count;               
};
typedef struct rt_mempool *rt_mp_t;


 




 

 



 
enum rt_device_class_type
{
    RT_Device_Class_Char = 0,                            
    RT_Device_Class_Block,                               
    RT_Device_Class_NetIf,                               
    RT_Device_Class_MTD,                                 
    RT_Device_Class_CAN,                                 
    RT_Device_Class_RTC,                                 
    RT_Device_Class_Sound,                               
    RT_Device_Class_Graphic,                             
    RT_Device_Class_I2CBUS,                              
    RT_Device_Class_USBDevice,                           
    RT_Device_Class_USBHost,                             
    RT_Device_Class_SPIBUS,                              
    RT_Device_Class_SPIDevice,                           
    RT_Device_Class_SDIO,                                
    RT_Device_Class_PM,                                  
    RT_Device_Class_Pipe,                                
    RT_Device_Class_Portal,                              
    RT_Device_Class_Timer,                               
	RT_Device_Class_Miscellaneous,                       
	RT_Device_Class_Unknown                              
};



 






























 





 
#line 817 "..\\..\\include\\rtdef.h"

typedef struct rt_device *rt_device_t;


 
struct rt_device
{
    struct rt_object          parent;                    

    enum rt_device_class_type type;                      
    rt_uint16_t               flag;                      
    rt_uint16_t               open_flag;                 

    rt_uint8_t                ref_count;                 
    rt_uint8_t                device_id;                 

     
    rt_err_t (*rx_indicate)(rt_device_t dev, rt_size_t size);
    rt_err_t (*tx_complete)(rt_device_t dev, void *buffer);

     
    rt_err_t  (*init)   (rt_device_t dev);
    rt_err_t  (*open)   (rt_device_t dev, rt_uint16_t oflag);
    rt_err_t  (*close)  (rt_device_t dev);
    rt_size_t (*read)   (rt_device_t dev, rt_off_t pos, void *buffer, rt_size_t size);
    rt_size_t (*write)  (rt_device_t dev, rt_off_t pos, const void *buffer, rt_size_t size);
    rt_err_t  (*control)(rt_device_t dev, rt_uint8_t cmd, void *args);

    void                     *user_data;                 
};



 
struct rt_device_blk_geometry
{
    rt_uint32_t sector_count;                            
    rt_uint32_t bytes_per_sector;                        
    rt_uint32_t block_size;                              
};



 
struct rt_device_blk_sectors
{
    rt_uint32_t sector_begin;                            
    rt_uint32_t sector_end;                              
};



 





 
#line 882 "..\\..\\include\\rtdef.h"

 
enum
{
    RTGRAPHIC_PIXEL_FORMAT_MONO = 0,
    RTGRAPHIC_PIXEL_FORMAT_GRAY4,
    RTGRAPHIC_PIXEL_FORMAT_GRAY16,
    RTGRAPHIC_PIXEL_FORMAT_RGB332,
    RTGRAPHIC_PIXEL_FORMAT_RGB444,
    RTGRAPHIC_PIXEL_FORMAT_RGB565,
    RTGRAPHIC_PIXEL_FORMAT_RGB565P,
    RTGRAPHIC_PIXEL_FORMAT_BGR565 = RTGRAPHIC_PIXEL_FORMAT_RGB565P,
    RTGRAPHIC_PIXEL_FORMAT_RGB666,
    RTGRAPHIC_PIXEL_FORMAT_RGB888,
    RTGRAPHIC_PIXEL_FORMAT_ARGB888,
    RTGRAPHIC_PIXEL_FORMAT_ABGR888,
    RTGRAPHIC_PIXEL_FORMAT_ARGB565,
    RTGRAPHIC_PIXEL_FORMAT_ALPHA,
};



 




 
struct rt_device_graphic_info
{
    rt_uint8_t  pixel_format;                            
    rt_uint8_t  bits_per_pixel;                          
    rt_uint16_t reserved;                                

    rt_uint16_t width;                                   
    rt_uint16_t height;                                  

    rt_uint8_t *framebuffer;                             
};



 
struct rt_device_rect_info
{
    rt_uint16_t x;                                       
    rt_uint16_t y;                                       
    rt_uint16_t width;                                   
    rt_uint16_t height;                                  
};



 
struct rt_device_graphic_ops
{
    void (*set_pixel) (const char *pixel, int x, int y);
    void (*get_pixel) (char *pixel, int x, int y);

    void (*draw_hline)(const char *pixel, int x1, int x2, int y);
    void (*draw_vline)(const char *pixel, int x, int y1, int y2);

    void (*blit_line) (const char *pixel, int x, int y, rt_size_t size);
};


 


#line 1001 "..\\..\\include\\rtdef.h"





#line 38 "..\\..\\include\\rtthread.h"
#line 1 "..\\..\\include\\rtservice.h"

























 










 

 



 






 
static __inline void rt_list_init(rt_list_t *l)
{
    l->next = l->prev = l;
}






 
static __inline void rt_list_insert_after(rt_list_t *l, rt_list_t *n)
{
    l->next->prev = n;
    n->next = l->next;

    l->next = n;
    n->prev = l;
}






 
static __inline void rt_list_insert_before(rt_list_t *l, rt_list_t *n)
{
    l->prev->next = n;
    n->prev = l->prev;

    l->prev = n;
    n->next = l;
}




 
static __inline void rt_list_remove(rt_list_t *n)
{
    n->next->prev = n->prev;
    n->prev->next = n->next;

    n->next = n->prev = n;
}




 
static __inline int rt_list_isempty(const rt_list_t *l)
{
    return l->next == l;
}






 








 












 


 





#line 39 "..\\..\\include\\rtthread.h"
#line 1 "..\\..\\include\\rtm.h"


















 




#line 25 "..\\..\\include\\rtm.h"
#line 1 "..\\..\\include\\rtthread.h"





























 

#line 26 "..\\..\\include\\rtm.h"

#line 56 "..\\..\\include\\rtm.h"

#line 40 "..\\..\\include\\rtthread.h"







 

 



 
void rt_system_object_init(void);
struct rt_object_information *
rt_object_get_information(enum rt_object_class_type type);
void rt_object_init(struct rt_object         *object,
                    enum rt_object_class_type type,
                    const char               *name);
void rt_object_detach(rt_object_t object);
rt_object_t rt_object_allocate(enum rt_object_class_type type,
                               const char               *name);
void rt_object_delete(rt_object_t object);
rt_bool_t rt_object_is_systemobject(rt_object_t object);
rt_object_t rt_object_find(const char *name, rt_uint8_t type);

#line 74 "..\\..\\include\\rtthread.h"

 



 

 



 
void rt_system_tick_init(void);
rt_tick_t rt_tick_get(void);
void rt_tick_set(rt_tick_t tick);
void rt_tick_increase(void);
rt_tick_t rt_tick_from_millisecond(rt_uint32_t ms);

void rt_system_timer_init(void);
void rt_system_timer_thread_init(void);

void rt_timer_init(rt_timer_t  timer,
                   const char *name,
                   void (*timeout)(void *parameter),
                   void       *parameter,
                   rt_tick_t   time,
                   rt_uint8_t  flag);
rt_err_t rt_timer_detach(rt_timer_t timer);
rt_timer_t rt_timer_create(const char *name,
                           void (*timeout)(void *parameter),
                           void       *parameter,
                           rt_tick_t   time,
                           rt_uint8_t  flag);
rt_err_t rt_timer_delete(rt_timer_t timer);
rt_err_t rt_timer_start(rt_timer_t timer);
rt_err_t rt_timer_stop(rt_timer_t timer);
rt_err_t rt_timer_control(rt_timer_t timer, rt_uint8_t cmd, void *arg);

rt_tick_t rt_timer_next_timeout_tick(void);
void rt_timer_check(void);





 



 

 



 
rt_err_t rt_thread_init(struct rt_thread *thread,
                        const char       *name,
                        void (*entry)(void *parameter),
                        void             *parameter,
                        void             *stack_start,
                        rt_uint32_t       stack_size,
                        rt_uint8_t        priority,
                        rt_uint32_t       tick);
rt_err_t rt_thread_detach(rt_thread_t thread);
rt_thread_t rt_thread_create(const char *name,
                             void (*entry)(void *parameter),
                             void       *parameter,
                             rt_uint32_t stack_size,
                             rt_uint8_t  priority,
                             rt_uint32_t tick);
rt_thread_t rt_thread_self(void);
rt_thread_t rt_thread_find(char *name);
rt_err_t rt_thread_startup(rt_thread_t thread);
rt_err_t rt_thread_delete(rt_thread_t thread);

rt_err_t rt_thread_yield(void);
rt_err_t rt_thread_delay(rt_tick_t tick);
rt_err_t rt_thread_control(rt_thread_t thread, rt_uint8_t cmd, void *arg);
rt_err_t rt_thread_suspend(rt_thread_t thread);
rt_err_t rt_thread_resume(rt_thread_t thread);
void rt_thread_timeout(void *parameter);









 
void rt_thread_idle_init(void);



void rt_thread_idle_excute(void);
rt_thread_t rt_thread_idle_gethandler(void);



 
void rt_system_scheduler_init(void);
void rt_system_scheduler_start(void);

void rt_schedule(void);
void rt_schedule_insert_thread(struct rt_thread *thread);
void rt_schedule_remove_thread(struct rt_thread *thread);

void rt_enter_critical(void);
void rt_exit_critical(void);
rt_uint16_t rt_critical_level(void);





 



 

 



 



 
rt_err_t rt_mp_init(struct rt_mempool *mp,
                    const char        *name,
                    void              *start,
                    rt_size_t          size,
                    rt_size_t          block_size);
rt_err_t rt_mp_detach(struct rt_mempool *mp);
rt_mp_t rt_mp_create(const char *name,
                     rt_size_t   block_count,
                     rt_size_t   block_size);
rt_err_t rt_mp_delete(rt_mp_t mp);

void *rt_mp_alloc(rt_mp_t mp, rt_int32_t time);
void rt_mp_free(void *block);











 
void rt_system_heap_init(void *begin_addr, void *end_addr);

void *rt_malloc(rt_size_t nbytes);
void rt_free(void *ptr);
void *rt_realloc(void *ptr, rt_size_t nbytes);
void *rt_calloc(rt_size_t count, rt_size_t size);
void *rt_malloc_align(rt_size_t size, rt_size_t align);
void rt_free_align(void *ptr);

void rt_memory_info(rt_uint32_t *total,
                    rt_uint32_t *used,
                    rt_uint32_t *max_used);













#line 269 "..\\..\\include\\rtthread.h"

 



 

 




 
rt_err_t rt_sem_init(rt_sem_t    sem,
                     const char *name,
                     rt_uint32_t value,
                     rt_uint8_t  flag);
rt_err_t rt_sem_detach(rt_sem_t sem);
rt_sem_t rt_sem_create(const char *name, rt_uint32_t value, rt_uint8_t flag);
rt_err_t rt_sem_delete(rt_sem_t sem);

rt_err_t rt_sem_take(rt_sem_t sem, rt_int32_t time);
rt_err_t rt_sem_trytake(rt_sem_t sem);
rt_err_t rt_sem_release(rt_sem_t sem);
rt_err_t rt_sem_control(rt_sem_t sem, rt_uint8_t cmd, void *arg);





 
rt_err_t rt_mutex_init(rt_mutex_t mutex, const char *name, rt_uint8_t flag);
rt_err_t rt_mutex_detach(rt_mutex_t mutex);
rt_mutex_t rt_mutex_create(const char *name, rt_uint8_t flag);
rt_err_t rt_mutex_delete(rt_mutex_t mutex);

rt_err_t rt_mutex_take(rt_mutex_t mutex, rt_int32_t time);
rt_err_t rt_mutex_release(rt_mutex_t mutex);
rt_err_t rt_mutex_control(rt_mutex_t mutex, rt_uint8_t cmd, void *arg);





 
rt_err_t rt_event_init(rt_event_t event, const char *name, rt_uint8_t flag);
rt_err_t rt_event_detach(rt_event_t event);
rt_event_t rt_event_create(const char *name, rt_uint8_t flag);
rt_err_t rt_event_delete(rt_event_t event);

rt_err_t rt_event_send(rt_event_t event, rt_uint32_t set);
rt_err_t rt_event_recv(rt_event_t   event,
                       rt_uint32_t  set,
                       rt_uint8_t   opt,
                       rt_int32_t   timeout,
                       rt_uint32_t *recved);
rt_err_t rt_event_control(rt_event_t event, rt_uint8_t cmd, void *arg);





 
rt_err_t rt_mb_init(rt_mailbox_t mb,
                    const char  *name,
                    void        *msgpool,
                    rt_size_t    size,
                    rt_uint8_t   flag);
rt_err_t rt_mb_detach(rt_mailbox_t mb);
rt_mailbox_t rt_mb_create(const char *name, rt_size_t size, rt_uint8_t flag);
rt_err_t rt_mb_delete(rt_mailbox_t mb);

rt_err_t rt_mb_send(rt_mailbox_t mb, rt_uint32_t value);
rt_err_t rt_mb_send_wait(rt_mailbox_t mb,
                         rt_uint32_t  value,
                         rt_int32_t   timeout);
rt_err_t rt_mb_recv(rt_mailbox_t mb, rt_uint32_t *value, rt_int32_t timeout);
rt_err_t rt_mb_control(rt_mailbox_t mb, rt_uint8_t cmd, void *arg);





 
rt_err_t rt_mq_init(rt_mq_t     mq,
                    const char *name,
                    void       *msgpool,
                    rt_size_t   msg_size,
                    rt_size_t   pool_size,
                    rt_uint8_t  flag);
rt_err_t rt_mq_detach(rt_mq_t mq);
rt_mq_t rt_mq_create(const char *name,
                     rt_size_t   msg_size,
                     rt_size_t   max_msgs,
                     rt_uint8_t  flag);
rt_err_t rt_mq_delete(rt_mq_t mq);

rt_err_t rt_mq_send(rt_mq_t mq, void *buffer, rt_size_t size);
rt_err_t rt_mq_urgent(rt_mq_t mq, void *buffer, rt_size_t size);
rt_err_t rt_mq_recv(rt_mq_t    mq,
                    void      *buffer,
                    rt_size_t  size,
                    rt_int32_t timeout);
rt_err_t rt_mq_control(rt_mq_t mq, rt_uint8_t cmd, void *arg);


 




 

 



 
rt_device_t rt_device_find(const char *name);

rt_err_t rt_device_register(rt_device_t dev,
                            const char *name,
                            rt_uint16_t flags);
rt_err_t rt_device_unregister(rt_device_t dev);
rt_err_t rt_device_init_all(void);

rt_err_t
rt_device_set_rx_indicate(rt_device_t dev,
                          rt_err_t (*rx_ind)(rt_device_t dev, rt_size_t size));
rt_err_t
rt_device_set_tx_complete(rt_device_t dev,
                          rt_err_t (*tx_done)(rt_device_t dev, void *buffer));

rt_err_t  rt_device_init (rt_device_t dev);
rt_err_t  rt_device_open (rt_device_t dev, rt_uint16_t oflag);
rt_err_t  rt_device_close(rt_device_t dev);
rt_size_t rt_device_read (rt_device_t dev,
                          rt_off_t    pos,
                          void       *buffer,
                          rt_size_t   size);
rt_size_t rt_device_write(rt_device_t dev,
                          rt_off_t    pos,
                          const void *buffer,
                          rt_size_t   size);
rt_err_t  rt_device_control(rt_device_t dev, rt_uint8_t cmd, void *arg);

 


#line 455 "..\\..\\include\\rtthread.h"



 



 
void rt_interrupt_enter(void);
void rt_interrupt_leave(void);



 
rt_uint8_t rt_interrupt_get_nest(void);







void rt_components_init(void);
void rt_components_board_init(void);




 

 



 




void rt_kprintf(const char *fmt, ...);
void rt_kputs(const char *str);

rt_int32_t rt_vsprintf(char *dest, const char *format, va_list arg_ptr);
rt_int32_t rt_vsnprintf(char *buf, rt_size_t size, const char *fmt, va_list args);
rt_int32_t rt_sprintf(char *buf ,const char *format, ...);
rt_int32_t rt_snprintf(char *buf, rt_size_t size, const char *format, ...);


rt_device_t rt_console_set_device(const char *name);
rt_device_t rt_console_get_device(void);


rt_err_t rt_get_errno(void);
void rt_set_errno(rt_err_t no);
int *_rt_errno(void);






void *rt_memset(void *src, int c, rt_ubase_t n);
void *rt_memcpy(void *dest, const void *src, rt_ubase_t n);

rt_int32_t rt_strncmp(const char *cs, const char *ct, rt_ubase_t count);
rt_int32_t rt_strcmp (const char *cs, const char *ct);
rt_size_t rt_strlen (const char *src);
char *rt_strdup(const char *s);

char *rt_strstr(const char *str1, const char *str2);
rt_int32_t rt_sscanf(const char *buf, const char *fmt, ...);
char *rt_strncpy(char *dest, const char *src, rt_ubase_t n);
void *rt_memmove(void *dest, const void *src, rt_ubase_t n);
rt_int32_t rt_memcmp(const void *cs, const void *ct, rt_ubase_t count);
rt_uint32_t rt_strcasecmp(const char *a, const char *b);

void rt_show_version(void);

#line 539 "..\\..\\include\\rtthread.h"

 





#line 36 "..\\..\\src\\src_timer.c"
#line 1 "..\\..\\include\\rthw.h"

























 




#line 32 "..\\..\\include\\rthw.h"







 
void rt_hw_cpu_icache_enable(void);
void rt_hw_cpu_icache_disable(void);
rt_base_t rt_hw_cpu_icache_status(void);
void rt_hw_cpu_dcache_enable(void);
void rt_hw_cpu_dcache_disable(void);
rt_base_t rt_hw_cpu_dcache_status(void);
void rt_hw_cpu_reset(void);
void rt_hw_cpu_shutdown(void);

rt_uint8_t *rt_hw_stack_init(void       *entry,
                             void       *parameter,
                             rt_uint8_t *stack_addr,
                             void       *exit);



 
typedef void (*rt_isr_handler_t)(int vector, void *param);

struct rt_irq_desc
{
    rt_isr_handler_t handler;
    void            *param;





};



 
void rt_hw_interrupt_init(void);
void rt_hw_interrupt_mask(int vector);
void rt_hw_interrupt_umask(int vector);
rt_isr_handler_t rt_hw_interrupt_install(int              vector,
                                         rt_isr_handler_t handler,
                                         void            *param,
                                         char            *name);

rt_base_t rt_hw_interrupt_disable(void);
void rt_hw_interrupt_enable(rt_base_t level);



 
void rt_hw_context_switch(rt_uint32_t from, rt_uint32_t to);
void rt_hw_context_switch_to(rt_uint32_t to);
void rt_hw_context_switch_interrupt(rt_uint32_t from, rt_uint32_t to);

void rt_hw_console_output(const char *str);

void rt_hw_backtrace(rt_uint32_t *fp, rt_uint32_t thread_entry);
void rt_hw_show_memory(rt_uint32_t addr, rt_uint32_t size);



 
void rt_hw_exception_install(rt_err_t (*exception_handle)(void *context));





#line 37 "..\\..\\src\\src_timer.c"

 
static rt_list_t rt_timer_list[1];










 
static rt_list_t rt_soft_timer_list[1];
static struct rt_thread timer_thread;
__attribute__((aligned(4)))
static rt_uint8_t timer_thread_stack[512];


#line 81 "..\\..\\src\\src_timer.c"

static void _rt_timer_init(rt_timer_t timer,
                           void (*timeout)(void *parameter),
                           void      *parameter,
                           rt_tick_t  time,
                           rt_uint8_t flag)
{
    int i;

     
    timer->parent.flag  = flag;

     
    timer->parent.flag &= ~0x1;

    timer->timeout_func = timeout;
    timer->parameter    = parameter;

    timer->timeout_tick = 0;
    timer->init_tick    = time;

     
    for (i = 0; i < 1; i++)
    {
        rt_list_init(&(timer->row[i]));
    }
}

 
static rt_tick_t rt_timer_list_next_timeout(rt_list_t timer_list[])
{
    struct rt_timer *timer;

    if (rt_list_isempty(&timer_list[1 - 1]))
        return 0xffffffff;

    timer = ((struct rt_timer *)((char *)(timer_list[1 - 1]. next) - (unsigned long)(&((struct rt_timer *)0)->row[1 - 1])));


    return timer->timeout_tick;
}

static __inline void _rt_timer_remove(rt_timer_t timer)
{
    int i;

    for (i = 0; i < 1; i++)
    {
        rt_list_remove(&timer->row[i]);
    }
}

#line 162 "..\\..\\src\\src_timer.c"



 

 











 
void rt_timer_init(rt_timer_t  timer,
                   const char *name,
                   void (*timeout)(void *parameter),
                   void       *parameter,
                   rt_tick_t   time,
                   rt_uint8_t  flag)
{
     
    ;

     
    rt_object_init((rt_object_t)timer, RT_Object_Class_Timer, name);

    _rt_timer_init(timer, timeout, parameter, time, flag);
}
;







 
rt_err_t rt_timer_detach(rt_timer_t timer)
{
    register rt_base_t level;

     
    ;

     
    level = rt_hw_interrupt_disable();

    _rt_timer_remove(timer);

     
    rt_hw_interrupt_enable(level);

    rt_object_detach((rt_object_t)timer);

    return -0;
}
;












 
rt_timer_t rt_timer_create(const char *name,
                           void (*timeout)(void *parameter),
                           void       *parameter,
                           rt_tick_t   time,
                           rt_uint8_t  flag)
{
    struct rt_timer *timer;

     
    timer = (struct rt_timer *)rt_object_allocate(RT_Object_Class_Timer, name);
    if (timer == (0))
    {
        return (0);
    }

    _rt_timer_init(timer, timeout, parameter, time, flag);

    return timer;
}
;







 
rt_err_t rt_timer_delete(rt_timer_t timer)
{
    register rt_base_t level;

     
    ;

     
    level = rt_hw_interrupt_disable();

    _rt_timer_remove(timer);

     
    rt_hw_interrupt_enable(level);

    rt_object_delete((rt_object_t)timer);

    return -0;
}
;








 
rt_err_t rt_timer_start(rt_timer_t timer)
{
    unsigned int row_lvl;
    rt_list_t *timer_list;
    register rt_base_t level;
    rt_list_t *row_head[1];
    unsigned int tst_nr;
    static unsigned int random_nr;

     
    ;

	 
	level = rt_hw_interrupt_disable();
	 
    _rt_timer_remove(timer);
     
    timer->parent.flag &= ~0x1;
    rt_hw_interrupt_enable(level);

    ;

    


 
    ;
    timer->timeout_tick = rt_tick_get() + timer->init_tick;

     
    level = rt_hw_interrupt_disable();


    if (timer->parent.flag & 0x4)
    {
         
        timer_list = rt_soft_timer_list;
    }
    else

    {
         
        timer_list = rt_timer_list;
    }

    row_head[0]  = &timer_list[0];
    for (row_lvl = 0; row_lvl < 1; row_lvl++)
    {
        for (;row_head[row_lvl] != timer_list[row_lvl].prev;
             row_head[row_lvl]  = row_head[row_lvl]->next)
        {
            struct rt_timer *t;
            rt_list_t *p = row_head[row_lvl]->next;

             
            t = ((struct rt_timer *)((char *)(p) - (unsigned long)(&((struct rt_timer *)0)->row[row_lvl])));

            



 
            if ((t->timeout_tick - timer->timeout_tick) == 0)
            {
                continue;
            }
            else if ((t->timeout_tick - timer->timeout_tick) < 0xffffffff / 2)
            {
                break;
            }
        }
        if (row_lvl != 1 - 1)
            row_head[row_lvl+1] = row_head[row_lvl]+1;
    }

    


 
    random_nr++;
    tst_nr = random_nr;

    rt_list_insert_after(row_head[1-1],
                         &(timer->row[1-1]));
    for (row_lvl = 2; row_lvl <= 1; row_lvl++)
    {
        if (!(tst_nr & 0x3))
            rt_list_insert_after(row_head[1 - row_lvl],
                                 &(timer->row[1 - row_lvl]));
        else
            break;
        
 
        tst_nr >>= (0x3+1)>>1;
    }

    timer->parent.flag |= 0x1;

     
    rt_hw_interrupt_enable(level);


    if (timer->parent.flag & 0x4)
    {
         
        if (timer_thread.stat != 0x01)
        {
             
            rt_thread_resume(&timer_thread);
            rt_schedule();
        }
    }


    return -0;
}
;







 
rt_err_t rt_timer_stop(rt_timer_t timer)
{
    register rt_base_t level;

     
    ;
    if (!(timer->parent.flag & 0x1))
        return -1;

    ;

     
    level = rt_hw_interrupt_disable();

    _rt_timer_remove(timer);

     
    rt_hw_interrupt_enable(level);

     
    timer->parent.flag &= ~0x1;

    return 0;
}
;









 
rt_err_t rt_timer_control(rt_timer_t timer, rt_uint8_t cmd, void *arg)
{
     
    ;

    switch (cmd)
    {
    case 0x1:
        *(rt_tick_t *)arg = timer->init_tick;
        break;

    case 0x0:
        timer->init_tick = *(rt_tick_t *)arg;
        break;

    case 0x2:
        timer->parent.flag &= ~0x2;
        break;

    case 0x3:
        timer->parent.flag |= 0x2;
        break;
    }

    return 0;
}
;






 
void rt_timer_check(void)
{
    struct rt_timer *t;
    rt_tick_t current_tick;
    register rt_base_t level;

    ;

    current_tick = rt_tick_get();

     
    level = rt_hw_interrupt_disable();

    while (!rt_list_isempty(&rt_timer_list[1-1]))
    {
        t = ((struct rt_timer *)((char *)(rt_timer_list[1 - 1]. next) - (unsigned long)(&((struct rt_timer *)0)->row[1 - 1])));


        


 
        if ((current_tick - t->timeout_tick) < 0xffffffff/2)
        {
            ;

             
            _rt_timer_remove(t);

             
            t->timeout_func(t->parameter);

             
            current_tick = rt_tick_get();

            ;

            if ((t->parent.flag & 0x2) &&
                (t->parent.flag & 0x1))
            {
                 
                t->parent.flag &= ~0x1;
                rt_timer_start(t);
            }
            else
            {
                 
                t->parent.flag &= ~0x1;
            }
        }
        else
            break;
    }

     
    rt_hw_interrupt_enable(level);

    ;
}





 
rt_tick_t rt_timer_next_timeout_tick(void)
{
    return rt_timer_list_next_timeout(rt_timer_list);
}





 
void rt_soft_timer_check(void)
{
    rt_tick_t current_tick;
    rt_list_t *n;
    struct rt_timer *t;

    ;

    current_tick = rt_tick_get();

	 
	rt_enter_critical();

    for (n = rt_soft_timer_list[1-1].next;
         n != &(rt_soft_timer_list[1-1]);)
    {
        t = ((struct rt_timer *)((char *)(n) - (unsigned long)(&((struct rt_timer *)0)->row[1-1])));

        


 
        if ((current_tick - t->timeout_tick) < 0xffffffff / 2)
        {
            ;

             
            n = n->next;

             
            _rt_timer_remove(t);

			 
			rt_exit_critical();
             
            t->timeout_func(t->parameter);

             
            current_tick = rt_tick_get();

            ;

			 
			rt_enter_critical();

            if ((t->parent.flag & 0x2) &&
                (t->parent.flag & 0x1))
            {
                 
                t->parent.flag &= ~0x1;
                rt_timer_start(t);
            }
            else
            {
                 
                t->parent.flag &= ~0x1;
            }
        }
        else break;  
    }

	 
	rt_exit_critical();

    ;
}

 
static void rt_thread_timer_entry(void *parameter)
{
    rt_tick_t next_timeout;

    while (1)
    {
         
        next_timeout = rt_timer_list_next_timeout(rt_soft_timer_list);
        if (next_timeout == 0xffffffff)
        {
             
            rt_thread_suspend(rt_thread_self());
            rt_schedule();
        }
        else
        {
            rt_tick_t current_tick;

             
            current_tick = rt_tick_get();

            if ((next_timeout - current_tick) < 0xffffffff/2)
            {
                 
                next_timeout = next_timeout - current_tick;
                rt_thread_delay(next_timeout);
            }
        }

         
        rt_soft_timer_check();
    }
}






 
void rt_system_timer_init(void)
{
    int i;

    for (i = 0; i < sizeof(rt_timer_list)/sizeof(rt_timer_list[0]); i++)
    {
        rt_list_init(rt_timer_list+i);
    }
}





 
void rt_system_timer_thread_init(void)
{

    int i;

    for (i = 0;
         i < sizeof(rt_soft_timer_list)/sizeof(rt_soft_timer_list[0]);
         i++)
    {
        rt_list_init(rt_soft_timer_list+i);
    }

     
    rt_thread_init(&timer_thread,
                   "timer",
                   rt_thread_timer_entry,
                   (0),
                   &timer_thread_stack[0],
                   sizeof(timer_thread_stack),
                   4,
                   10);

     
    rt_thread_startup(&timer_thread);

}

 
